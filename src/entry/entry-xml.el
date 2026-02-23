;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; XML entry ノード → hbw-entry オブジェクト変換
;;
;; はてなブログ AtomPub API のレスポンス XML をパースして
;; hbw-entry クラスのインスタンスに変換する関数群
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun hbw--xml-child-text (children key)
  "CHILDREN 内の KEY 要素のテキストを返す"
  (let ((node (assoc key children)))
    (when node
      (let ((text (car (xml-node-children node))))
        (when (stringp text) text)))))

(defun hbw--xml-find-link (children rel)
  "CHILDREN 内の link 要素から rel 属性が REL のものの href を返す"
  (cl-loop for child in children
           when (and (listp child)
                     (eq 'link (xml-node-name child))
                     (string= rel (or (cdr (assoc 'rel (xml-node-attributes child))) "")))
           return (cdr (assoc 'href (xml-node-attributes child)))))

(defun hbw--xml-author-name (children)
  "CHILDREN 内の author > name のテキストを返す"
  (let ((author (assoc 'author children)))
    (when author
      (hbw--xml-child-text (xml-node-children author) 'name))))

(defun hbw--xml-categories (children)
  "CHILDREN 内の全 category 要素の term 属性をリストで返す"
  (cl-loop for child in children
           when (and (listp child) (eq 'category (xml-node-name child)))
           collect (cdr (assoc 'term (xml-node-attributes child)))))

(defun hbw--xml-draft-p (children)
  "CHILDREN 内の app:control > app:draft が 'yes' なら t を返す"
  (let* ((control (assoc 'app:control children))
         (draft-node (when control
                       (assoc 'app:draft (xml-node-children control))))
         (val (when draft-node
                (car (xml-node-children draft-node)))))
    (when (and val (stringp val))
      (string= "yes" val))))

(defun hbw--xml-parse-uri-params (uri)
  "はてなブログ AtomPub の URI からパラメータを抽出する"
  (when (and uri (string-match
                  "https://blog.hatena.ne.jp/\\(.*\\)/\\(.*\\)/atom/entry/\\(.*\\)"
                  uri))
    (list :hatena-id (match-string 1 uri)
          :hatena-blog-id (match-string 2 uri)
          :hatena-blog-entry-id (match-string 3 uri))))

(defun hbw-entry-from-xml (xml-entry)
  "XML entry ノードから hbw-entry オブジェクトを生成する。
XML-ENTRY は (entry ATTRS CHILDREN...) 形式の xml-node。"
  (let* ((children (xml-node-children xml-entry))
         ;; link 要素から URI を取得
         (edit-link (hbw--xml-find-link children "edit"))
         (alt-link  (hbw--xml-find-link children "alternate"))
         ;; URI からパラメータを抽出
         (params (when edit-link (hbw--xml-parse-uri-params edit-link)))
         ;; 各フィールドを取得
         (title         (hbw--xml-child-text children 'title))
         (author        (hbw--xml-author-name children))
         (updated       (hbw--xml-child-text children 'updated))
         (published     (hbw--xml-child-text children 'published))
         (edited        (hbw--xml-child-text children 'app:edited))
         (summary       (hbw--xml-child-text children 'summary))
         (content-node  (assoc 'content children))
         (content       (or (car (xml-node-children content-node)) ""))
         (content-type  (or (cdr (assoc 'type (xml-node-attributes content-node)))
                            "text/plain"))
         (categories    (hbw--xml-categories children))
         (draft         (hbw--xml-draft-p children)))
    (hbw-entry :entry-id      (or (plist-get params :hatena-blog-entry-id) "")
               :uri           (or edit-link "")
               :alternate-uri alt-link
               :author-name   author
               :title         (or title "")
               :updated       updated
               :published     published
               :edited        edited
               :summary       summary
               :content       (or content "")
               :content-type  (or content-type "text/plain")
               :categories    categories
               :draft-p       draft
               :hatena-id     (plist-get params :hatena-id)
               :blog-id       (plist-get params :hatena-blog-id))))

(provide 'hbw-entry-xml)

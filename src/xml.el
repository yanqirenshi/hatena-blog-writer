;;; -*- coding: utf-8; lexical-binding: t -*-

(defun xml-node-chidren-with-cleanup (xml)
  "XMLをパースするのに不要な空白を除去したもの(リスト)を返す。"
  (let ((children (xml-node-children xml))
        (out nil))
     (dolist (child children)
       (when (listp child)
          (push child out)))
     out))

(defun hatena-blog-get-xml-entryp (xml)
  "XMLが Entry かどうかを返す。"
  (when (listp xml)
    (eq (xml-node-name xml) 'entry)))

(defun hatena-blog-entry-xml2plist-draft (xml-entry-childen)
  "entry の draft の部分の値を返す。"
  (car (cddr (assoc 'app:draft (xml-node-children (assoc 'app:control xml-entry-childen))))))

(defun hatena-blog-get-xml-entry2plist (xml)
  "APIで取得した Entry の XML を plist に変換する。"
  (unless (hatena-blog-get-xml-entryp xml)
    (error "XML が Entity ではありません"))
  (let ((children (xml-node-chidren-with-cleanup xml)))
    (list :id (car (xml-node-children (assoc 'id children)))
          :link (remove nil (mapcar #'(lambda (link)
                                             (when (eq (car link) 'link)
                                               (let ((l (car (cdr link))))
                                                  (list :uri (cdr (assoc 'href l))
                                                        :rel (cdr (assoc 'rel l))
                                                        :type (cdr (assoc 'type l))))))
                                         children))
          :author (car (cddr (car (xml-node-children (assoc 'author children)))))
          :title (decode-coding-string (car (xml-node-children (assoc 'title children))) 'utf-8)
          :updated (car (xml-node-children (assoc 'updated children)))
          :published (car (xml-node-children (assoc 'published children)))
          :edited (car (xml-node-children (assoc 'app:editededited children)))
          :summary (decode-coding-string (car (xml-node-children (assoc 'summary children))) 'utf-8)
          :content (decode-coding-string (car (xml-node-children (assoc 'content children))) 'utf-8)
          :category (cdr (caar (cdr (assoc 'category  children))))
          :draft (hatena-blog-entry-xml2plist-draft children))))

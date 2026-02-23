;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer.find-next-page-no (xml-lists)
  "フィード内の次ページリンクからページ番号を取り出す"
  (when xml-lists
    (let ((xml-list (car xml-lists)))
      (if (and (eq (car xml-list) 'link)
               (string= (cdr (assoc 'rel (second xml-list)))
                        "next"))
          (let ((uri (cdr (assoc 'href (second xml-list)))))
            (string-match ".+?page=\\(.+\\)" uri)
            (match-string 1 uri))
        (hatena-blog-writer.find-next-page-no (cdr xml-lists))))))


(defun hbw--find-next-page-url (response)
  "レスポンスの feed 内から次ページの URL を返す。なければ nil。"
  (let* ((feeds (hatena-blog-writer.api.response.feeds response))
         (feed (car feeds))
         (children (when feed (cddr feed))))
    (cl-loop for child in children
             when (and (listp child)
                       (eq 'link (xml-node-name child))
                       (string= "next" (or (cdr (assoc 'rel (xml-node-attributes child))) "")))
             return (cdr (assoc 'href (xml-node-attributes child))))))

(defun hbw--fetch-page-success (on-complete &rest result)
  "ページ取得の success コールバック。
エントリーを保存し、次ページがあれば再帰的に取得する。
全ページ取得完了時に ON-COMPLETE を呼び出す。"
  (let ((response (hatena-blog-writer.api.result.response result)))
    ;; 取得したエントリーを保存
    (dolist (xml-entry (hatena-blog-writer.api.response.entries response))
      (let ((entry (hbw-entry-from-xml xml-entry)))
        (hatena-blog-writer.entry.save.master   entry)
        (hatena-blog-writer.entry.save.contents entry)))
    ;; 次ページがあれば再帰的に取得、なければ完了コールバック
    (let ((next-url (hbw--find-next-page-url response)))
      (if next-url
          (progn
            (message "次ページを取得中...")
            (request next-url
                     :type "GET"
                     :headers (hatena-blog-writer-request-headers
                               (hbw-user-id *hatena-blog-writer-current-user*)
                               (hbw-blog-api-key *hatena-blog-writer-current-blog*))
                     :parser *hatena-blog-writer-request-default-callback-parser*
                     :success (cl-function
                               (lambda (&key data &allow-other-keys)
                                 (hbw--fetch-page-success on-complete :data data)))
                     :error *hatena-blog-writer-request-default-callback-error*))
        ;; 次ページなし → 全ページ取得完了
        (when on-complete
          (funcall on-complete))))))

(defun hatena-blog-writer.api.entry.find.success (&rest result)
  "hatena-blog-writer.api.entry.find の success 関数（後方互換）"
  (apply #'hbw--fetch-page-success nil result))

(defun %hatena-blog-writer.api.entry.find (user blog success next-page)
  "entry を 複数取得する"
  (cl-assert (hbw-user-p user))
  (cl-assert (hbw-blog-p blog))
  (let ((hatena-id (hbw-user-id user))
        (hatena-blog-id (hbw-blog-id blog))
        (hatena-blog-api-key (hbw-blog-api-key blog)))
    (hatena-blog-writer-request :get
                                (hatena-blog-writer-api-entry-uri hatena-id
                                                                  hatena-blog-id)
                                hatena-id
                                hatena-blog-id
                                hatena-blog-api-key
                                (list :success success)
                                nil
                                next-page)))

(defun hatena-blog-writer.api.entry.find (user blog &optional next-page)
  (let ((success #'hatena-blog-writer.api.entry.find.success))
    (%hatena-blog-writer.api.entry.find user blog success next-page)))

(defun hatena-blog-writer.api.entry.find.all (user blog on-complete)
  "全ページのエントリーを取得し、完了時に ON-COMPLETE を呼び出す"
  (cl-assert (hbw-user-p user))
  (cl-assert (hbw-blog-p blog))
  (let ((hatena-id (hbw-user-id user))
        (hatena-blog-id (hbw-blog-id blog))
        (hatena-blog-api-key (hbw-blog-api-key blog)))
    (hatena-blog-writer-request :get
                                (hatena-blog-writer-api-entry-uri hatena-id
                                                                  hatena-blog-id)
                                hatena-id
                                hatena-blog-id
                                hatena-blog-api-key
                                (list :success
                                      (cl-function
                                       (lambda (&key data &allow-other-keys)
                                         (hbw--fetch-page-success on-complete :data data))))
                                nil
                                nil)))

(defun hatena-blog-writer.entry.fetch.all ()
  (interactive)
  (hatena-blog-writer.api.entry.find *hatena-blog-writer-current-user*
                                     *hatena-blog-writer-current-blog*))

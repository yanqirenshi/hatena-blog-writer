;;; -*- coding: utf-8; lexical-binding: t -*-

(require 'eieio)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; hbw-user
;;
;; はてなブログのユーザーを表すクラス
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass hbw-user ()
  ((id
    :initarg :id
    :type string
    :accessor hbw-user-id
    :documentation "はてなID")
   (name
    :initarg :name
    :type string
    :accessor hbw-user-name
    :documentation "ユーザー表示名"))
  :documentation "はてなブログのユーザーを表すクラス")

(cl-defmethod hbw-user-display ((user hbw-user))
  "ユーザーの表示文字列を返す"
  (format "%s (%s)" (hbw-user-name user) (hbw-user-id user)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; hbw-blog
;;
;; はてなブログを表すクラス
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass hbw-blog ()
  ((id
    :initarg :id
    :type string
    :accessor hbw-blog-id
    :documentation "ブログID (例: example.hatenablog.com)")
   (name
    :initarg :name
    :type string
    :accessor hbw-blog-name
    :documentation "ブログ表示名")
   (api-key
    :initarg :api-key
    :type string
    :accessor hbw-blog-api-key
    :documentation "はてなブログ AtomPub APIキー"))
  :documentation "はてなブログを表すクラス")

(cl-defmethod hbw-blog-display ((blog hbw-blog))
  "ブログの表示文字列を返す"
  (format "%s (%s)" (hbw-blog-name blog) (hbw-blog-id blog)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; hbw-entry
;;
;; はてなブログのエントリー（記事）を表すクラス
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass hbw-entry ()
  ((entry-id
    :initarg :entry-id
    :type string
    :accessor hbw-entry-id
    :documentation "エントリーの一意識別子")
   (uri
    :initarg :uri
    :type string
    :accessor hbw-entry-uri
    :documentation "エントリーの編集用URI (link rel='edit' の href)")
   (alternate-uri
    :initarg :alternate-uri
    :initform nil
    :type (or null string)
    :accessor hbw-entry-alternate-uri
    :documentation "エントリーの公開URL (link rel='alternate' の href)")
   (author-name
    :initarg :author-name
    :initform nil
    :type (or null string)
    :accessor hbw-entry-author-name
    :documentation "著者名")
   (title
    :initarg :title
    :type string
    :accessor hbw-entry-title
    :documentation "エントリーのタイトル")
   (updated
    :initarg :updated
    :initform nil
    :type (or null string)
    :accessor hbw-entry-updated
    :documentation "更新日時 (ISO 8601形式)")
   (published
    :initarg :published
    :initform nil
    :type (or null string)
    :accessor hbw-entry-published
    :documentation "公開日時 (ISO 8601形式)")
   (edited
    :initarg :edited
    :initform nil
    :type (or null string)
    :accessor hbw-entry-edited
    :documentation "編集日時 (app:edited, ISO 8601形式)")
   (summary
    :initarg :summary
    :initform nil
    :type (or null string)
    :accessor hbw-entry-summary
    :documentation "要約 (最大140文字)")
   (content
    :initarg :content
    :initform ""
    :type string
    :accessor hbw-entry-content
    :documentation "本文テキスト")
   (content-type
    :initarg :content-type
    :initform "text/plain"
    :type string
    :accessor hbw-entry-content-type
    :documentation "本文の記法 (content要素のtype属性)")
   (categories
    :initarg :categories
    :initform nil
    :type list
    :accessor hbw-entry-categories
    :documentation "カテゴリのリスト (文字列のリスト)")
   (draft-p
    :initarg :draft-p
    :initform nil
    :type boolean
    :accessor hbw-entry-draft-p
    :documentation "下書き状態か否か (t=下書き, nil=公開済み)")
   (hatena-id
    :initarg :hatena-id
    :initform nil
    :type (or null string)
    :accessor hbw-entry-hatena-id
    :documentation "はてなID (URIから抽出)")
   (blog-id
    :initarg :blog-id
    :initform nil
    :type (or null string)
    :accessor hbw-entry-blog-id
    :documentation "ブログID (URIから抽出)"))
  :documentation "はてなブログのエントリー（記事）を表すクラス")

(cl-defmethod hbw-entry-status-string ((entry hbw-entry))
  "エントリーの状態を文字列で返す"
  (if (hbw-entry-draft-p entry) "draft" "published"))

(cl-defmethod hbw-entry-published-date ((entry hbw-entry))
  "公開日時から日付部分 (yyyy-mm-dd) を返す"
  (let ((published (hbw-entry-published entry)))
    (when (and published (string-match "^\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)" published))
      (match-string 1 published))))

(provide 'hbw-classes)

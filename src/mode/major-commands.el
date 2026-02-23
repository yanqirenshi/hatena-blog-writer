;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; メジャーモードのインタラクティブコマンド
;;
;; キーバインドに対応するコマンド関数群。
;; 描画は major-buffer.el / major-buffer-fields.el に委譲する。
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; 基本コマンド
;;

(defun hbw-command-refresh ()
  "ローカルデータからバッファを再描画する (r)"
  (interactive)
  (hatena-blog-writer-render-buffer (current-buffer))
  (message "再描画しました"))

(defun hbw-command-open ()
  "カーソル行のエントリーの contents.md を開く (RET)
published の場合は read-only、draft の場合は編集可能で開く。"
  (interactive)
  (let ((entry (hbw--entry-at-point)))
    (unless entry
      (user-error "エントリー行にカーソルを置いてください"))
    (let ((file (hbw-entry-file-path "contents" entry)))
      (unless (file-exists-p file)
        (user-error "ファイルが存在しません: %s" file))
      (find-file file)
      (when (not (hbw-entry-draft-p entry))
        (setq buffer-read-only t)
        (message "[read-only] 公開済みエントリーです")))))

(defun hbw-command-quit ()
  "hatena-blog-writer バッファを閉じる (q)"
  (interactive)
  (quit-window t))

(defun hbw-command-help ()
  "キーバインド一覧を表示する (?)"
  (interactive)
  (message (concat "l:Load  r:Refresh  R:Refresh-all  "
                   "d:Diff  k:Remove  RET:Open  q:Quit  ?:Help")))

;;
;; API 連携コマンド
;;

(defun hbw-command-load ()
  "全エントリーを API から全ページ取得し、完了後にバッファを再描画する (l)"
  (interactive)
  (message "エントリーを取得中...")
  (let ((buf (current-buffer)))
    (hatena-blog-writer.api.entry.find.all
     *hatena-blog-writer-current-user*
     *hatena-blog-writer-current-blog*
     ;; 全ページ取得完了後のコールバック
     (lambda ()
       (when (buffer-live-p buf)
         (hatena-blog-writer-render-buffer buf)
         (message "全エントリーを取得しました"))))))

(defun hbw-command-refresh-all ()
  "全エントリーを API から再取得し、バッファを再描画する (R)"
  (interactive)
  (hbw-command-load))

(defun hbw-command-diff ()
  "カーソル行のエントリーのローカル contents.md とサーバーの content を比較する (d)"
  (interactive)
  (let ((entry (hbw--entry-at-point)))
    (unless entry
      (user-error "エントリー行にカーソルを置いてください"))
    (let* ((local-file (hbw-entry-file-path "contents" entry))
           (entry-id (hbw-entry-id entry))
           (user *hatena-blog-writer-current-user*)
           (blog *hatena-blog-writer-current-blog*))
      (unless (file-exists-p local-file)
        (user-error "ローカルファイルが存在しません: %s" local-file))
      (message "サーバーからエントリーを取得中...")
      (hatena-blog-writer-api-entry-get
       user blog entry-id
       :update :master
       :callback
       (lambda ()
         (let ((server-entry (hatena-blog-writer-load-entry-master user blog entry-id)))
           (if (not server-entry)
               (message "サーバーからエントリーを取得できませんでした")
             (let ((server-buf (generate-new-buffer "*hbw-server-content*")))
               (with-current-buffer server-buf
                 (insert (hbw-entry-title server-entry) "\n")
                 (insert (hbw-entry-content server-entry)))
               (let ((local-buf (find-file-noselect local-file)))
                 (ediff-buffers local-buf server-buf))))))))))

(defun hbw-command-remove ()
  "カーソル行のエントリーのローカルファイルを削除する (k)"
  (interactive)
  (let ((entry (hbw--entry-at-point)))
    (unless entry
      (user-error "エントリー行にカーソルを置いてください"))
    (let ((title (hbw-entry-title entry))
          (user-id (hbw-entry-hatena-id entry))
          (blog-id (hbw-entry-blog-id entry))
          (entry-id (hbw-entry-id entry)))
      (when (yes-or-no-p (format "ローカルファイルを削除しますか？: %s" title))
        (let ((dir (format "~/.hatena/blog/%s/%s/%s" user-id blog-id entry-id)))
          (when (file-exists-p dir)
            (delete-directory dir t)
            (message "削除しました: %s" title)
            (hbw-command-refresh)))))))

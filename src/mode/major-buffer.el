;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; メジャーモードバッファの管理
;;
;; バッファの確保と再描画を担当する。
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun hatena-blog-writer-ensure-major-mode-buffer-name ()
  "メジャーモードのバッファ名を返す"
  (let ((user *hatena-blog-writer-current-user*))
    (when user
      (format "*hatena-blog: %s*"
              (hbw-user-id user)))))

(defun hatena-blog-writer-ensure-major-mode-buffer ()
  "メジャーモードのバッファを返す（なければ作成）"
  (unless *hatena-blog-writer-current-user*
    (error "ユーザーが選択されていません"))
  (let ((buffer-name (hatena-blog-writer-ensure-major-mode-buffer-name)))
    (get-buffer-create buffer-name)))

(defun hatena-blog-writer-render-buffer (buffer)
  "バッファの内容を再描画する"
  (with-current-buffer buffer
    (let ((inhibit-read-only t))
      (erase-buffer)
      ;; ヘッダ描画
      (hbw--render-header)
      ;; エントリー一覧描画
      (hbw--render-entry-list)
      ;; カーソルを最初のエントリー行に移動
      (hbw--goto-first-entry))
    ;; メジャーモード設定（キーマップ・hl-line-mode 有効化）
    (hatena-blog-writer-mode)))

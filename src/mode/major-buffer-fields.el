;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; メジャーモードバッファの描画関数群
;;
;; ヘッダ（タイトル、ユーザー、ブログ、カラムヘッダ）と
;; エントリー一覧の描画を担当する。
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst hbw--header-line-count 7
  "ヘッダ部分の行数。エントリー一覧はこの行の次から始まる")

;;
;; ヘッダ描画
;;
(defun hbw--render-header ()
  "ヘッダ部分（タイトル/User/Blog/カラムヘッダ/セパレータ）を描画する"
  (insert "HATENA BLOG WRITER\n")
  (insert (format "User: %s (%s)\n"
                  (hbw-user-name *hatena-blog-writer-current-user*)
                  (hbw-user-id *hatena-blog-writer-current-user*)))
  (insert (format "Blog: %s (%s)\n"
                  (hbw-blog-name *hatena-blog-writer-current-blog*)
                  (hbw-blog-id *hatena-blog-writer-current-blog*)))
  (insert "\n")
  (insert "Entries:\n")
  (insert (format "  %-9s %-10s %s\n" "status" "date" "title"))
  (insert (format "  %s %s %s\n"
                  (make-string 9 ?-)
                  (make-string 10 ?-)
                  (make-string 40 ?-))))

;;
;; エントリー行描画
;;
(defun hbw--render-entry-line (entry)
  "1つのエントリー行を描画する。text-property に hbw-entry を付与。"
  (let ((line (format "  %-9s %-10s %s"
                      (hbw-entry-status-string entry)
                      (or (hbw-entry-published-date entry) "----------")
                      (hbw-entry-title entry)))
        (start (point)))
    (insert line)
    (put-text-property start (point) 'hbw-entry entry)
    (insert "\n")))

(defun hbw--render-entry-list ()
  "エントリー一覧を描画する"
  (let ((entries (hatena-blog-writer-load-all-entry-master
                  *hatena-blog-writer-current-user*
                  *hatena-blog-writer-current-blog*)))
    ;; published の日付で降順ソート
    (setq entries (sort entries
                        (lambda (a b)
                          (string> (or (hbw-entry-published a) "")
                                   (or (hbw-entry-published b) "")))))
    (dolist (entry entries)
      (hbw--render-entry-line entry))))

;;
;; ユーティリティ
;;
(defun hbw--entry-at-point ()
  "カーソル位置の hbw-entry オブジェクトを返す。エントリー行でなければ nil。"
  (get-text-property (point) 'hbw-entry))

(defun hbw--goto-first-entry ()
  "カーソルを最初のエントリー行に移動する"
  (goto-char (point-min))
  (forward-line hbw--header-line-count))

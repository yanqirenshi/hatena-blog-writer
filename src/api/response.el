;;; -*- coding: utf-8; lexical-binding: t -*-

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; hatena-blog-writer.api.result.response で返すものが response です。
;;
;;
;;
;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;
;;;;; hatena-blog-writer.api.response.feeds
;;;;;
(defun hatena-blog-writer.api.response.feeds (response)
  (when response
    (let ((element (car response)))
      (if (not (eq 'feed (car element)))
          (hatena-blog-writer.api.response.feeds (cdr response))
        (cons element
              (hatena-blog-writer.api.response.feeds (cdr response)))))))


;;;;;
;;;;; hatena-blog-writer.api.response.feed.entries
;;;;;
(defun %hatena-blog-writer.api.response.feed.entries (children)
  (when children
    (let ((child (car children)))
      (if (not (eq 'entry (car child)))
          (%hatena-blog-writer.api.response.feed.entries (cdr children))
        (cons child
              (%hatena-blog-writer.api.response.feed.entries (cdr children)))))))

(defun hatena-blog-writer.api.response.feed.entries (feed)
  (%hatena-blog-writer.api.response.feed.entries (car (cddr feed))))

;;;;;
;;;;; hatena-blog-writer.api.response.feeds-entries
;;;;;
(defun hatena-blog-writer.api.response.feeds.entries (feeds)
  (when feeds
    (let ((feed (car feeds)))
      (nconc (hatena-blog-writer.api.response.feed.entries feed)
             (hatena-blog-writer.api.response.feeds.entries (cdr feeds))))))

;;;;;
;;;;; hatena-blog-writer.api.response.entries
;;;;;
(defun hatena-blog-writer.api.response.entries (response)
  (hatena-blog-writer.api.response.feeds.entries
   (hatena-blog-writer.api.response.feeds response)))

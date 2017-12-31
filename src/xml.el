;;; -*- coding: utf-8; lexical-binding: t -*-

(defun hatena-blog-writer-cleanup-xml-del-p (d)
  (and (stringp d)
       (string= "" (string-trim d))))

(defun hatena-blog-writer-cleanup-xml-element (element)
  (let ((children (xml-node-children element))
        (new-children nil))
    (dolist (child children)
      (unless (hatena-blog-writer-cleanup-xml-del-p child)
        (push (if (not (listp child))
                  child
                  (hatena-blog-writer-cleanup-xml-element child))
              new-children)))
    (list (xml-node-name element)
          (xml-node-attributes element)
          (reverse new-children))))

(defun hatena-blog-writer-cleanup-xml (xml)
  (when xml
    (let ((element (car xml)))
      (if (hatena-blog-writer-cleanup-xml-del-p element)
          (hatena-blog-writer-cleanup-xml (cdr xml))
          (cons (hatena-blog-writer-cleanup-xml-element element)
                (hatena-blog-writer-cleanup-xml (cdr xml)))))))

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

(defconst *hatena-blog-writer-request-xml-template*
  "<?xml version='1.0' encoding='utf-8'?>
<entry xmlns='http://www.w3.org/2005/Atom'
       xmlns:app='http://www.w3.org/2007/app'>
  <title>%s</title>
  <author><name>%s</name></author>
  <content type='text/plain'>%s</content>
  <updated>%s</updated>
  <category term='%s' />
  <app:control>
    <app:draft>%s</app:draft>
  </app:control>
</entry>")

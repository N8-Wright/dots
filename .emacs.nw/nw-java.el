(require 'eglot)
(add-hook 'java-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs
             `(java-mode "jdtls"
                         ,(concat "--jvm-arg=-javaagent:" (expand-file-name "~/.m2/repository/org/projectlombok/lombok/1.18.36/lombok-1.18.36.jar"))))

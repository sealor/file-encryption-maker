File Encryption Maker
=====================

This project is a prototype for file encryption with make.

Initialize password store:
```
make init
```

Encrypt file:
```
cat>greeting.txt<<EOF
hello
EOF

make greeting.txt.crypt

rm greeting.txt
```

Decrypt file:
```
make greeting.txt
```

Clean cached password:
```
make clean_cache
```


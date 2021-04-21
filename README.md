# m1 brew formulas

gendev-0.4.0

```
$ brew tap hsk/m1
$ brew install gendev-0.4.0
$ source ~/.gendev
$ echo "int main(){while(1){}return 0;}" > a.c
$ make -f $GENDEV/sgdk/mkfiles/makefile.gen
```


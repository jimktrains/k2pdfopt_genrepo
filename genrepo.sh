#/bin/sh

REPO_PATH=../k2pdfopt
CWD=`pwd`

if [ -d $REPO_PATH ]; then
  mkdir $REPO_PATH
  cd $REPO_PATH
  git init
  cd $CWD
fi

for i in `ls -R www.willus.com/k2pdfopt/src/*.zip`; do
  echo "working on $i"
  PREFIX=`basename $i .zip`
  TAG=`echo $PREFIX | sed s/k2pdfopt_//g`
  unzip -d $REPO_PATH -o $i
  mv $REPO_PATH/$PREFIX/* .
  rm -r $REPO_PATH/$PREFIX/
  git add .
  git commit -m "${TAG}"
  git checkout -b "${TAG}"
  git checkout master
  git tag "${TAG}"
  cd $CWD
done

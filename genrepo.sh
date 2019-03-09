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
  TAG=`basename $i .zip`
  TAG=`echo $TAG | sed s/k2pdfopt_//g`
  unzip -d $REPO_PATH -o $i
  mv $REPO_PATH/$TAG/* .
  rm -r $REPO_PATH/$TAG/
  git add .
  git commit -m "${TAG}"
  git tag "${TAG}"
  cd $CWD
done

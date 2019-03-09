#/bin/sh

REPO_PATH=../k2pdfopt
CWD=`pwd`

if [ ! -d $REPO_PATH ]; then
  echo creating repo at $REPO_PATH
  mkdir $REPO_PATH
  cd $REPO_PATH
  git init
  git commit -m "empty"
  cd $CWD
fi

for i in `ls -R $CWD/www.willus.com/k2pdfopt/src/*.zip`; do
  echo "working on $i"
  PREFIX=`basename $i .zip`
  CODE_DIR=`echo $PREFIX | sed s/_src//g`
  TAG=`echo $PREFIX | sed s/k2pdfopt_//g | sed s/_src//g`
  cd $REPO_PATH
  rm -r *
  unzip -q -o $i
  mv $REPO_PATH/$CODE_DIR/* $REPO_PATH
  rm -r $REPO_PATH/$CODE_DIR/
  git add . > /dev/null
  git commit --message "${TAG}" --date="`stat --format="%y" $i`" --author="willus <unknown@example.com>"
  git checkout -b "${TAG}"
  git checkout master
  git tag "${TAG}"
  cd $CWD
done

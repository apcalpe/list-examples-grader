CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests


set -e

file=`find student-submission -maxdepth 1 -name "ListExamples.java"`

if [[ -f $file ]]
then
    echo "Correct File Submitted"
else
    echo "Wrong File Submitted"
    exit
fi


cp $file grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

set +e

cd grading-area
javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

if [[ $? -eq 1 ]]
then 
    echo "Test failed"
else
    echo "Test passed"
fi
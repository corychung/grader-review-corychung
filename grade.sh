CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area
rm junit-output.txt
mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then
  echo "File found!"
else
  echo "No file found"
  exit
fi

cp student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area

javac -cp $CPATH grading-area/TestListExamples.java grading-area/ListExamples.java

if [[ $? -eq 0 ]]
then
  echo "Compile success!"
else
  echo "Compile failed. Error code is $?"
  exit
fi

java -cp $CPATH org.junit.runner.JUnitCore grading-area/TestListExamples | grep "Tests run: " > junit-output.txt

FAILS=$(cat junit-output.txt | cut -d':' -f 3 | cut -d' ' -f 2)
TOTAL=$(cat junit-output.txt | cut -d':' -f 2 | cut -d',' -f 1| cut -d' ' -f 2)

echo "Fails: $FAILS"
echo "Total: $TOTAL"
echo "Numbers failed: $FAILS/$TOTAL" 




  


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

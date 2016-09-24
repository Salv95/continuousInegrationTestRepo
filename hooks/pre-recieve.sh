#!/bin/bash
while read oldrev newrev refname
do
    #  Only run this script for the master branch. You can remove this
    # if block if you wish to run it for others as well.
    if [[ $refname = "refs/heads/master" ]] ; then
        # Anything echo'd will show up in the console for the person
        # who's doing a push
        echo "Preparing to run phpunit for $newrev ... "

        # Since the repo is bare, we need to put the actual files someplace,
        # so we use the temp dir we chose earlier
        git archive $newrev | tar -x -C /Users/Shared/Jenkins/repos/tmp

        echo "Running phpunit for $newrev ... "

        # This part is the actual code which is used to run our tests
        # In my case, the phpunit testsuite resides in the tests directory, so go there
       #   cd /home/jani/tmp/example/tests

        # And execute the testsuite, while ignoring any output


#phpunit > /dev/null

        # $? is a shell variable which stores the return code from what we just ran

        rc = 1#rc=$?
        if [[ $rc != 0 ]] ; then
            # A non-zero return code means an error occurred, so tell the user and exit
            echo "phpunit failed on rev $newrev - push deniend. Run tests locally and confirm they pass before pushing"
            exit $rc
        fi
    fi
done

# Everything went OK so we can exit with a zero
exit 0
program outputdata
implicit none

    real, dimension(10) :: x
    integer :: i
    integer :: status, system, iteration
    integer :: open_status, close_status
    character (len=19) :: mfile
    character (len=12) :: outfile
    character (len=71) :: cmdline
    logical :: ex

    iteration=1000 !for placeholder space. ex. 1000 = 0th iteration

    write (mfile, "(A4,I4,A11)") "data", iteration, "-matlab.txt"
    write (outfile, "(A4,I4,A4)") "data", iteration, ".txt"
    write(cmdline, "(A59,I4,A8)") 'matlab -nodisplay -nosplash -nodesktop -wait -r "iteration=', iteration,';test"'

    ! do data
    do i=1,10
        x(i) = i
    end do

    ! output data
    open(1, file=outfile, status='UNKNOWN')
    do i=1,10
        write(1,*) x(i), x(i)
    end do
    close(1)

    do while (iteration < 1128)

        write (mfile, "(A4,I4,A11)") "data", iteration, "-matlab.txt"
        write (outfile, "(A4,I4,A4)") "data", iteration, ".txt"
        write(cmdline, "(A59,I4,A8)") 'matlab -nodisplay -nosplash -nodesktop -wait -r "iteration=', iteration,';test"'

        ! call matlab
        call execute_command_line (cmdline, wait=.true.)

        ! matlab is done!
        print *, "finished iteration", iteration

        !make sure file exists
        inquire(file = mfile, exist = ex)

        !if the file doesnt exist just quit
        if(.not. ex) then
            stop
        endif

        !fortran opens matlab file and reworks it
		open (unit=iteration, file=mfile, status='old', &
		    iostat=open_status, action='read', position='rewind')
		if ( open_status /= 0 ) then
		    print *, 'Could not open ',mfile,' for reading.', &
			'iteration = ', iteration
		    stop
		endif
		!got this code from http://www.cs.uwm.edu/~cs151/Bacon/Lecture/HTML/ch13s03.html

        !data stuff

        open(1, file=outfile, status='UNKNOWN')
        do i=1,10
            write(1,*) x(i), x(i)
        end do
        close(1)


        !close file
        close(iteration, iostat=close_status)
		if ( close_status /= 0 ) then
		    print *, 'Error: Attempt to close a file that is not open.', &
			'iteration = ', iteration
		    stop
		endif
		!got this code from http://www.cs.uwm.edu/~cs151/Bacon/Lecture/HTML/ch13s03.html

        iteration = iteration + 1

        !because we increment at the very end, the 0th iteration of the fortran generation data will be overwritten

    end do


end program outputdata

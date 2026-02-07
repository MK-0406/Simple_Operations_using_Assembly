# =============================================================================== #

.data

equation1: .asciiz "1. (A OR B) AND C\n"
equation2: .asciiz "2. (A XOR B) NOR C\n"
equation3: .asciiz "3. A NAND (B AND C)\n"
equation4: .asciiz "4. (A - B) + C\n"
equation5: .asciiz "5. A / (B * C)\n"
equation6: .asciiz "6. (A' + B) / C\n"
selection: .asciiz "Choose 1 equation (1-6): "
value1: .asciiz "Enter an integer for A: "
value2: .asciiz "Enter an integer for B: "
value3: .asciiz "Enter an integer for C: "
result: .asciiz "The result is: "
continue: .asciiz "\nDo you want to continue with another equation? (1-yes/2-no): "
errormsg: .asciiz "Error in input the selection of equation"

# =============================================================================== #

.text

main:

# >>>>>>>>>>>>>>>>>>>>>>>>> Print "1. (A OR B) AND C\n" <<<<<<<<<<<<<<<<<<<<<<<<< # 

	li $v0, 4				# print string
	la $a0, equation1			# load string address
	syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>>> Print "2. (A XOR B) NOR C\n" <<<<<<<<<<<<<<<<<<<<<<<< #

	li $v0, 4				# print string
	la $a0, equation2			# load string address
	syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>> Print "3. A NAND (B AND C)\n" <<<<<<<<<<<<<<<<<<<<<<<< #

	li $v0, 4				# print string
	la $a0, equation3			# load string address
	syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>> Print "4. (A - B) + C\n" <<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

	li $v0, 4				#print string
	la $a0, equation4			#load string address
	syscall				#print it!

# >>>>>>>>>>>>>>>>>>>>>>>> Print "5. A / (B * C)\n" <<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

	li $v0, 4				#print string
	la $a0, equation5			#load string address
	syscall				#print it!

# >>>>>>>>>>>>>>>>>>>>>>>> Print "6. (A' + B) / C\n" <<<<<<<<<<<<<<<<<<<<<<<<<<<< #

	li $v0, 4				#print string
	la $a0, equation6			#load string address
	syscall				#print it!
# >>>>>>>>>>>>>>>>>>>>>> Print "Choose 1 equation (1-6): " <<<<<<<<<<<<<<<<<<<<<< #
	
	li $v0, 4				# print string
      la $a0, selection			# load string address
      syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>> Read selection value from user <<<<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 5				# read integer
      syscall				# read it!
      move $s7, $v0			# keep selection value in $s7

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>> Initialization code <<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

      addi $t4, $0, 1 			# $t4 = 1
      addi $t5, $0, 2			# $t5 = 2
      addi $t6, $0, 3			# $t6 = 3
      addi $t7, $0, 4			# $t7 = 4
      addi $t8, $0, 5			# $t8 = 5
      addi $t9, $0, 6			# $t9 = 6

# >>>>>>>>>>>>>>>>>>>>>> Check if selection input is valid <<<<<<<<<<<<<<<<<<<<<< #

	slt $s0, $t9, $s7			# if (selection value > 6)
	bne $s0, $0, error		# branch to error
	slt $s1, $s7, $t4			# if (selection value < 1)
	bne $s1, $0, error		# branch to error

# >>>>>>>>>>>>>>>>>>>>>>>>>>>> Input A, B, C values <<<<<<<<<<<<<<<<<<<<<<<<<<<<< #


# >>>>>>>>>>>>>>>>>>>>>> Print "Enter an integer for A: " <<<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 4				# print string	
      la $a0, value1			# load string address
      syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>>>> Read A integer from user <<<<<<<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 5				# read integer
      syscall				# read it!
      move $t1, $v0			# keep A in $t1

# >>>>>>>>>>>>>>>>>>>>>>> Print "Enter an integer for B: " <<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 4				# print string
      la $a0, value2			# load string address
      syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>>>> Read B integer from user <<<<<<<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 5				# read integer
      syscall				# read it!
      move $t2, $v0			# keep B in $t2

# >>>>>>>>>>>>>>>>>>>>>>> Print "Enter an integer for C: " <<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 4				# print string
      la $a0, value3			# load string address
      syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>>>> Read C integer from user <<<<<<<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 5				# read integer
      syscall				# read it!
      move $t3, $v0			# keep C in $t3

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> IF Statement <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #
    
      beq $s7, $t4, eq1			# if selection == 1, branch to eq1
      beq $s7, $t5, eq2			# if selection == 2, branch to eq2
      beq $s7, $t6, eq3			# if selection == 3, branch to eq3
      beq $s7, $t7, eq4			# if selection == 4, branch to eq4
      beq $s7, $t8, eq5			# if selection == 5, branch to eq5
      beq $s7, $t9, eq6			# if selection == 6, branch to eq6

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Calculations <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> (A OR B) AND C <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

eq1:
      or 	$t0, $t1, $t2		# $t0 = A OR B
      and 	$s4, $t0, $t3		# result = (A OR B) AND C
      j 	results			# jump to results

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> (A XOR B) NOR C <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

eq2:
      xor 	$t0, $t1, $t2		# $t0 = A XOR B
      nor   $s4, $t0, $t3		# result = (A XOR B) NOR C
	j	results			# jump to results

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> A NAND (B AND C) <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

eq3:
	and	$t0, $t2, $t3		# $t0 = B AND C
	and	$s5, $t1, $t0		# $s5 = A AND (B AND C)
	nor	$s4, $s5, $0		# result = NOT (A AND (B AND C))
	j	results			# jump to results

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> (A - B) + C <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

# ------------- t0 = hold value, t1 = A, t2 = B, t3 = C, s4 = result------------- #

eq4:
	sub	$t0, $t1, $t2		#t0 = A - B
	add	$s4, $t0, $t3		#result = t0 + C
	j	results			#jump to results

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> A / (B * C) <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

eq5:
	mul	$t0, $t2, $t3		#t0 = B * C
	div	$s4, $t1, $t0		#result = A / t0
	j	results			#jump to results

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> (A' + B) / C <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

eq6:
	nor	$s5, $t1, $0		#A = A'
	add	$t0, $s5, $t2		#t0 = A' + B
	div	$s4, $t0, $t3		#result = t0 / C
	j	results			#jump to results

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Print Result  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

results:

# >>>>>>>>>>>>>>>>>>>>>>>>>>> Print "The result is: " <<<<<<<<<<<<<<<<<<<<<<<<<<< #

      li 	$v0, 4			# print string
      la	$a0, result			# load string address
      syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>>>>>> Print integer result <<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

      li 	$v0, 1			# print integer
      move	$a0, $s4			# integer to print need to be in $a0
      syscall				# print it!
	j	cont				# jump to cont

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>  Print Error Message <<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

error:
	li $v0, 4				# print string
      la $a0, errormsg			# load string address
      syscall				# print it!
	j cont				# jump to cont

# >>>>>>>>>>>>>>>>>>>>>>> Continue with another equation <<<<<<<<<<<<<<<<<<<<<<<< #

cont:

# >>> Print "\nDo you want to continue with another equation? (1-yes/2-no): " <<< #

	li $v0, 4				# print string
	la $a0, continue			# load string address
	syscall				# print it!

# >>>>>>>>>>>>>>>>>>>>>>>> Read an integer from user <<<<<<<<<<<<<<<<<<<<<<<<<<<< # 

      li $v0, 5				# read integer
      syscall				# read it!
      move $s6, $v0			# keep the integer in $s6

# >>>>>>>>>>>>>>>>>> Continue with another equation OR Exit <<<<<<<<<<<<<<<<<<<<< #

	beq $s6, $t4, main		# if cont == 1, branch to main
	beq $s6, $t5, exit		# if cont == 2, branch to exit

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Exit IF Statement <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

exit:

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Exit Program <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

      li $v0, 10				# return to OS
      syscall				# do it!

# =============================================================================== #
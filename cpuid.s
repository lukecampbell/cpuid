 /*
  * cpuid.s
  * A module for querying CPU chipset information.
  */

	.text
	.globl	cpuid
	.type	cpuid, @function
/*
 * void afunc(char *buf, uint32_t *features, uint32_t *advanced_features);
 *            rsi      , rdi               , rdx
 * buf is set to the CPU vendor string which should be able to hold at least 16 chars including a null terminator.
 * features[0] is set to the first set of feature flags, and featurs[1] is set
 * to the second set of feature flags. advanced_features is the same but
 * populated with the bits from the extended features table.
 */
cpuid:
	endbr64
	pushq	%rbp
	movq	%rsp, %rbp         # Stack stuff
    pushq   %rbx               # rbx must be preserved by callee according to sys v ABI
    pushq   %rdx               # rdx gets used by cpuinfo so save the advanced_features ptr on the stack
    movl    $0, %eax           # cpuid(0)
    cpuid                      # cpuid sets eax, ebx, ecx, edx
    # copy register results to 16 bytes of *buf
    movl    %ebx, (%rdi)       # buf[0] = ebx
    movl    %edx, 4(%rdi)      # buf[4] = edx
    movl    %ecx, 8(%rdi)      # buf[8] = ecx
    movl    $0, 12(%rdi)       # terminate buf with null
    movl    $1, %eax           # cpuid(1)
    cpuid
    movl    %edx, (%rsi)       # features[0] = edx
    movl    %ecx, 4(%rsi)      # features[1] = ecx
    movl    $7, %eax
    movl    $0, %ecx
    popq    %rsi               # pop advanced_features into rsi
    cpuid                      # cpuid(7, 0), extended features
    movl    %ebx, (%rsi)       # advanced_features[0] = ebx
    movl    %ecx, 4(%rsi)      # advanced_features[1] = ebx
    movl    %edx, 8(%rsi)      # advanced_features[2] = ebx
    movl    $0, %eax
    popq    %rbx
	nop
	popq	%rbp
	ret


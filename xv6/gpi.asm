
_gpi:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "processInfo.h"

int main(int argc, char *argv[]) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
	if(argc != 2) {
  13:	83 39 02             	cmpl   $0x2,(%ecx)
int main(int argc, char *argv[]) {
  16:	8b 71 04             	mov    0x4(%ecx),%esi
	if(argc != 2) {
  19:	74 13                	je     2e <main+0x2e>
		printf(2, "Usage: gpi <pid>\n");
  1b:	50                   	push   %eax
  1c:	50                   	push   %eax
  1d:	68 e8 07 00 00       	push   $0x7e8
  22:	6a 02                	push   $0x2
  24:	e8 57 04 00 00       	call   480 <printf>
		exit();
  29:	e8 b5 02 00 00       	call   2e3 <exit>
	}
	struct processInfo *pfo = malloc(sizeof(struct processInfo));
  2e:	83 ec 0c             	sub    $0xc,%esp
  31:	6a 0c                	push   $0xc
  33:	e8 a8 06 00 00       	call   6e0 <malloc>
	int pid = atoi(argv[1]);
  38:	5a                   	pop    %edx
  39:	ff 76 04             	pushl  0x4(%esi)
	struct processInfo *pfo = malloc(sizeof(struct processInfo));
  3c:	89 c3                	mov    %eax,%ebx
	int pid = atoi(argv[1]);
  3e:	e8 2d 02 00 00       	call   270 <atoi>
	if(getProcInfo(pid, pfo) == -1) {
  43:	59                   	pop    %ecx
  44:	5e                   	pop    %esi
  45:	53                   	push   %ebx
  46:	50                   	push   %eax
  47:	e8 5f 03 00 00       	call   3ab <getProcInfo>
  4c:	83 c4 10             	add    $0x10,%esp
  4f:	83 c0 01             	add    $0x1,%eax
  52:	74 1f                	je     73 <main+0x73>
		printf(2, "Invalid Pid\n");
		exit();
	}
	printf(1, "Pid : %d\nNo. Of Context Switches : %d\nProcess Size : %d\n", pfo->ppid, pfo->numberContextSwitches, pfo->psize);
  54:	83 ec 0c             	sub    $0xc,%esp
  57:	ff 73 04             	pushl  0x4(%ebx)
  5a:	ff 73 08             	pushl  0x8(%ebx)
  5d:	ff 33                	pushl  (%ebx)
  5f:	68 08 08 00 00       	push   $0x808
  64:	6a 01                	push   $0x1
  66:	e8 15 04 00 00       	call   480 <printf>
	exit();
  6b:	83 c4 20             	add    $0x20,%esp
  6e:	e8 70 02 00 00       	call   2e3 <exit>
		printf(2, "Invalid Pid\n");
  73:	50                   	push   %eax
  74:	50                   	push   %eax
  75:	68 fa 07 00 00       	push   $0x7fa
  7a:	6a 02                	push   $0x2
  7c:	e8 ff 03 00 00       	call   480 <printf>
		exit();
  81:	e8 5d 02 00 00       	call   2e3 <exit>
  86:	66 90                	xchg   %ax,%ax
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  90:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  91:	31 c0                	xor    %eax,%eax
{
  93:	89 e5                	mov    %esp,%ebp
  95:	53                   	push   %ebx
  96:	8b 4d 08             	mov    0x8(%ebp),%ecx
  99:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  a7:	83 c0 01             	add    $0x1,%eax
  aa:	84 d2                	test   %dl,%dl
  ac:	75 f2                	jne    a0 <strcpy+0x10>
    ;
  return os;
}
  ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b1:	89 c8                	mov    %ecx,%eax
  b3:	c9                   	leave  
  b4:	c3                   	ret    
  b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	53                   	push   %ebx
  c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ca:	0f b6 01             	movzbl (%ecx),%eax
  cd:	0f b6 1a             	movzbl (%edx),%ebx
  d0:	84 c0                	test   %al,%al
  d2:	75 1d                	jne    f1 <strcmp+0x31>
  d4:	eb 2a                	jmp    100 <strcmp+0x40>
  d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  e4:	83 c1 01             	add    $0x1,%ecx
  e7:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
  ea:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
  ed:	84 c0                	test   %al,%al
  ef:	74 0f                	je     100 <strcmp+0x40>
  f1:	38 d8                	cmp    %bl,%al
  f3:	74 eb                	je     e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  f5:	29 d8                	sub    %ebx,%eax
}
  f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  fa:	c9                   	leave  
  fb:	c3                   	ret    
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 102:	29 d8                	sub    %ebx,%eax
}
 104:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 107:	c9                   	leave  
 108:	c3                   	ret    
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000110 <strlen>:

uint
strlen(char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 3a 00             	cmpb   $0x0,(%edx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 c0                	xor    %eax,%eax
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	83 c0 01             	add    $0x1,%eax
 123:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 127:	89 c1                	mov    %eax,%ecx
 129:	75 f5                	jne    120 <strlen+0x10>
    ;
  return n;
}
 12b:	89 c8                	mov    %ecx,%eax
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret    
 12f:	90                   	nop
  for(n = 0; s[n]; n++)
 130:	31 c9                	xor    %ecx,%ecx
}
 132:	5d                   	pop    %ebp
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret    
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld    
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	8b 7d fc             	mov    -0x4(%ebp),%edi
 155:	89 d0                	mov    %edx,%eax
 157:	c9                   	leave  
 158:	c3                   	ret    
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 12                	jne    183 <strchr+0x23>
 171:	eb 1d                	jmp    190 <strchr+0x30>
 173:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 177:	90                   	nop
 178:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 17c:	83 c0 01             	add    $0x1,%eax
 17f:	84 d2                	test   %dl,%dl
 181:	74 0d                	je     190 <strchr+0x30>
    if(*s == c)
 183:	38 d1                	cmp    %dl,%cl
 185:	75 f1                	jne    178 <strchr+0x18>
      return (char*)s;
  return 0;
}
 187:	5d                   	pop    %ebp
 188:	c3                   	ret    
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 190:	31 c0                	xor    %eax,%eax
}
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a5:	31 f6                	xor    %esi,%esi
{
 1a7:	53                   	push   %ebx
 1a8:	89 f3                	mov    %esi,%ebx
 1aa:	83 ec 1c             	sub    $0x1c,%esp
 1ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1b0:	eb 2f                	jmp    1e1 <gets+0x41>
 1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1b8:	83 ec 04             	sub    $0x4,%esp
 1bb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1be:	6a 01                	push   $0x1
 1c0:	50                   	push   %eax
 1c1:	6a 00                	push   $0x0
 1c3:	e8 33 01 00 00       	call   2fb <read>
    if(cc < 1)
 1c8:	83 c4 10             	add    $0x10,%esp
 1cb:	85 c0                	test   %eax,%eax
 1cd:	7e 1c                	jle    1eb <gets+0x4b>
      break;
    buf[i++] = c;
 1cf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
 1d3:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
 1d6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1d9:	3c 0a                	cmp    $0xa,%al
 1db:	74 23                	je     200 <gets+0x60>
 1dd:	3c 0d                	cmp    $0xd,%al
 1df:	74 1f                	je     200 <gets+0x60>
  for(i=0; i+1 < max; ){
 1e1:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
 1e4:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
 1e6:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1e9:	7c cd                	jl     1b8 <gets+0x18>
 1eb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1f0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f6:	5b                   	pop    %ebx
 1f7:	5e                   	pop    %esi
 1f8:	5f                   	pop    %edi
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    
 1fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ff:	90                   	nop
  buf[i] = '\0';
 200:	8b 75 08             	mov    0x8(%ebp),%esi
}
 203:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 206:	01 de                	add    %ebx,%esi
 208:	89 f3                	mov    %esi,%ebx
 20a:	c6 03 00             	movb   $0x0,(%ebx)
}
 20d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 210:	5b                   	pop    %ebx
 211:	5e                   	pop    %esi
 212:	5f                   	pop    %edi
 213:	5d                   	pop    %ebp
 214:	c3                   	ret    
 215:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <stat>:

int
stat(char *n, struct stat *st)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	56                   	push   %esi
 224:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 225:	83 ec 08             	sub    $0x8,%esp
 228:	6a 00                	push   $0x0
 22a:	ff 75 08             	pushl  0x8(%ebp)
 22d:	e8 f1 00 00 00       	call   323 <open>
  if(fd < 0)
 232:	83 c4 10             	add    $0x10,%esp
 235:	85 c0                	test   %eax,%eax
 237:	78 27                	js     260 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 239:	83 ec 08             	sub    $0x8,%esp
 23c:	ff 75 0c             	pushl  0xc(%ebp)
 23f:	89 c3                	mov    %eax,%ebx
 241:	50                   	push   %eax
 242:	e8 f4 00 00 00       	call   33b <fstat>
  close(fd);
 247:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 24a:	89 c6                	mov    %eax,%esi
  close(fd);
 24c:	e8 ba 00 00 00       	call   30b <close>
  return r;
 251:	83 c4 10             	add    $0x10,%esp
}
 254:	8d 65 f8             	lea    -0x8(%ebp),%esp
 257:	89 f0                	mov    %esi,%eax
 259:	5b                   	pop    %ebx
 25a:	5e                   	pop    %esi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 260:	be ff ff ff ff       	mov    $0xffffffff,%esi
 265:	eb ed                	jmp    254 <stat+0x34>
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax

00000270 <atoi>:

int
atoi(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 277:	0f be 02             	movsbl (%edx),%eax
 27a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 27d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 280:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 285:	77 1e                	ja     2a5 <atoi+0x35>
 287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 290:	83 c2 01             	add    $0x1,%edx
 293:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 296:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 29a:	0f be 02             	movsbl (%edx),%eax
 29d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2a0:	80 fb 09             	cmp    $0x9,%bl
 2a3:	76 eb                	jbe    290 <atoi+0x20>
  return n;
}
 2a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2a8:	89 c8                	mov    %ecx,%eax
 2aa:	c9                   	leave  
 2ab:	c3                   	ret    
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	8b 45 10             	mov    0x10(%ebp),%eax
 2b7:	8b 55 08             	mov    0x8(%ebp),%edx
 2ba:	56                   	push   %esi
 2bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2be:	85 c0                	test   %eax,%eax
 2c0:	7e 13                	jle    2d5 <memmove+0x25>
 2c2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2c4:	89 d7                	mov    %edx,%edi
 2c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 2d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2d1:	39 f8                	cmp    %edi,%eax
 2d3:	75 fb                	jne    2d0 <memmove+0x20>
  return vdst;
}
 2d5:	5e                   	pop    %esi
 2d6:	89 d0                	mov    %edx,%eax
 2d8:	5f                   	pop    %edi
 2d9:	5d                   	pop    %ebp
 2da:	c3                   	ret    

000002db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2db:	b8 01 00 00 00       	mov    $0x1,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <exit>:
SYSCALL(exit)
 2e3:	b8 02 00 00 00       	mov    $0x2,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <wait>:
SYSCALL(wait)
 2eb:	b8 03 00 00 00       	mov    $0x3,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <pipe>:
SYSCALL(pipe)
 2f3:	b8 04 00 00 00       	mov    $0x4,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <read>:
SYSCALL(read)
 2fb:	b8 05 00 00 00       	mov    $0x5,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <write>:
SYSCALL(write)
 303:	b8 10 00 00 00       	mov    $0x10,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <close>:
SYSCALL(close)
 30b:	b8 15 00 00 00       	mov    $0x15,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <kill>:
SYSCALL(kill)
 313:	b8 06 00 00 00       	mov    $0x6,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <exec>:
SYSCALL(exec)
 31b:	b8 07 00 00 00       	mov    $0x7,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <open>:
SYSCALL(open)
 323:	b8 0f 00 00 00       	mov    $0xf,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <mknod>:
SYSCALL(mknod)
 32b:	b8 11 00 00 00       	mov    $0x11,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <unlink>:
SYSCALL(unlink)
 333:	b8 12 00 00 00       	mov    $0x12,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <fstat>:
SYSCALL(fstat)
 33b:	b8 08 00 00 00       	mov    $0x8,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <link>:
SYSCALL(link)
 343:	b8 13 00 00 00       	mov    $0x13,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <mkdir>:
SYSCALL(mkdir)
 34b:	b8 14 00 00 00       	mov    $0x14,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <chdir>:
SYSCALL(chdir)
 353:	b8 09 00 00 00       	mov    $0x9,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <dup>:
SYSCALL(dup)
 35b:	b8 0a 00 00 00       	mov    $0xa,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <getpid>:
SYSCALL(getpid)
 363:	b8 0b 00 00 00       	mov    $0xb,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <sbrk>:
SYSCALL(sbrk)
 36b:	b8 0c 00 00 00       	mov    $0xc,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <sleep>:
SYSCALL(sleep)
 373:	b8 0d 00 00 00       	mov    $0xd,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <uptime>:
SYSCALL(uptime)
 37b:	b8 0e 00 00 00       	mov    $0xe,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <halt>:
SYSCALL(halt)
 383:	b8 16 00 00 00       	mov    $0x16,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <cps>:
SYSCALL(cps)
 38b:	b8 17 00 00 00       	mov    $0x17,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <chpr>:
SYSCALL(chpr)
 393:	b8 18 00 00 00       	mov    $0x18,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <getNumProc>:
SYSCALL(getNumProc)
 39b:	b8 19 00 00 00       	mov    $0x19,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <getMaxPid>:
SYSCALL(getMaxPid)
 3a3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <getProcInfo>:
SYSCALL(getProcInfo)
 3ab:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <setprio>:
SYSCALL(setprio)
 3b3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <getprio>:
SYSCALL(getprio)
 3bb:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    
 3c3:	66 90                	xchg   %ax,%ax
 3c5:	66 90                	xchg   %ax,%ax
 3c7:	66 90                	xchg   %ax,%ax
 3c9:	66 90                	xchg   %ax,%ax
 3cb:	66 90                	xchg   %ax,%ax
 3cd:	66 90                	xchg   %ax,%ax
 3cf:	90                   	nop

000003d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 3c             	sub    $0x3c,%esp
 3d9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3dc:	89 d1                	mov    %edx,%ecx
{
 3de:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3e1:	85 d2                	test   %edx,%edx
 3e3:	0f 89 7f 00 00 00    	jns    468 <printint+0x98>
 3e9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3ed:	74 79                	je     468 <printint+0x98>
    neg = 1;
 3ef:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3f6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 3f8:	31 db                	xor    %ebx,%ebx
 3fa:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 400:	89 c8                	mov    %ecx,%eax
 402:	31 d2                	xor    %edx,%edx
 404:	89 cf                	mov    %ecx,%edi
 406:	f7 75 c4             	divl   -0x3c(%ebp)
 409:	0f b6 92 48 08 00 00 	movzbl 0x848(%edx),%edx
 410:	89 45 c0             	mov    %eax,-0x40(%ebp)
 413:	89 d8                	mov    %ebx,%eax
 415:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 418:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 41b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 41e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 421:	76 dd                	jbe    400 <printint+0x30>
  if(neg)
 423:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 426:	85 c9                	test   %ecx,%ecx
 428:	74 0c                	je     436 <printint+0x66>
    buf[i++] = '-';
 42a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 42f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 431:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 436:	8b 7d b8             	mov    -0x48(%ebp),%edi
 439:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 43d:	eb 07                	jmp    446 <printint+0x76>
 43f:	90                   	nop
    putc(fd, buf[i]);
 440:	0f b6 13             	movzbl (%ebx),%edx
 443:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 446:	83 ec 04             	sub    $0x4,%esp
 449:	88 55 d7             	mov    %dl,-0x29(%ebp)
 44c:	6a 01                	push   $0x1
 44e:	56                   	push   %esi
 44f:	57                   	push   %edi
 450:	e8 ae fe ff ff       	call   303 <write>
  while(--i >= 0)
 455:	83 c4 10             	add    $0x10,%esp
 458:	39 de                	cmp    %ebx,%esi
 45a:	75 e4                	jne    440 <printint+0x70>
}
 45c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45f:	5b                   	pop    %ebx
 460:	5e                   	pop    %esi
 461:	5f                   	pop    %edi
 462:	5d                   	pop    %ebp
 463:	c3                   	ret    
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 468:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 46f:	eb 87                	jmp    3f8 <printint+0x28>
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47f:	90                   	nop

00000480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 489:	8b 75 0c             	mov    0xc(%ebp),%esi
 48c:	0f b6 1e             	movzbl (%esi),%ebx
 48f:	84 db                	test   %bl,%bl
 491:	0f 84 b8 00 00 00    	je     54f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 497:	8d 45 10             	lea    0x10(%ebp),%eax
 49a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 49d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4a0:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 4a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4a5:	eb 37                	jmp    4de <printf+0x5e>
 4a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ae:	66 90                	xchg   %ax,%ax
 4b0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4b3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4b8:	83 f8 25             	cmp    $0x25,%eax
 4bb:	74 17                	je     4d4 <printf+0x54>
  write(fd, &c, 1);
 4bd:	83 ec 04             	sub    $0x4,%esp
 4c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4c3:	6a 01                	push   $0x1
 4c5:	57                   	push   %edi
 4c6:	ff 75 08             	pushl  0x8(%ebp)
 4c9:	e8 35 fe ff ff       	call   303 <write>
 4ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4d1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4d4:	0f b6 1e             	movzbl (%esi),%ebx
 4d7:	83 c6 01             	add    $0x1,%esi
 4da:	84 db                	test   %bl,%bl
 4dc:	74 71                	je     54f <printf+0xcf>
    c = fmt[i] & 0xff;
 4de:	0f be cb             	movsbl %bl,%ecx
 4e1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4e4:	85 d2                	test   %edx,%edx
 4e6:	74 c8                	je     4b0 <printf+0x30>
      }
    } else if(state == '%'){
 4e8:	83 fa 25             	cmp    $0x25,%edx
 4eb:	75 e7                	jne    4d4 <printf+0x54>
      if(c == 'd'){
 4ed:	83 f8 64             	cmp    $0x64,%eax
 4f0:	0f 84 9a 00 00 00    	je     590 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4f6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4fc:	83 f9 70             	cmp    $0x70,%ecx
 4ff:	74 5f                	je     560 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 501:	83 f8 73             	cmp    $0x73,%eax
 504:	0f 84 d6 00 00 00    	je     5e0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 50a:	83 f8 63             	cmp    $0x63,%eax
 50d:	0f 84 8d 00 00 00    	je     5a0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 513:	83 f8 25             	cmp    $0x25,%eax
 516:	0f 84 b4 00 00 00    	je     5d0 <printf+0x150>
  write(fd, &c, 1);
 51c:	83 ec 04             	sub    $0x4,%esp
 51f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 523:	6a 01                	push   $0x1
 525:	57                   	push   %edi
 526:	ff 75 08             	pushl  0x8(%ebp)
 529:	e8 d5 fd ff ff       	call   303 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 52e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 531:	83 c4 0c             	add    $0xc,%esp
 534:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
 536:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 539:	57                   	push   %edi
 53a:	ff 75 08             	pushl  0x8(%ebp)
 53d:	e8 c1 fd ff ff       	call   303 <write>
  for(i = 0; fmt[i]; i++){
 542:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 546:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 549:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 54b:	84 db                	test   %bl,%bl
 54d:	75 8f                	jne    4de <printf+0x5e>
    }
  }
}
 54f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 552:	5b                   	pop    %ebx
 553:	5e                   	pop    %esi
 554:	5f                   	pop    %edi
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    
 557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	b9 10 00 00 00       	mov    $0x10,%ecx
 568:	6a 00                	push   $0x0
 56a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	8b 13                	mov    (%ebx),%edx
 572:	e8 59 fe ff ff       	call   3d0 <printint>
        ap++;
 577:	89 d8                	mov    %ebx,%eax
 579:	83 c4 10             	add    $0x10,%esp
      state = 0;
 57c:	31 d2                	xor    %edx,%edx
        ap++;
 57e:	83 c0 04             	add    $0x4,%eax
 581:	89 45 d0             	mov    %eax,-0x30(%ebp)
 584:	e9 4b ff ff ff       	jmp    4d4 <printf+0x54>
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	b9 0a 00 00 00       	mov    $0xa,%ecx
 598:	6a 01                	push   $0x1
 59a:	eb ce                	jmp    56a <printf+0xea>
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 5a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5a6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 5a8:	6a 01                	push   $0x1
        ap++;
 5aa:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 5ad:	57                   	push   %edi
 5ae:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5b1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5b4:	e8 4a fd ff ff       	call   303 <write>
        ap++;
 5b9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5bc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5bf:	31 d2                	xor    %edx,%edx
 5c1:	e9 0e ff ff ff       	jmp    4d4 <printf+0x54>
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 5d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5d3:	83 ec 04             	sub    $0x4,%esp
 5d6:	e9 59 ff ff ff       	jmp    534 <printf+0xb4>
 5db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5df:	90                   	nop
        s = (char*)*ap;
 5e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5e3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5e5:	83 c0 04             	add    $0x4,%eax
 5e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5eb:	85 db                	test   %ebx,%ebx
 5ed:	74 17                	je     606 <printf+0x186>
        while(*s != 0){
 5ef:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5f2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5f4:	84 c0                	test   %al,%al
 5f6:	0f 84 d8 fe ff ff    	je     4d4 <printf+0x54>
 5fc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5ff:	89 de                	mov    %ebx,%esi
 601:	8b 5d 08             	mov    0x8(%ebp),%ebx
 604:	eb 1a                	jmp    620 <printf+0x1a0>
          s = "(null)";
 606:	bb 41 08 00 00       	mov    $0x841,%ebx
        while(*s != 0){
 60b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 60e:	b8 28 00 00 00       	mov    $0x28,%eax
 613:	89 de                	mov    %ebx,%esi
 615:	8b 5d 08             	mov    0x8(%ebp),%ebx
 618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
  write(fd, &c, 1);
 620:	83 ec 04             	sub    $0x4,%esp
          s++;
 623:	83 c6 01             	add    $0x1,%esi
 626:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 629:	6a 01                	push   $0x1
 62b:	57                   	push   %edi
 62c:	53                   	push   %ebx
 62d:	e8 d1 fc ff ff       	call   303 <write>
        while(*s != 0){
 632:	0f b6 06             	movzbl (%esi),%eax
 635:	83 c4 10             	add    $0x10,%esp
 638:	84 c0                	test   %al,%al
 63a:	75 e4                	jne    620 <printf+0x1a0>
      state = 0;
 63c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 63f:	31 d2                	xor    %edx,%edx
 641:	e9 8e fe ff ff       	jmp    4d4 <printf+0x54>
 646:	66 90                	xchg   %ax,%ax
 648:	66 90                	xchg   %ax,%ax
 64a:	66 90                	xchg   %ax,%ax
 64c:	66 90                	xchg   %ax,%ax
 64e:	66 90                	xchg   %ax,%ax

00000650 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 650:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	a1 f4 0a 00 00       	mov    0xaf4,%eax
{
 656:	89 e5                	mov    %esp,%ebp
 658:	57                   	push   %edi
 659:	56                   	push   %esi
 65a:	53                   	push   %ebx
 65b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 65e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 668:	89 c2                	mov    %eax,%edx
 66a:	8b 00                	mov    (%eax),%eax
 66c:	39 ca                	cmp    %ecx,%edx
 66e:	73 30                	jae    6a0 <free+0x50>
 670:	39 c1                	cmp    %eax,%ecx
 672:	72 04                	jb     678 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 674:	39 c2                	cmp    %eax,%edx
 676:	72 f0                	jb     668 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 678:	8b 73 fc             	mov    -0x4(%ebx),%esi
 67b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 67e:	39 f8                	cmp    %edi,%eax
 680:	74 30                	je     6b2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 682:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 685:	8b 42 04             	mov    0x4(%edx),%eax
 688:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 68b:	39 f1                	cmp    %esi,%ecx
 68d:	74 3a                	je     6c9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 68f:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
 691:	5b                   	pop    %ebx
  freep = p;
 692:	89 15 f4 0a 00 00    	mov    %edx,0xaf4
}
 698:	5e                   	pop    %esi
 699:	5f                   	pop    %edi
 69a:	5d                   	pop    %ebp
 69b:	c3                   	ret    
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a0:	39 c2                	cmp    %eax,%edx
 6a2:	72 c4                	jb     668 <free+0x18>
 6a4:	39 c1                	cmp    %eax,%ecx
 6a6:	73 c0                	jae    668 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 6a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ae:	39 f8                	cmp    %edi,%eax
 6b0:	75 d0                	jne    682 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 6b2:	03 70 04             	add    0x4(%eax),%esi
 6b5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b8:	8b 02                	mov    (%edx),%eax
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6bf:	8b 42 04             	mov    0x4(%edx),%eax
 6c2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6c5:	39 f1                	cmp    %esi,%ecx
 6c7:	75 c6                	jne    68f <free+0x3f>
    p->s.size += bp->s.size;
 6c9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 6cc:	89 15 f4 0a 00 00    	mov    %edx,0xaf4
    p->s.size += bp->s.size;
 6d2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6d5:	8b 43 f8             	mov    -0x8(%ebx),%eax
 6d8:	89 02                	mov    %eax,(%edx)
}
 6da:	5b                   	pop    %ebx
 6db:	5e                   	pop    %esi
 6dc:	5f                   	pop    %edi
 6dd:	5d                   	pop    %ebp
 6de:	c3                   	ret    
 6df:	90                   	nop

000006e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	56                   	push   %esi
 6e5:	53                   	push   %ebx
 6e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ec:	8b 3d f4 0a 00 00    	mov    0xaf4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f2:	8d 70 07             	lea    0x7(%eax),%esi
 6f5:	c1 ee 03             	shr    $0x3,%esi
 6f8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6fb:	85 ff                	test   %edi,%edi
 6fd:	0f 84 ad 00 00 00    	je     7b0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 703:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 705:	8b 48 04             	mov    0x4(%eax),%ecx
 708:	39 f1                	cmp    %esi,%ecx
 70a:	73 71                	jae    77d <malloc+0x9d>
 70c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 712:	bb 00 10 00 00       	mov    $0x1000,%ebx
 717:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 71a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 721:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 724:	eb 1b                	jmp    741 <malloc+0x61>
 726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 730:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 732:	8b 4a 04             	mov    0x4(%edx),%ecx
 735:	39 f1                	cmp    %esi,%ecx
 737:	73 4f                	jae    788 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 739:	8b 3d f4 0a 00 00    	mov    0xaf4,%edi
 73f:	89 d0                	mov    %edx,%eax
 741:	39 c7                	cmp    %eax,%edi
 743:	75 eb                	jne    730 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 745:	83 ec 0c             	sub    $0xc,%esp
 748:	ff 75 e4             	pushl  -0x1c(%ebp)
 74b:	e8 1b fc ff ff       	call   36b <sbrk>
  if(p == (char*)-1)
 750:	83 c4 10             	add    $0x10,%esp
 753:	83 f8 ff             	cmp    $0xffffffff,%eax
 756:	74 1b                	je     773 <malloc+0x93>
  hp->s.size = nu;
 758:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 75b:	83 ec 0c             	sub    $0xc,%esp
 75e:	83 c0 08             	add    $0x8,%eax
 761:	50                   	push   %eax
 762:	e8 e9 fe ff ff       	call   650 <free>
  return freep;
 767:	a1 f4 0a 00 00       	mov    0xaf4,%eax
      if((p = morecore(nunits)) == 0)
 76c:	83 c4 10             	add    $0x10,%esp
 76f:	85 c0                	test   %eax,%eax
 771:	75 bd                	jne    730 <malloc+0x50>
        return 0;
  }
}
 773:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 776:	31 c0                	xor    %eax,%eax
}
 778:	5b                   	pop    %ebx
 779:	5e                   	pop    %esi
 77a:	5f                   	pop    %edi
 77b:	5d                   	pop    %ebp
 77c:	c3                   	ret    
    if(p->s.size >= nunits){
 77d:	89 c2                	mov    %eax,%edx
 77f:	89 f8                	mov    %edi,%eax
 781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 788:	39 ce                	cmp    %ecx,%esi
 78a:	74 54                	je     7e0 <malloc+0x100>
        p->s.size -= nunits;
 78c:	29 f1                	sub    %esi,%ecx
 78e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 791:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 794:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 797:	a3 f4 0a 00 00       	mov    %eax,0xaf4
}
 79c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 79f:	8d 42 08             	lea    0x8(%edx),%eax
}
 7a2:	5b                   	pop    %ebx
 7a3:	5e                   	pop    %esi
 7a4:	5f                   	pop    %edi
 7a5:	5d                   	pop    %ebp
 7a6:	c3                   	ret    
 7a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ae:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7b0:	c7 05 f4 0a 00 00 f8 	movl   $0xaf8,0xaf4
 7b7:	0a 00 00 
    base.s.size = 0;
 7ba:	bf f8 0a 00 00       	mov    $0xaf8,%edi
    base.s.ptr = freep = prevp = &base;
 7bf:	c7 05 f8 0a 00 00 f8 	movl   $0xaf8,0xaf8
 7c6:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 7cb:	c7 05 fc 0a 00 00 00 	movl   $0x0,0xafc
 7d2:	00 00 00 
    if(p->s.size >= nunits){
 7d5:	e9 32 ff ff ff       	jmp    70c <malloc+0x2c>
 7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 0a                	mov    (%edx),%ecx
 7e2:	89 08                	mov    %ecx,(%eax)
 7e4:	eb b1                	jmp    797 <malloc+0xb7>

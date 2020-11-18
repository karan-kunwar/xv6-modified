
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 23 4d 00 00       	push   $0x4d23
      16:	6a 01                	push   $0x1
      18:	e8 d3 39 00 00       	call   39f0 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 37 4d 00 00       	push   $0x4d37
      26:	e8 68 38 00 00       	call   3893 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 a0 54 00 00       	push   $0x54a0
      39:	6a 01                	push   $0x1
      3b:	e8 b0 39 00 00       	call   39f0 <printf>
    exit();
      40:	e8 0e 38 00 00       	call   3853 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 37 4d 00 00       	push   $0x4d37
      51:	e8 3d 38 00 00       	call   3893 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 1d 38 00 00       	call   387b <close>

  createdelete();
      5e:	e8 ad 11 00 00       	call   1210 <createdelete>
  linkunlink();
      63:	e8 68 1a 00 00       	call   1ad0 <linkunlink>
  concreate();
      68:	e8 63 17 00 00       	call   17d0 <concreate>
  fourfiles();
      6d:	e8 9e 0f 00 00       	call   1010 <fourfiles>
  sharedfd();
      72:	e8 d9 0d 00 00       	call   e50 <sharedfd>

  bigargtest();
      77:	e8 24 32 00 00       	call   32a0 <bigargtest>
  bigwrite();
      7c:	e8 6f 23 00 00       	call   23f0 <bigwrite>
  bigargtest();
      81:	e8 1a 32 00 00       	call   32a0 <bigargtest>
  bsstest();
      86:	e8 a5 31 00 00       	call   3230 <bsstest>
  sbrktest();
      8b:	e8 a0 2c 00 00       	call   2d30 <sbrktest>
  validatetest();
      90:	e8 eb 30 00 00       	call   3180 <validatetest>

  opentest();
      95:	e8 56 03 00 00       	call   3f0 <opentest>
  writetest();
      9a:	e8 e1 03 00 00       	call   480 <writetest>
  writetest1();
      9f:	e8 bc 05 00 00       	call   660 <writetest1>
  createtest();
      a4:	e8 87 07 00 00       	call   830 <createtest>

  openiputtest();
      a9:	e8 42 02 00 00       	call   2f0 <openiputtest>
  exitiputtest();
      ae:	e8 3d 01 00 00       	call   1f0 <exitiputtest>
  iputtest();
      b3:	e8 58 00 00 00       	call   110 <iputtest>

  mem();
      b8:	e8 c3 0c 00 00       	call   d80 <mem>
  pipe1();
      bd:	e8 4e 09 00 00       	call   a10 <pipe1>
  preempt();
      c2:	e8 d9 0a 00 00       	call   ba0 <preempt>
  exitwait();
      c7:	e8 34 0c 00 00       	call   d00 <exitwait>

  rmdot();
      cc:	e8 0f 27 00 00       	call   27e0 <rmdot>
  fourteen();
      d1:	e8 ca 25 00 00       	call   26a0 <fourteen>
  bigfile();
      d6:	e8 f5 23 00 00       	call   24d0 <bigfile>
  subdir();
      db:	e8 30 1c 00 00       	call   1d10 <subdir>
  linktest();
      e0:	e8 db 14 00 00       	call   15c0 <linktest>
  unlinkread();
      e5:	e8 46 13 00 00       	call   1430 <unlinkread>
  dirfile();
      ea:	e8 71 28 00 00       	call   2960 <dirfile>
  iref();
      ef:	e8 6c 2a 00 00       	call   2b60 <iref>
  forktest();
      f4:	e8 87 2b 00 00       	call   2c80 <forktest>
  bigdir(); // slow
      f9:	e8 e2 1a 00 00       	call   1be0 <bigdir>

  uio();
      fe:	e8 6d 34 00 00       	call   3570 <uio>

  exectest();
     103:	e8 b8 08 00 00       	call   9c0 <exectest>

  exit();
     108:	e8 46 37 00 00       	call   3853 <exit>
     10d:	66 90                	xchg   %ax,%ax
     10f:	90                   	nop

00000110 <iputtest>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     116:	68 ec 3d 00 00       	push   $0x3dec
     11b:	ff 35 a0 5d 00 00    	pushl  0x5da0
     121:	e8 ca 38 00 00       	call   39f0 <printf>
  if(mkdir("iputdir") < 0){
     126:	c7 04 24 7f 3d 00 00 	movl   $0x3d7f,(%esp)
     12d:	e8 89 37 00 00       	call   38bb <mkdir>
     132:	83 c4 10             	add    $0x10,%esp
     135:	85 c0                	test   %eax,%eax
     137:	78 58                	js     191 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     139:	83 ec 0c             	sub    $0xc,%esp
     13c:	68 7f 3d 00 00       	push   $0x3d7f
     141:	e8 7d 37 00 00       	call   38c3 <chdir>
     146:	83 c4 10             	add    $0x10,%esp
     149:	85 c0                	test   %eax,%eax
     14b:	0f 88 85 00 00 00    	js     1d6 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     151:	83 ec 0c             	sub    $0xc,%esp
     154:	68 7c 3d 00 00       	push   $0x3d7c
     159:	e8 45 37 00 00       	call   38a3 <unlink>
     15e:	83 c4 10             	add    $0x10,%esp
     161:	85 c0                	test   %eax,%eax
     163:	78 5a                	js     1bf <iputtest+0xaf>
  if(chdir("/") < 0){
     165:	83 ec 0c             	sub    $0xc,%esp
     168:	68 a1 3d 00 00       	push   $0x3da1
     16d:	e8 51 37 00 00       	call   38c3 <chdir>
     172:	83 c4 10             	add    $0x10,%esp
     175:	85 c0                	test   %eax,%eax
     177:	78 2f                	js     1a8 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     179:	83 ec 08             	sub    $0x8,%esp
     17c:	68 24 3e 00 00       	push   $0x3e24
     181:	ff 35 a0 5d 00 00    	pushl  0x5da0
     187:	e8 64 38 00 00       	call   39f0 <printf>
}
     18c:	83 c4 10             	add    $0x10,%esp
     18f:	c9                   	leave  
     190:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     191:	50                   	push   %eax
     192:	50                   	push   %eax
     193:	68 58 3d 00 00       	push   $0x3d58
     198:	ff 35 a0 5d 00 00    	pushl  0x5da0
     19e:	e8 4d 38 00 00       	call   39f0 <printf>
    exit();
     1a3:	e8 ab 36 00 00       	call   3853 <exit>
    printf(stdout, "chdir / failed\n");
     1a8:	50                   	push   %eax
     1a9:	50                   	push   %eax
     1aa:	68 a3 3d 00 00       	push   $0x3da3
     1af:	ff 35 a0 5d 00 00    	pushl  0x5da0
     1b5:	e8 36 38 00 00       	call   39f0 <printf>
    exit();
     1ba:	e8 94 36 00 00       	call   3853 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1bf:	52                   	push   %edx
     1c0:	52                   	push   %edx
     1c1:	68 87 3d 00 00       	push   $0x3d87
     1c6:	ff 35 a0 5d 00 00    	pushl  0x5da0
     1cc:	e8 1f 38 00 00       	call   39f0 <printf>
    exit();
     1d1:	e8 7d 36 00 00       	call   3853 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1d6:	51                   	push   %ecx
     1d7:	51                   	push   %ecx
     1d8:	68 66 3d 00 00       	push   $0x3d66
     1dd:	ff 35 a0 5d 00 00    	pushl  0x5da0
     1e3:	e8 08 38 00 00       	call   39f0 <printf>
    exit();
     1e8:	e8 66 36 00 00       	call   3853 <exit>
     1ed:	8d 76 00             	lea    0x0(%esi),%esi

000001f0 <exitiputtest>:
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     1f6:	68 b3 3d 00 00       	push   $0x3db3
     1fb:	ff 35 a0 5d 00 00    	pushl  0x5da0
     201:	e8 ea 37 00 00       	call   39f0 <printf>
  pid = fork();
     206:	e8 40 36 00 00       	call   384b <fork>
  if(pid < 0){
     20b:	83 c4 10             	add    $0x10,%esp
     20e:	85 c0                	test   %eax,%eax
     210:	0f 88 8a 00 00 00    	js     2a0 <exitiputtest+0xb0>
  if(pid == 0){
     216:	75 50                	jne    268 <exitiputtest+0x78>
    if(mkdir("iputdir") < 0){
     218:	83 ec 0c             	sub    $0xc,%esp
     21b:	68 7f 3d 00 00       	push   $0x3d7f
     220:	e8 96 36 00 00       	call   38bb <mkdir>
     225:	83 c4 10             	add    $0x10,%esp
     228:	85 c0                	test   %eax,%eax
     22a:	0f 88 87 00 00 00    	js     2b7 <exitiputtest+0xc7>
    if(chdir("iputdir") < 0){
     230:	83 ec 0c             	sub    $0xc,%esp
     233:	68 7f 3d 00 00       	push   $0x3d7f
     238:	e8 86 36 00 00       	call   38c3 <chdir>
     23d:	83 c4 10             	add    $0x10,%esp
     240:	85 c0                	test   %eax,%eax
     242:	0f 88 86 00 00 00    	js     2ce <exitiputtest+0xde>
    if(unlink("../iputdir") < 0){
     248:	83 ec 0c             	sub    $0xc,%esp
     24b:	68 7c 3d 00 00       	push   $0x3d7c
     250:	e8 4e 36 00 00       	call   38a3 <unlink>
     255:	83 c4 10             	add    $0x10,%esp
     258:	85 c0                	test   %eax,%eax
     25a:	78 2c                	js     288 <exitiputtest+0x98>
    exit();
     25c:	e8 f2 35 00 00       	call   3853 <exit>
     261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  wait();
     268:	e8 ee 35 00 00       	call   385b <wait>
  printf(stdout, "exitiput test ok\n");
     26d:	83 ec 08             	sub    $0x8,%esp
     270:	68 d6 3d 00 00       	push   $0x3dd6
     275:	ff 35 a0 5d 00 00    	pushl  0x5da0
     27b:	e8 70 37 00 00       	call   39f0 <printf>
}
     280:	83 c4 10             	add    $0x10,%esp
     283:	c9                   	leave  
     284:	c3                   	ret    
     285:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     288:	83 ec 08             	sub    $0x8,%esp
     28b:	68 87 3d 00 00       	push   $0x3d87
     290:	ff 35 a0 5d 00 00    	pushl  0x5da0
     296:	e8 55 37 00 00       	call   39f0 <printf>
      exit();
     29b:	e8 b3 35 00 00       	call   3853 <exit>
    printf(stdout, "fork failed\n");
     2a0:	51                   	push   %ecx
     2a1:	51                   	push   %ecx
     2a2:	68 99 4c 00 00       	push   $0x4c99
     2a7:	ff 35 a0 5d 00 00    	pushl  0x5da0
     2ad:	e8 3e 37 00 00       	call   39f0 <printf>
    exit();
     2b2:	e8 9c 35 00 00       	call   3853 <exit>
      printf(stdout, "mkdir failed\n");
     2b7:	52                   	push   %edx
     2b8:	52                   	push   %edx
     2b9:	68 58 3d 00 00       	push   $0x3d58
     2be:	ff 35 a0 5d 00 00    	pushl  0x5da0
     2c4:	e8 27 37 00 00       	call   39f0 <printf>
      exit();
     2c9:	e8 85 35 00 00       	call   3853 <exit>
      printf(stdout, "child chdir failed\n");
     2ce:	50                   	push   %eax
     2cf:	50                   	push   %eax
     2d0:	68 c2 3d 00 00       	push   $0x3dc2
     2d5:	ff 35 a0 5d 00 00    	pushl  0x5da0
     2db:	e8 10 37 00 00       	call   39f0 <printf>
      exit();
     2e0:	e8 6e 35 00 00       	call   3853 <exit>
     2e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002f0 <openiputtest>:
{
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     2f6:	68 e8 3d 00 00       	push   $0x3de8
     2fb:	ff 35 a0 5d 00 00    	pushl  0x5da0
     301:	e8 ea 36 00 00       	call   39f0 <printf>
  if(mkdir("oidir") < 0){
     306:	c7 04 24 f7 3d 00 00 	movl   $0x3df7,(%esp)
     30d:	e8 a9 35 00 00       	call   38bb <mkdir>
     312:	83 c4 10             	add    $0x10,%esp
     315:	85 c0                	test   %eax,%eax
     317:	0f 88 9f 00 00 00    	js     3bc <openiputtest+0xcc>
  pid = fork();
     31d:	e8 29 35 00 00       	call   384b <fork>
  if(pid < 0){
     322:	85 c0                	test   %eax,%eax
     324:	78 7f                	js     3a5 <openiputtest+0xb5>
  if(pid == 0){
     326:	75 38                	jne    360 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     328:	83 ec 08             	sub    $0x8,%esp
     32b:	6a 02                	push   $0x2
     32d:	68 f7 3d 00 00       	push   $0x3df7
     332:	e8 5c 35 00 00       	call   3893 <open>
    if(fd >= 0){
     337:	83 c4 10             	add    $0x10,%esp
     33a:	85 c0                	test   %eax,%eax
     33c:	78 62                	js     3a0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     33e:	83 ec 08             	sub    $0x8,%esp
     341:	68 58 4d 00 00       	push   $0x4d58
     346:	ff 35 a0 5d 00 00    	pushl  0x5da0
     34c:	e8 9f 36 00 00       	call   39f0 <printf>
      exit();
     351:	e8 fd 34 00 00       	call   3853 <exit>
     356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     35d:	8d 76 00             	lea    0x0(%esi),%esi
  sleep(1);
     360:	83 ec 0c             	sub    $0xc,%esp
     363:	6a 01                	push   $0x1
     365:	e8 79 35 00 00       	call   38e3 <sleep>
  if(unlink("oidir") != 0){
     36a:	c7 04 24 f7 3d 00 00 	movl   $0x3df7,(%esp)
     371:	e8 2d 35 00 00       	call   38a3 <unlink>
     376:	83 c4 10             	add    $0x10,%esp
     379:	85 c0                	test   %eax,%eax
     37b:	75 56                	jne    3d3 <openiputtest+0xe3>
  wait();
     37d:	e8 d9 34 00 00       	call   385b <wait>
  printf(stdout, "openiput test ok\n");
     382:	83 ec 08             	sub    $0x8,%esp
     385:	68 20 3e 00 00       	push   $0x3e20
     38a:	ff 35 a0 5d 00 00    	pushl  0x5da0
     390:	e8 5b 36 00 00       	call   39f0 <printf>
}
     395:	83 c4 10             	add    $0x10,%esp
     398:	c9                   	leave  
     399:	c3                   	ret    
     39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     3a0:	e8 ae 34 00 00       	call   3853 <exit>
    printf(stdout, "fork failed\n");
     3a5:	52                   	push   %edx
     3a6:	52                   	push   %edx
     3a7:	68 99 4c 00 00       	push   $0x4c99
     3ac:	ff 35 a0 5d 00 00    	pushl  0x5da0
     3b2:	e8 39 36 00 00       	call   39f0 <printf>
    exit();
     3b7:	e8 97 34 00 00       	call   3853 <exit>
    printf(stdout, "mkdir oidir failed\n");
     3bc:	51                   	push   %ecx
     3bd:	51                   	push   %ecx
     3be:	68 fd 3d 00 00       	push   $0x3dfd
     3c3:	ff 35 a0 5d 00 00    	pushl  0x5da0
     3c9:	e8 22 36 00 00       	call   39f0 <printf>
    exit();
     3ce:	e8 80 34 00 00       	call   3853 <exit>
    printf(stdout, "unlink failed\n");
     3d3:	50                   	push   %eax
     3d4:	50                   	push   %eax
     3d5:	68 11 3e 00 00       	push   $0x3e11
     3da:	ff 35 a0 5d 00 00    	pushl  0x5da0
     3e0:	e8 0b 36 00 00       	call   39f0 <printf>
    exit();
     3e5:	e8 69 34 00 00       	call   3853 <exit>
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003f0 <opentest>:
{
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     3f6:	68 32 3e 00 00       	push   $0x3e32
     3fb:	ff 35 a0 5d 00 00    	pushl  0x5da0
     401:	e8 ea 35 00 00       	call   39f0 <printf>
  fd = open("echo", 0);
     406:	58                   	pop    %eax
     407:	5a                   	pop    %edx
     408:	6a 00                	push   $0x0
     40a:	68 3d 3e 00 00       	push   $0x3e3d
     40f:	e8 7f 34 00 00       	call   3893 <open>
  if(fd < 0){
     414:	83 c4 10             	add    $0x10,%esp
     417:	85 c0                	test   %eax,%eax
     419:	78 36                	js     451 <opentest+0x61>
  close(fd);
     41b:	83 ec 0c             	sub    $0xc,%esp
     41e:	50                   	push   %eax
     41f:	e8 57 34 00 00       	call   387b <close>
  fd = open("doesnotexist", 0);
     424:	5a                   	pop    %edx
     425:	59                   	pop    %ecx
     426:	6a 00                	push   $0x0
     428:	68 55 3e 00 00       	push   $0x3e55
     42d:	e8 61 34 00 00       	call   3893 <open>
  if(fd >= 0){
     432:	83 c4 10             	add    $0x10,%esp
     435:	85 c0                	test   %eax,%eax
     437:	79 2f                	jns    468 <opentest+0x78>
  printf(stdout, "open test ok\n");
     439:	83 ec 08             	sub    $0x8,%esp
     43c:	68 80 3e 00 00       	push   $0x3e80
     441:	ff 35 a0 5d 00 00    	pushl  0x5da0
     447:	e8 a4 35 00 00       	call   39f0 <printf>
}
     44c:	83 c4 10             	add    $0x10,%esp
     44f:	c9                   	leave  
     450:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     451:	50                   	push   %eax
     452:	50                   	push   %eax
     453:	68 42 3e 00 00       	push   $0x3e42
     458:	ff 35 a0 5d 00 00    	pushl  0x5da0
     45e:	e8 8d 35 00 00       	call   39f0 <printf>
    exit();
     463:	e8 eb 33 00 00       	call   3853 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     468:	50                   	push   %eax
     469:	50                   	push   %eax
     46a:	68 62 3e 00 00       	push   $0x3e62
     46f:	ff 35 a0 5d 00 00    	pushl  0x5da0
     475:	e8 76 35 00 00       	call   39f0 <printf>
    exit();
     47a:	e8 d4 33 00 00       	call   3853 <exit>
     47f:	90                   	nop

00000480 <writetest>:
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	56                   	push   %esi
     484:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     485:	83 ec 08             	sub    $0x8,%esp
     488:	68 8e 3e 00 00       	push   $0x3e8e
     48d:	ff 35 a0 5d 00 00    	pushl  0x5da0
     493:	e8 58 35 00 00       	call   39f0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     498:	58                   	pop    %eax
     499:	5a                   	pop    %edx
     49a:	68 02 02 00 00       	push   $0x202
     49f:	68 9f 3e 00 00       	push   $0x3e9f
     4a4:	e8 ea 33 00 00       	call   3893 <open>
  if(fd >= 0){
     4a9:	83 c4 10             	add    $0x10,%esp
     4ac:	85 c0                	test   %eax,%eax
     4ae:	0f 88 88 01 00 00    	js     63c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     4b4:	83 ec 08             	sub    $0x8,%esp
     4b7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4b9:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4bb:	68 a5 3e 00 00       	push   $0x3ea5
     4c0:	ff 35 a0 5d 00 00    	pushl  0x5da0
     4c6:	e8 25 35 00 00       	call   39f0 <printf>
     4cb:	83 c4 10             	add    $0x10,%esp
     4ce:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4d0:	83 ec 04             	sub    $0x4,%esp
     4d3:	6a 0a                	push   $0xa
     4d5:	68 dc 3e 00 00       	push   $0x3edc
     4da:	56                   	push   %esi
     4db:	e8 93 33 00 00       	call   3873 <write>
     4e0:	83 c4 10             	add    $0x10,%esp
     4e3:	83 f8 0a             	cmp    $0xa,%eax
     4e6:	0f 85 d9 00 00 00    	jne    5c5 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4ec:	83 ec 04             	sub    $0x4,%esp
     4ef:	6a 0a                	push   $0xa
     4f1:	68 e7 3e 00 00       	push   $0x3ee7
     4f6:	56                   	push   %esi
     4f7:	e8 77 33 00 00       	call   3873 <write>
     4fc:	83 c4 10             	add    $0x10,%esp
     4ff:	83 f8 0a             	cmp    $0xa,%eax
     502:	0f 85 d6 00 00 00    	jne    5de <writetest+0x15e>
  for(i = 0; i < 100; i++){
     508:	83 c3 01             	add    $0x1,%ebx
     50b:	83 fb 64             	cmp    $0x64,%ebx
     50e:	75 c0                	jne    4d0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     510:	83 ec 08             	sub    $0x8,%esp
     513:	68 f2 3e 00 00       	push   $0x3ef2
     518:	ff 35 a0 5d 00 00    	pushl  0x5da0
     51e:	e8 cd 34 00 00       	call   39f0 <printf>
  close(fd);
     523:	89 34 24             	mov    %esi,(%esp)
     526:	e8 50 33 00 00       	call   387b <close>
  fd = open("small", O_RDONLY);
     52b:	5b                   	pop    %ebx
     52c:	5e                   	pop    %esi
     52d:	6a 00                	push   $0x0
     52f:	68 9f 3e 00 00       	push   $0x3e9f
     534:	e8 5a 33 00 00       	call   3893 <open>
  if(fd >= 0){
     539:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     53c:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     53e:	85 c0                	test   %eax,%eax
     540:	0f 88 b1 00 00 00    	js     5f7 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     546:	83 ec 08             	sub    $0x8,%esp
     549:	68 fd 3e 00 00       	push   $0x3efd
     54e:	ff 35 a0 5d 00 00    	pushl  0x5da0
     554:	e8 97 34 00 00       	call   39f0 <printf>
  i = read(fd, buf, 2000);
     559:	83 c4 0c             	add    $0xc,%esp
     55c:	68 d0 07 00 00       	push   $0x7d0
     561:	68 e0 84 00 00       	push   $0x84e0
     566:	53                   	push   %ebx
     567:	e8 ff 32 00 00       	call   386b <read>
  if(i == 2000){
     56c:	83 c4 10             	add    $0x10,%esp
     56f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     574:	0f 85 94 00 00 00    	jne    60e <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	68 31 3f 00 00       	push   $0x3f31
     582:	ff 35 a0 5d 00 00    	pushl  0x5da0
     588:	e8 63 34 00 00       	call   39f0 <printf>
  close(fd);
     58d:	89 1c 24             	mov    %ebx,(%esp)
     590:	e8 e6 32 00 00       	call   387b <close>
  if(unlink("small") < 0){
     595:	c7 04 24 9f 3e 00 00 	movl   $0x3e9f,(%esp)
     59c:	e8 02 33 00 00       	call   38a3 <unlink>
     5a1:	83 c4 10             	add    $0x10,%esp
     5a4:	85 c0                	test   %eax,%eax
     5a6:	78 7d                	js     625 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     5a8:	83 ec 08             	sub    $0x8,%esp
     5ab:	68 59 3f 00 00       	push   $0x3f59
     5b0:	ff 35 a0 5d 00 00    	pushl  0x5da0
     5b6:	e8 35 34 00 00       	call   39f0 <printf>
}
     5bb:	83 c4 10             	add    $0x10,%esp
     5be:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5c1:	5b                   	pop    %ebx
     5c2:	5e                   	pop    %esi
     5c3:	5d                   	pop    %ebp
     5c4:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5c5:	83 ec 04             	sub    $0x4,%esp
     5c8:	53                   	push   %ebx
     5c9:	68 7c 4d 00 00       	push   $0x4d7c
     5ce:	ff 35 a0 5d 00 00    	pushl  0x5da0
     5d4:	e8 17 34 00 00       	call   39f0 <printf>
      exit();
     5d9:	e8 75 32 00 00       	call   3853 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5de:	83 ec 04             	sub    $0x4,%esp
     5e1:	53                   	push   %ebx
     5e2:	68 a0 4d 00 00       	push   $0x4da0
     5e7:	ff 35 a0 5d 00 00    	pushl  0x5da0
     5ed:	e8 fe 33 00 00       	call   39f0 <printf>
      exit();
     5f2:	e8 5c 32 00 00       	call   3853 <exit>
    printf(stdout, "error: open small failed!\n");
     5f7:	51                   	push   %ecx
     5f8:	51                   	push   %ecx
     5f9:	68 16 3f 00 00       	push   $0x3f16
     5fe:	ff 35 a0 5d 00 00    	pushl  0x5da0
     604:	e8 e7 33 00 00       	call   39f0 <printf>
    exit();
     609:	e8 45 32 00 00       	call   3853 <exit>
    printf(stdout, "read failed\n");
     60e:	52                   	push   %edx
     60f:	52                   	push   %edx
     610:	68 5d 42 00 00       	push   $0x425d
     615:	ff 35 a0 5d 00 00    	pushl  0x5da0
     61b:	e8 d0 33 00 00       	call   39f0 <printf>
    exit();
     620:	e8 2e 32 00 00       	call   3853 <exit>
    printf(stdout, "unlink small failed\n");
     625:	50                   	push   %eax
     626:	50                   	push   %eax
     627:	68 44 3f 00 00       	push   $0x3f44
     62c:	ff 35 a0 5d 00 00    	pushl  0x5da0
     632:	e8 b9 33 00 00       	call   39f0 <printf>
    exit();
     637:	e8 17 32 00 00       	call   3853 <exit>
    printf(stdout, "error: creat small failed!\n");
     63c:	50                   	push   %eax
     63d:	50                   	push   %eax
     63e:	68 c0 3e 00 00       	push   $0x3ec0
     643:	ff 35 a0 5d 00 00    	pushl  0x5da0
     649:	e8 a2 33 00 00       	call   39f0 <printf>
    exit();
     64e:	e8 00 32 00 00       	call   3853 <exit>
     653:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     65a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000660 <writetest1>:
{
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	56                   	push   %esi
     664:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     665:	83 ec 08             	sub    $0x8,%esp
     668:	68 6d 3f 00 00       	push   $0x3f6d
     66d:	ff 35 a0 5d 00 00    	pushl  0x5da0
     673:	e8 78 33 00 00       	call   39f0 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     678:	58                   	pop    %eax
     679:	5a                   	pop    %edx
     67a:	68 02 02 00 00       	push   $0x202
     67f:	68 e7 3f 00 00       	push   $0x3fe7
     684:	e8 0a 32 00 00       	call   3893 <open>
  if(fd < 0){
     689:	83 c4 10             	add    $0x10,%esp
     68c:	85 c0                	test   %eax,%eax
     68e:	0f 88 61 01 00 00    	js     7f5 <writetest1+0x195>
     694:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     696:	31 db                	xor    %ebx,%ebx
     698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     69f:	90                   	nop
    if(write(fd, buf, 512) != 512){
     6a0:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     6a3:	89 1d e0 84 00 00    	mov    %ebx,0x84e0
    if(write(fd, buf, 512) != 512){
     6a9:	68 00 02 00 00       	push   $0x200
     6ae:	68 e0 84 00 00       	push   $0x84e0
     6b3:	56                   	push   %esi
     6b4:	e8 ba 31 00 00       	call   3873 <write>
     6b9:	83 c4 10             	add    $0x10,%esp
     6bc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6c1:	0f 85 b3 00 00 00    	jne    77a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6c7:	83 c3 01             	add    $0x1,%ebx
     6ca:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6d0:	75 ce                	jne    6a0 <writetest1+0x40>
  close(fd);
     6d2:	83 ec 0c             	sub    $0xc,%esp
     6d5:	56                   	push   %esi
     6d6:	e8 a0 31 00 00       	call   387b <close>
  fd = open("big", O_RDONLY);
     6db:	5b                   	pop    %ebx
     6dc:	5e                   	pop    %esi
     6dd:	6a 00                	push   $0x0
     6df:	68 e7 3f 00 00       	push   $0x3fe7
     6e4:	e8 aa 31 00 00       	call   3893 <open>
  if(fd < 0){
     6e9:	83 c4 10             	add    $0x10,%esp
  fd = open("big", O_RDONLY);
     6ec:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     6ee:	85 c0                	test   %eax,%eax
     6f0:	0f 88 e8 00 00 00    	js     7de <writetest1+0x17e>
  n = 0;
     6f6:	31 f6                	xor    %esi,%esi
     6f8:	eb 1d                	jmp    717 <writetest1+0xb7>
     6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     700:	3d 00 02 00 00       	cmp    $0x200,%eax
     705:	0f 85 9f 00 00 00    	jne    7aa <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     70b:	a1 e0 84 00 00       	mov    0x84e0,%eax
     710:	39 f0                	cmp    %esi,%eax
     712:	75 7f                	jne    793 <writetest1+0x133>
    n++;
     714:	83 c6 01             	add    $0x1,%esi
    i = read(fd, buf, 512);
     717:	83 ec 04             	sub    $0x4,%esp
     71a:	68 00 02 00 00       	push   $0x200
     71f:	68 e0 84 00 00       	push   $0x84e0
     724:	53                   	push   %ebx
     725:	e8 41 31 00 00       	call   386b <read>
    if(i == 0){
     72a:	83 c4 10             	add    $0x10,%esp
     72d:	85 c0                	test   %eax,%eax
     72f:	75 cf                	jne    700 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     731:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     737:	0f 84 86 00 00 00    	je     7c3 <writetest1+0x163>
  close(fd);
     73d:	83 ec 0c             	sub    $0xc,%esp
     740:	53                   	push   %ebx
     741:	e8 35 31 00 00       	call   387b <close>
  if(unlink("big") < 0){
     746:	c7 04 24 e7 3f 00 00 	movl   $0x3fe7,(%esp)
     74d:	e8 51 31 00 00       	call   38a3 <unlink>
     752:	83 c4 10             	add    $0x10,%esp
     755:	85 c0                	test   %eax,%eax
     757:	0f 88 af 00 00 00    	js     80c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     75d:	83 ec 08             	sub    $0x8,%esp
     760:	68 0e 40 00 00       	push   $0x400e
     765:	ff 35 a0 5d 00 00    	pushl  0x5da0
     76b:	e8 80 32 00 00       	call   39f0 <printf>
}
     770:	83 c4 10             	add    $0x10,%esp
     773:	8d 65 f8             	lea    -0x8(%ebp),%esp
     776:	5b                   	pop    %ebx
     777:	5e                   	pop    %esi
     778:	5d                   	pop    %ebp
     779:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     77a:	83 ec 04             	sub    $0x4,%esp
     77d:	53                   	push   %ebx
     77e:	68 97 3f 00 00       	push   $0x3f97
     783:	ff 35 a0 5d 00 00    	pushl  0x5da0
     789:	e8 62 32 00 00       	call   39f0 <printf>
      exit();
     78e:	e8 c0 30 00 00       	call   3853 <exit>
      printf(stdout, "read content of block %d is %d\n",
     793:	50                   	push   %eax
     794:	56                   	push   %esi
     795:	68 c4 4d 00 00       	push   $0x4dc4
     79a:	ff 35 a0 5d 00 00    	pushl  0x5da0
     7a0:	e8 4b 32 00 00       	call   39f0 <printf>
      exit();
     7a5:	e8 a9 30 00 00       	call   3853 <exit>
      printf(stdout, "read failed %d\n", i);
     7aa:	83 ec 04             	sub    $0x4,%esp
     7ad:	50                   	push   %eax
     7ae:	68 eb 3f 00 00       	push   $0x3feb
     7b3:	ff 35 a0 5d 00 00    	pushl  0x5da0
     7b9:	e8 32 32 00 00       	call   39f0 <printf>
      exit();
     7be:	e8 90 30 00 00       	call   3853 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7c3:	52                   	push   %edx
     7c4:	68 8b 00 00 00       	push   $0x8b
     7c9:	68 ce 3f 00 00       	push   $0x3fce
     7ce:	ff 35 a0 5d 00 00    	pushl  0x5da0
     7d4:	e8 17 32 00 00       	call   39f0 <printf>
        exit();
     7d9:	e8 75 30 00 00       	call   3853 <exit>
    printf(stdout, "error: open big failed!\n");
     7de:	51                   	push   %ecx
     7df:	51                   	push   %ecx
     7e0:	68 b5 3f 00 00       	push   $0x3fb5
     7e5:	ff 35 a0 5d 00 00    	pushl  0x5da0
     7eb:	e8 00 32 00 00       	call   39f0 <printf>
    exit();
     7f0:	e8 5e 30 00 00       	call   3853 <exit>
    printf(stdout, "error: creat big failed!\n");
     7f5:	50                   	push   %eax
     7f6:	50                   	push   %eax
     7f7:	68 7d 3f 00 00       	push   $0x3f7d
     7fc:	ff 35 a0 5d 00 00    	pushl  0x5da0
     802:	e8 e9 31 00 00       	call   39f0 <printf>
    exit();
     807:	e8 47 30 00 00       	call   3853 <exit>
    printf(stdout, "unlink big failed\n");
     80c:	50                   	push   %eax
     80d:	50                   	push   %eax
     80e:	68 fb 3f 00 00       	push   $0x3ffb
     813:	ff 35 a0 5d 00 00    	pushl  0x5da0
     819:	e8 d2 31 00 00       	call   39f0 <printf>
    exit();
     81e:	e8 30 30 00 00       	call   3853 <exit>
     823:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000830 <createtest>:
{
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	53                   	push   %ebx
  name[2] = '\0';
     834:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     839:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     83c:	68 e4 4d 00 00       	push   $0x4de4
     841:	ff 35 a0 5d 00 00    	pushl  0x5da0
     847:	e8 a4 31 00 00       	call   39f0 <printf>
  name[0] = 'a';
     84c:	c6 05 d0 84 00 00 61 	movb   $0x61,0x84d0
  name[2] = '\0';
     853:	83 c4 10             	add    $0x10,%esp
     856:	c6 05 d2 84 00 00 00 	movb   $0x0,0x84d2
  for(i = 0; i < 52; i++){
     85d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     860:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     863:	88 1d d1 84 00 00    	mov    %bl,0x84d1
  for(i = 0; i < 52; i++){
     869:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     86c:	68 02 02 00 00       	push   $0x202
     871:	68 d0 84 00 00       	push   $0x84d0
     876:	e8 18 30 00 00       	call   3893 <open>
    close(fd);
     87b:	89 04 24             	mov    %eax,(%esp)
     87e:	e8 f8 2f 00 00       	call   387b <close>
  for(i = 0; i < 52; i++){
     883:	83 c4 10             	add    $0x10,%esp
     886:	80 fb 64             	cmp    $0x64,%bl
     889:	75 d5                	jne    860 <createtest+0x30>
  name[0] = 'a';
     88b:	c6 05 d0 84 00 00 61 	movb   $0x61,0x84d0
  name[2] = '\0';
     892:	bb 30 00 00 00       	mov    $0x30,%ebx
     897:	c6 05 d2 84 00 00 00 	movb   $0x0,0x84d2
  for(i = 0; i < 52; i++){
     89e:	66 90                	xchg   %ax,%ax
    unlink(name);
     8a0:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     8a3:	88 1d d1 84 00 00    	mov    %bl,0x84d1
  for(i = 0; i < 52; i++){
     8a9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8ac:	68 d0 84 00 00       	push   $0x84d0
     8b1:	e8 ed 2f 00 00       	call   38a3 <unlink>
  for(i = 0; i < 52; i++){
     8b6:	83 c4 10             	add    $0x10,%esp
     8b9:	80 fb 64             	cmp    $0x64,%bl
     8bc:	75 e2                	jne    8a0 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8be:	83 ec 08             	sub    $0x8,%esp
     8c1:	68 0c 4e 00 00       	push   $0x4e0c
     8c6:	ff 35 a0 5d 00 00    	pushl  0x5da0
     8cc:	e8 1f 31 00 00       	call   39f0 <printf>
}
     8d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8d4:	83 c4 10             	add    $0x10,%esp
     8d7:	c9                   	leave  
     8d8:	c3                   	ret    
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008e0 <dirtest>:
{
     8e0:	55                   	push   %ebp
     8e1:	89 e5                	mov    %esp,%ebp
     8e3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8e6:	68 1c 40 00 00       	push   $0x401c
     8eb:	ff 35 a0 5d 00 00    	pushl  0x5da0
     8f1:	e8 fa 30 00 00       	call   39f0 <printf>
  if(mkdir("dir0") < 0){
     8f6:	c7 04 24 28 40 00 00 	movl   $0x4028,(%esp)
     8fd:	e8 b9 2f 00 00       	call   38bb <mkdir>
     902:	83 c4 10             	add    $0x10,%esp
     905:	85 c0                	test   %eax,%eax
     907:	78 58                	js     961 <dirtest+0x81>
  if(chdir("dir0") < 0){
     909:	83 ec 0c             	sub    $0xc,%esp
     90c:	68 28 40 00 00       	push   $0x4028
     911:	e8 ad 2f 00 00       	call   38c3 <chdir>
     916:	83 c4 10             	add    $0x10,%esp
     919:	85 c0                	test   %eax,%eax
     91b:	0f 88 85 00 00 00    	js     9a6 <dirtest+0xc6>
  if(chdir("..") < 0){
     921:	83 ec 0c             	sub    $0xc,%esp
     924:	68 cd 45 00 00       	push   $0x45cd
     929:	e8 95 2f 00 00       	call   38c3 <chdir>
     92e:	83 c4 10             	add    $0x10,%esp
     931:	85 c0                	test   %eax,%eax
     933:	78 5a                	js     98f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     935:	83 ec 0c             	sub    $0xc,%esp
     938:	68 28 40 00 00       	push   $0x4028
     93d:	e8 61 2f 00 00       	call   38a3 <unlink>
     942:	83 c4 10             	add    $0x10,%esp
     945:	85 c0                	test   %eax,%eax
     947:	78 2f                	js     978 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     949:	83 ec 08             	sub    $0x8,%esp
     94c:	68 65 40 00 00       	push   $0x4065
     951:	ff 35 a0 5d 00 00    	pushl  0x5da0
     957:	e8 94 30 00 00       	call   39f0 <printf>
}
     95c:	83 c4 10             	add    $0x10,%esp
     95f:	c9                   	leave  
     960:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     961:	50                   	push   %eax
     962:	50                   	push   %eax
     963:	68 58 3d 00 00       	push   $0x3d58
     968:	ff 35 a0 5d 00 00    	pushl  0x5da0
     96e:	e8 7d 30 00 00       	call   39f0 <printf>
    exit();
     973:	e8 db 2e 00 00       	call   3853 <exit>
    printf(stdout, "unlink dir0 failed\n");
     978:	50                   	push   %eax
     979:	50                   	push   %eax
     97a:	68 51 40 00 00       	push   $0x4051
     97f:	ff 35 a0 5d 00 00    	pushl  0x5da0
     985:	e8 66 30 00 00       	call   39f0 <printf>
    exit();
     98a:	e8 c4 2e 00 00       	call   3853 <exit>
    printf(stdout, "chdir .. failed\n");
     98f:	52                   	push   %edx
     990:	52                   	push   %edx
     991:	68 40 40 00 00       	push   $0x4040
     996:	ff 35 a0 5d 00 00    	pushl  0x5da0
     99c:	e8 4f 30 00 00       	call   39f0 <printf>
    exit();
     9a1:	e8 ad 2e 00 00       	call   3853 <exit>
    printf(stdout, "chdir dir0 failed\n");
     9a6:	51                   	push   %ecx
     9a7:	51                   	push   %ecx
     9a8:	68 2d 40 00 00       	push   $0x402d
     9ad:	ff 35 a0 5d 00 00    	pushl  0x5da0
     9b3:	e8 38 30 00 00       	call   39f0 <printf>
    exit();
     9b8:	e8 96 2e 00 00       	call   3853 <exit>
     9bd:	8d 76 00             	lea    0x0(%esi),%esi

000009c0 <exectest>:
{
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9c6:	68 74 40 00 00       	push   $0x4074
     9cb:	ff 35 a0 5d 00 00    	pushl  0x5da0
     9d1:	e8 1a 30 00 00       	call   39f0 <printf>
  if(exec("echo", echoargv) < 0){
     9d6:	5a                   	pop    %edx
     9d7:	59                   	pop    %ecx
     9d8:	68 a4 5d 00 00       	push   $0x5da4
     9dd:	68 3d 3e 00 00       	push   $0x3e3d
     9e2:	e8 a4 2e 00 00       	call   388b <exec>
     9e7:	83 c4 10             	add    $0x10,%esp
     9ea:	85 c0                	test   %eax,%eax
     9ec:	78 02                	js     9f0 <exectest+0x30>
}
     9ee:	c9                   	leave  
     9ef:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     9f0:	50                   	push   %eax
     9f1:	50                   	push   %eax
     9f2:	68 7f 40 00 00       	push   $0x407f
     9f7:	ff 35 a0 5d 00 00    	pushl  0x5da0
     9fd:	e8 ee 2f 00 00       	call   39f0 <printf>
    exit();
     a02:	e8 4c 2e 00 00       	call   3853 <exit>
     a07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a0e:	66 90                	xchg   %ax,%ax

00000a10 <pipe1>:
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	57                   	push   %edi
     a14:	56                   	push   %esi
  if(pipe(fds) != 0){
     a15:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a18:	53                   	push   %ebx
     a19:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     a1c:	50                   	push   %eax
     a1d:	e8 41 2e 00 00       	call   3863 <pipe>
     a22:	83 c4 10             	add    $0x10,%esp
     a25:	85 c0                	test   %eax,%eax
     a27:	0f 85 34 01 00 00    	jne    b61 <pipe1+0x151>
  pid = fork();
     a2d:	e8 19 2e 00 00       	call   384b <fork>
  if(pid == 0){
     a32:	85 c0                	test   %eax,%eax
     a34:	0f 84 89 00 00 00    	je     ac3 <pipe1+0xb3>
  } else if(pid > 0){
     a3a:	0f 8e 34 01 00 00    	jle    b74 <pipe1+0x164>
    close(fds[1]);
     a40:	83 ec 0c             	sub    $0xc,%esp
     a43:	ff 75 e4             	pushl  -0x1c(%ebp)
  seq = 0;
     a46:	31 db                	xor    %ebx,%ebx
    cc = 1;
     a48:	be 01 00 00 00       	mov    $0x1,%esi
    close(fds[1]);
     a4d:	e8 29 2e 00 00       	call   387b <close>
    total = 0;
     a52:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a59:	83 c4 10             	add    $0x10,%esp
     a5c:	83 ec 04             	sub    $0x4,%esp
     a5f:	56                   	push   %esi
     a60:	68 e0 84 00 00       	push   $0x84e0
     a65:	ff 75 e0             	pushl  -0x20(%ebp)
     a68:	e8 fe 2d 00 00       	call   386b <read>
     a6d:	83 c4 10             	add    $0x10,%esp
     a70:	89 c7                	mov    %eax,%edi
     a72:	85 c0                	test   %eax,%eax
     a74:	0f 8e a3 00 00 00    	jle    b1d <pipe1+0x10d>
     a7a:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
      for(i = 0; i < n; i++){
     a7d:	31 c0                	xor    %eax,%eax
     a7f:	90                   	nop
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a80:	89 da                	mov    %ebx,%edx
     a82:	83 c3 01             	add    $0x1,%ebx
     a85:	38 90 e0 84 00 00    	cmp    %dl,0x84e0(%eax)
     a8b:	75 1c                	jne    aa9 <pipe1+0x99>
      for(i = 0; i < n; i++){
     a8d:	83 c0 01             	add    $0x1,%eax
     a90:	39 d9                	cmp    %ebx,%ecx
     a92:	75 ec                	jne    a80 <pipe1+0x70>
      cc = cc * 2;
     a94:	01 f6                	add    %esi,%esi
      total += n;
     a96:	01 7d d4             	add    %edi,-0x2c(%ebp)
     a99:	b8 00 20 00 00       	mov    $0x2000,%eax
     a9e:	81 fe 00 20 00 00    	cmp    $0x2000,%esi
     aa4:	0f 4f f0             	cmovg  %eax,%esi
     aa7:	eb b3                	jmp    a5c <pipe1+0x4c>
          printf(1, "pipe1 oops 2\n");
     aa9:	83 ec 08             	sub    $0x8,%esp
     aac:	68 ae 40 00 00       	push   $0x40ae
     ab1:	6a 01                	push   $0x1
     ab3:	e8 38 2f 00 00       	call   39f0 <printf>
          return;
     ab8:	83 c4 10             	add    $0x10,%esp
}
     abb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     abe:	5b                   	pop    %ebx
     abf:	5e                   	pop    %esi
     ac0:	5f                   	pop    %edi
     ac1:	5d                   	pop    %ebp
     ac2:	c3                   	ret    
    close(fds[0]);
     ac3:	83 ec 0c             	sub    $0xc,%esp
     ac6:	ff 75 e0             	pushl  -0x20(%ebp)
  seq = 0;
     ac9:	31 db                	xor    %ebx,%ebx
    close(fds[0]);
     acb:	e8 ab 2d 00 00       	call   387b <close>
     ad0:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 1033; i++)
     ad3:	31 c0                	xor    %eax,%eax
     ad5:	8d 76 00             	lea    0x0(%esi),%esi
        buf[i] = seq++;
     ad8:	8d 14 18             	lea    (%eax,%ebx,1),%edx
      for(i = 0; i < 1033; i++)
     adb:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
     ade:	88 90 df 84 00 00    	mov    %dl,0x84df(%eax)
      for(i = 0; i < 1033; i++)
     ae4:	3d 09 04 00 00       	cmp    $0x409,%eax
     ae9:	75 ed                	jne    ad8 <pipe1+0xc8>
      if(write(fds[1], buf, 1033) != 1033){
     aeb:	83 ec 04             	sub    $0x4,%esp
        buf[i] = seq++;
     aee:	81 c3 09 04 00 00    	add    $0x409,%ebx
      if(write(fds[1], buf, 1033) != 1033){
     af4:	68 09 04 00 00       	push   $0x409
     af9:	68 e0 84 00 00       	push   $0x84e0
     afe:	ff 75 e4             	pushl  -0x1c(%ebp)
     b01:	e8 6d 2d 00 00       	call   3873 <write>
     b06:	83 c4 10             	add    $0x10,%esp
     b09:	3d 09 04 00 00       	cmp    $0x409,%eax
     b0e:	75 77                	jne    b87 <pipe1+0x177>
    for(n = 0; n < 5; n++){
     b10:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b16:	75 bb                	jne    ad3 <pipe1+0xc3>
    exit();
     b18:	e8 36 2d 00 00       	call   3853 <exit>
    if(total != 5 * 1033){
     b1d:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b24:	75 26                	jne    b4c <pipe1+0x13c>
    close(fds[0]);
     b26:	83 ec 0c             	sub    $0xc,%esp
     b29:	ff 75 e0             	pushl  -0x20(%ebp)
     b2c:	e8 4a 2d 00 00       	call   387b <close>
    wait();
     b31:	e8 25 2d 00 00       	call   385b <wait>
  printf(1, "pipe1 ok\n");
     b36:	5a                   	pop    %edx
     b37:	59                   	pop    %ecx
     b38:	68 d3 40 00 00       	push   $0x40d3
     b3d:	6a 01                	push   $0x1
     b3f:	e8 ac 2e 00 00       	call   39f0 <printf>
     b44:	83 c4 10             	add    $0x10,%esp
     b47:	e9 6f ff ff ff       	jmp    abb <pipe1+0xab>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b4c:	53                   	push   %ebx
     b4d:	ff 75 d4             	pushl  -0x2c(%ebp)
     b50:	68 bc 40 00 00       	push   $0x40bc
     b55:	6a 01                	push   $0x1
     b57:	e8 94 2e 00 00       	call   39f0 <printf>
      exit();
     b5c:	e8 f2 2c 00 00       	call   3853 <exit>
    printf(1, "pipe() failed\n");
     b61:	57                   	push   %edi
     b62:	57                   	push   %edi
     b63:	68 91 40 00 00       	push   $0x4091
     b68:	6a 01                	push   $0x1
     b6a:	e8 81 2e 00 00       	call   39f0 <printf>
    exit();
     b6f:	e8 df 2c 00 00       	call   3853 <exit>
    printf(1, "fork() failed\n");
     b74:	50                   	push   %eax
     b75:	50                   	push   %eax
     b76:	68 dd 40 00 00       	push   $0x40dd
     b7b:	6a 01                	push   $0x1
     b7d:	e8 6e 2e 00 00       	call   39f0 <printf>
    exit();
     b82:	e8 cc 2c 00 00       	call   3853 <exit>
        printf(1, "pipe1 oops 1\n");
     b87:	56                   	push   %esi
     b88:	56                   	push   %esi
     b89:	68 a0 40 00 00       	push   $0x40a0
     b8e:	6a 01                	push   $0x1
     b90:	e8 5b 2e 00 00       	call   39f0 <printf>
        exit();
     b95:	e8 b9 2c 00 00       	call   3853 <exit>
     b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000ba0 <preempt>:
{
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	57                   	push   %edi
     ba4:	56                   	push   %esi
     ba5:	53                   	push   %ebx
     ba6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     ba9:	68 ec 40 00 00       	push   $0x40ec
     bae:	6a 01                	push   $0x1
     bb0:	e8 3b 2e 00 00       	call   39f0 <printf>
  pid1 = fork();
     bb5:	e8 91 2c 00 00       	call   384b <fork>
  if(pid1 == 0)
     bba:	83 c4 10             	add    $0x10,%esp
     bbd:	85 c0                	test   %eax,%eax
     bbf:	75 07                	jne    bc8 <preempt+0x28>
    for(;;)
     bc1:	eb fe                	jmp    bc1 <preempt+0x21>
     bc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bc7:	90                   	nop
     bc8:	89 c3                	mov    %eax,%ebx
  pid2 = fork();
     bca:	e8 7c 2c 00 00       	call   384b <fork>
     bcf:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     bd1:	85 c0                	test   %eax,%eax
     bd3:	75 0b                	jne    be0 <preempt+0x40>
    for(;;)
     bd5:	eb fe                	jmp    bd5 <preempt+0x35>
     bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bde:	66 90                	xchg   %ax,%ax
  pipe(pfds);
     be0:	83 ec 0c             	sub    $0xc,%esp
     be3:	8d 45 e0             	lea    -0x20(%ebp),%eax
     be6:	50                   	push   %eax
     be7:	e8 77 2c 00 00       	call   3863 <pipe>
  pid3 = fork();
     bec:	e8 5a 2c 00 00       	call   384b <fork>
  if(pid3 == 0){
     bf1:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     bf4:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
     bf6:	85 c0                	test   %eax,%eax
     bf8:	75 3e                	jne    c38 <preempt+0x98>
    close(pfds[0]);
     bfa:	83 ec 0c             	sub    $0xc,%esp
     bfd:	ff 75 e0             	pushl  -0x20(%ebp)
     c00:	e8 76 2c 00 00       	call   387b <close>
    if(write(pfds[1], "x", 1) != 1)
     c05:	83 c4 0c             	add    $0xc,%esp
     c08:	6a 01                	push   $0x1
     c0a:	68 b1 46 00 00       	push   $0x46b1
     c0f:	ff 75 e4             	pushl  -0x1c(%ebp)
     c12:	e8 5c 2c 00 00       	call   3873 <write>
     c17:	83 c4 10             	add    $0x10,%esp
     c1a:	83 f8 01             	cmp    $0x1,%eax
     c1d:	0f 85 b8 00 00 00    	jne    cdb <preempt+0x13b>
    close(pfds[1]);
     c23:	83 ec 0c             	sub    $0xc,%esp
     c26:	ff 75 e4             	pushl  -0x1c(%ebp)
     c29:	e8 4d 2c 00 00       	call   387b <close>
     c2e:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c31:	eb fe                	jmp    c31 <preempt+0x91>
     c33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c37:	90                   	nop
  close(pfds[1]);
     c38:	83 ec 0c             	sub    $0xc,%esp
     c3b:	ff 75 e4             	pushl  -0x1c(%ebp)
     c3e:	e8 38 2c 00 00       	call   387b <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c43:	83 c4 0c             	add    $0xc,%esp
     c46:	68 00 20 00 00       	push   $0x2000
     c4b:	68 e0 84 00 00       	push   $0x84e0
     c50:	ff 75 e0             	pushl  -0x20(%ebp)
     c53:	e8 13 2c 00 00       	call   386b <read>
     c58:	83 c4 10             	add    $0x10,%esp
     c5b:	83 f8 01             	cmp    $0x1,%eax
     c5e:	75 67                	jne    cc7 <preempt+0x127>
  close(pfds[0]);
     c60:	83 ec 0c             	sub    $0xc,%esp
     c63:	ff 75 e0             	pushl  -0x20(%ebp)
     c66:	e8 10 2c 00 00       	call   387b <close>
  printf(1, "kill... ");
     c6b:	58                   	pop    %eax
     c6c:	5a                   	pop    %edx
     c6d:	68 1d 41 00 00       	push   $0x411d
     c72:	6a 01                	push   $0x1
     c74:	e8 77 2d 00 00       	call   39f0 <printf>
  kill(pid1);
     c79:	89 1c 24             	mov    %ebx,(%esp)
     c7c:	e8 02 2c 00 00       	call   3883 <kill>
  kill(pid2);
     c81:	89 34 24             	mov    %esi,(%esp)
     c84:	e8 fa 2b 00 00       	call   3883 <kill>
  kill(pid3);
     c89:	89 3c 24             	mov    %edi,(%esp)
     c8c:	e8 f2 2b 00 00       	call   3883 <kill>
  printf(1, "wait... ");
     c91:	59                   	pop    %ecx
     c92:	5b                   	pop    %ebx
     c93:	68 26 41 00 00       	push   $0x4126
     c98:	6a 01                	push   $0x1
     c9a:	e8 51 2d 00 00       	call   39f0 <printf>
  wait();
     c9f:	e8 b7 2b 00 00       	call   385b <wait>
  wait();
     ca4:	e8 b2 2b 00 00       	call   385b <wait>
  wait();
     ca9:	e8 ad 2b 00 00       	call   385b <wait>
  printf(1, "preempt ok\n");
     cae:	5e                   	pop    %esi
     caf:	5f                   	pop    %edi
     cb0:	68 2f 41 00 00       	push   $0x412f
     cb5:	6a 01                	push   $0x1
     cb7:	e8 34 2d 00 00       	call   39f0 <printf>
     cbc:	83 c4 10             	add    $0x10,%esp
}
     cbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cc2:	5b                   	pop    %ebx
     cc3:	5e                   	pop    %esi
     cc4:	5f                   	pop    %edi
     cc5:	5d                   	pop    %ebp
     cc6:	c3                   	ret    
    printf(1, "preempt read error");
     cc7:	83 ec 08             	sub    $0x8,%esp
     cca:	68 0a 41 00 00       	push   $0x410a
     ccf:	6a 01                	push   $0x1
     cd1:	e8 1a 2d 00 00       	call   39f0 <printf>
    return;
     cd6:	83 c4 10             	add    $0x10,%esp
     cd9:	eb e4                	jmp    cbf <preempt+0x11f>
      printf(1, "preempt write error");
     cdb:	83 ec 08             	sub    $0x8,%esp
     cde:	68 f6 40 00 00       	push   $0x40f6
     ce3:	6a 01                	push   $0x1
     ce5:	e8 06 2d 00 00       	call   39f0 <printf>
     cea:	83 c4 10             	add    $0x10,%esp
     ced:	e9 31 ff ff ff       	jmp    c23 <preempt+0x83>
     cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d00 <exitwait>:
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	56                   	push   %esi
     d04:	be 64 00 00 00       	mov    $0x64,%esi
     d09:	53                   	push   %ebx
     d0a:	eb 14                	jmp    d20 <exitwait+0x20>
     d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     d10:	74 68                	je     d7a <exitwait+0x7a>
      if(wait() != pid){
     d12:	e8 44 2b 00 00       	call   385b <wait>
     d17:	39 d8                	cmp    %ebx,%eax
     d19:	75 2d                	jne    d48 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     d1b:	83 ee 01             	sub    $0x1,%esi
     d1e:	74 41                	je     d61 <exitwait+0x61>
    pid = fork();
     d20:	e8 26 2b 00 00       	call   384b <fork>
     d25:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d27:	85 c0                	test   %eax,%eax
     d29:	79 e5                	jns    d10 <exitwait+0x10>
      printf(1, "fork failed\n");
     d2b:	83 ec 08             	sub    $0x8,%esp
     d2e:	68 99 4c 00 00       	push   $0x4c99
     d33:	6a 01                	push   $0x1
     d35:	e8 b6 2c 00 00       	call   39f0 <printf>
      return;
     d3a:	83 c4 10             	add    $0x10,%esp
}
     d3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d40:	5b                   	pop    %ebx
     d41:	5e                   	pop    %esi
     d42:	5d                   	pop    %ebp
     d43:	c3                   	ret    
     d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     d48:	83 ec 08             	sub    $0x8,%esp
     d4b:	68 3b 41 00 00       	push   $0x413b
     d50:	6a 01                	push   $0x1
     d52:	e8 99 2c 00 00       	call   39f0 <printf>
        return;
     d57:	83 c4 10             	add    $0x10,%esp
}
     d5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d5d:	5b                   	pop    %ebx
     d5e:	5e                   	pop    %esi
     d5f:	5d                   	pop    %ebp
     d60:	c3                   	ret    
  printf(1, "exitwait ok\n");
     d61:	83 ec 08             	sub    $0x8,%esp
     d64:	68 4b 41 00 00       	push   $0x414b
     d69:	6a 01                	push   $0x1
     d6b:	e8 80 2c 00 00       	call   39f0 <printf>
     d70:	83 c4 10             	add    $0x10,%esp
}
     d73:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d76:	5b                   	pop    %ebx
     d77:	5e                   	pop    %esi
     d78:	5d                   	pop    %ebp
     d79:	c3                   	ret    
      exit();
     d7a:	e8 d4 2a 00 00       	call   3853 <exit>
     d7f:	90                   	nop

00000d80 <mem>:
{
     d80:	55                   	push   %ebp
     d81:	89 e5                	mov    %esp,%ebp
     d83:	56                   	push   %esi
     d84:	31 f6                	xor    %esi,%esi
     d86:	53                   	push   %ebx
  printf(1, "mem test\n");
     d87:	83 ec 08             	sub    $0x8,%esp
     d8a:	68 58 41 00 00       	push   $0x4158
     d8f:	6a 01                	push   $0x1
     d91:	e8 5a 2c 00 00       	call   39f0 <printf>
  ppid = getpid();
     d96:	e8 38 2b 00 00       	call   38d3 <getpid>
     d9b:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
     d9d:	e8 a9 2a 00 00       	call   384b <fork>
     da2:	83 c4 10             	add    $0x10,%esp
     da5:	85 c0                	test   %eax,%eax
     da7:	74 0b                	je     db4 <mem+0x34>
     da9:	e9 8a 00 00 00       	jmp    e38 <mem+0xb8>
     dae:	66 90                	xchg   %ax,%ax
      *(char**)m2 = m1;
     db0:	89 30                	mov    %esi,(%eax)
     db2:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
     db4:	83 ec 0c             	sub    $0xc,%esp
     db7:	68 11 27 00 00       	push   $0x2711
     dbc:	e8 8f 2e 00 00       	call   3c50 <malloc>
     dc1:	83 c4 10             	add    $0x10,%esp
     dc4:	85 c0                	test   %eax,%eax
     dc6:	75 e8                	jne    db0 <mem+0x30>
    while(m1){
     dc8:	85 f6                	test   %esi,%esi
     dca:	74 18                	je     de4 <mem+0x64>
     dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     dd0:	89 f0                	mov    %esi,%eax
      free(m1);
     dd2:	83 ec 0c             	sub    $0xc,%esp
      m2 = *(char**)m1;
     dd5:	8b 36                	mov    (%esi),%esi
      free(m1);
     dd7:	50                   	push   %eax
     dd8:	e8 e3 2d 00 00       	call   3bc0 <free>
    while(m1){
     ddd:	83 c4 10             	add    $0x10,%esp
     de0:	85 f6                	test   %esi,%esi
     de2:	75 ec                	jne    dd0 <mem+0x50>
    m1 = malloc(1024*20);
     de4:	83 ec 0c             	sub    $0xc,%esp
     de7:	68 00 50 00 00       	push   $0x5000
     dec:	e8 5f 2e 00 00       	call   3c50 <malloc>
    if(m1 == 0){
     df1:	83 c4 10             	add    $0x10,%esp
     df4:	85 c0                	test   %eax,%eax
     df6:	74 20                	je     e18 <mem+0x98>
    free(m1);
     df8:	83 ec 0c             	sub    $0xc,%esp
     dfb:	50                   	push   %eax
     dfc:	e8 bf 2d 00 00       	call   3bc0 <free>
    printf(1, "mem ok\n");
     e01:	58                   	pop    %eax
     e02:	5a                   	pop    %edx
     e03:	68 7c 41 00 00       	push   $0x417c
     e08:	6a 01                	push   $0x1
     e0a:	e8 e1 2b 00 00       	call   39f0 <printf>
    exit();
     e0f:	e8 3f 2a 00 00       	call   3853 <exit>
     e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e18:	83 ec 08             	sub    $0x8,%esp
     e1b:	68 62 41 00 00       	push   $0x4162
     e20:	6a 01                	push   $0x1
     e22:	e8 c9 2b 00 00       	call   39f0 <printf>
      kill(ppid);
     e27:	89 1c 24             	mov    %ebx,(%esp)
     e2a:	e8 54 2a 00 00       	call   3883 <kill>
      exit();
     e2f:	e8 1f 2a 00 00       	call   3853 <exit>
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e38:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e3b:	5b                   	pop    %ebx
     e3c:	5e                   	pop    %esi
     e3d:	5d                   	pop    %ebp
    wait();
     e3e:	e9 18 2a 00 00       	jmp    385b <wait>
     e43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e50 <sharedfd>:
{
     e50:	55                   	push   %ebp
     e51:	89 e5                	mov    %esp,%ebp
     e53:	57                   	push   %edi
     e54:	56                   	push   %esi
     e55:	53                   	push   %ebx
     e56:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     e59:	68 84 41 00 00       	push   $0x4184
     e5e:	6a 01                	push   $0x1
     e60:	e8 8b 2b 00 00       	call   39f0 <printf>
  unlink("sharedfd");
     e65:	c7 04 24 93 41 00 00 	movl   $0x4193,(%esp)
     e6c:	e8 32 2a 00 00       	call   38a3 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e71:	5b                   	pop    %ebx
     e72:	5e                   	pop    %esi
     e73:	68 02 02 00 00       	push   $0x202
     e78:	68 93 41 00 00       	push   $0x4193
     e7d:	e8 11 2a 00 00       	call   3893 <open>
  if(fd < 0){
     e82:	83 c4 10             	add    $0x10,%esp
     e85:	85 c0                	test   %eax,%eax
     e87:	0f 88 2a 01 00 00    	js     fb7 <sharedfd+0x167>
     e8d:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e8f:	8d 75 de             	lea    -0x22(%ebp),%esi
     e92:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     e97:	e8 af 29 00 00       	call   384b <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e9c:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     e9f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     ea2:	19 c0                	sbb    %eax,%eax
     ea4:	83 ec 04             	sub    $0x4,%esp
     ea7:	83 e0 f3             	and    $0xfffffff3,%eax
     eaa:	6a 0a                	push   $0xa
     eac:	83 c0 70             	add    $0x70,%eax
     eaf:	50                   	push   %eax
     eb0:	56                   	push   %esi
     eb1:	e8 fa 27 00 00       	call   36b0 <memset>
     eb6:	83 c4 10             	add    $0x10,%esp
     eb9:	eb 0a                	jmp    ec5 <sharedfd+0x75>
     ebb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ebf:	90                   	nop
  for(i = 0; i < 1000; i++){
     ec0:	83 eb 01             	sub    $0x1,%ebx
     ec3:	74 26                	je     eeb <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ec5:	83 ec 04             	sub    $0x4,%esp
     ec8:	6a 0a                	push   $0xa
     eca:	56                   	push   %esi
     ecb:	57                   	push   %edi
     ecc:	e8 a2 29 00 00       	call   3873 <write>
     ed1:	83 c4 10             	add    $0x10,%esp
     ed4:	83 f8 0a             	cmp    $0xa,%eax
     ed7:	74 e7                	je     ec0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     ed9:	83 ec 08             	sub    $0x8,%esp
     edc:	68 60 4e 00 00       	push   $0x4e60
     ee1:	6a 01                	push   $0x1
     ee3:	e8 08 2b 00 00       	call   39f0 <printf>
      break;
     ee8:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     eeb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     eee:	85 c9                	test   %ecx,%ecx
     ef0:	0f 84 f5 00 00 00    	je     feb <sharedfd+0x19b>
    wait();
     ef6:	e8 60 29 00 00       	call   385b <wait>
  close(fd);
     efb:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     efe:	31 db                	xor    %ebx,%ebx
  close(fd);
     f00:	57                   	push   %edi
     f01:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f04:	e8 72 29 00 00       	call   387b <close>
  fd = open("sharedfd", 0);
     f09:	58                   	pop    %eax
     f0a:	5a                   	pop    %edx
     f0b:	6a 00                	push   $0x0
     f0d:	68 93 41 00 00       	push   $0x4193
     f12:	e8 7c 29 00 00       	call   3893 <open>
  if(fd < 0){
     f17:	83 c4 10             	add    $0x10,%esp
  nc = np = 0;
     f1a:	31 d2                	xor    %edx,%edx
  fd = open("sharedfd", 0);
     f1c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f1f:	85 c0                	test   %eax,%eax
     f21:	0f 88 aa 00 00 00    	js     fd1 <sharedfd+0x181>
     f27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f2e:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f30:	83 ec 04             	sub    $0x4,%esp
     f33:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f36:	6a 0a                	push   $0xa
     f38:	56                   	push   %esi
     f39:	ff 75 d0             	pushl  -0x30(%ebp)
     f3c:	e8 2a 29 00 00       	call   386b <read>
     f41:	83 c4 10             	add    $0x10,%esp
     f44:	85 c0                	test   %eax,%eax
     f46:	7e 28                	jle    f70 <sharedfd+0x120>
    for(i = 0; i < sizeof(buf); i++){
     f48:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f4b:	89 f0                	mov    %esi,%eax
     f4d:	eb 13                	jmp    f62 <sharedfd+0x112>
     f4f:	90                   	nop
        np++;
     f50:	80 f9 70             	cmp    $0x70,%cl
     f53:	0f 94 c1             	sete   %cl
     f56:	0f b6 c9             	movzbl %cl,%ecx
     f59:	01 cb                	add    %ecx,%ebx
    for(i = 0; i < sizeof(buf); i++){
     f5b:	83 c0 01             	add    $0x1,%eax
     f5e:	39 c7                	cmp    %eax,%edi
     f60:	74 ce                	je     f30 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f62:	0f b6 08             	movzbl (%eax),%ecx
     f65:	80 f9 63             	cmp    $0x63,%cl
     f68:	75 e6                	jne    f50 <sharedfd+0x100>
        nc++;
     f6a:	83 c2 01             	add    $0x1,%edx
      if(buf[i] == 'p')
     f6d:	eb ec                	jmp    f5b <sharedfd+0x10b>
     f6f:	90                   	nop
  close(fd);
     f70:	83 ec 0c             	sub    $0xc,%esp
     f73:	ff 75 d0             	pushl  -0x30(%ebp)
     f76:	e8 00 29 00 00       	call   387b <close>
  unlink("sharedfd");
     f7b:	c7 04 24 93 41 00 00 	movl   $0x4193,(%esp)
     f82:	e8 1c 29 00 00       	call   38a3 <unlink>
  if(nc == 10000 && np == 10000){
     f87:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f8a:	83 c4 10             	add    $0x10,%esp
     f8d:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     f93:	75 5b                	jne    ff0 <sharedfd+0x1a0>
     f95:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f9b:	75 53                	jne    ff0 <sharedfd+0x1a0>
    printf(1, "sharedfd ok\n");
     f9d:	83 ec 08             	sub    $0x8,%esp
     fa0:	68 9c 41 00 00       	push   $0x419c
     fa5:	6a 01                	push   $0x1
     fa7:	e8 44 2a 00 00       	call   39f0 <printf>
     fac:	83 c4 10             	add    $0x10,%esp
}
     faf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fb2:	5b                   	pop    %ebx
     fb3:	5e                   	pop    %esi
     fb4:	5f                   	pop    %edi
     fb5:	5d                   	pop    %ebp
     fb6:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for writing");
     fb7:	83 ec 08             	sub    $0x8,%esp
     fba:	68 34 4e 00 00       	push   $0x4e34
     fbf:	6a 01                	push   $0x1
     fc1:	e8 2a 2a 00 00       	call   39f0 <printf>
    return;
     fc6:	83 c4 10             	add    $0x10,%esp
}
     fc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fcc:	5b                   	pop    %ebx
     fcd:	5e                   	pop    %esi
     fce:	5f                   	pop    %edi
     fcf:	5d                   	pop    %ebp
     fd0:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     fd1:	83 ec 08             	sub    $0x8,%esp
     fd4:	68 80 4e 00 00       	push   $0x4e80
     fd9:	6a 01                	push   $0x1
     fdb:	e8 10 2a 00 00       	call   39f0 <printf>
    return;
     fe0:	83 c4 10             	add    $0x10,%esp
}
     fe3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fe6:	5b                   	pop    %ebx
     fe7:	5e                   	pop    %esi
     fe8:	5f                   	pop    %edi
     fe9:	5d                   	pop    %ebp
     fea:	c3                   	ret    
    exit();
     feb:	e8 63 28 00 00       	call   3853 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
     ff0:	53                   	push   %ebx
     ff1:	52                   	push   %edx
     ff2:	68 a9 41 00 00       	push   $0x41a9
     ff7:	6a 01                	push   $0x1
     ff9:	e8 f2 29 00 00       	call   39f0 <printf>
    exit();
     ffe:	e8 50 28 00 00       	call   3853 <exit>
    1003:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001010 <fourfiles>:
{
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    1015:	be be 41 00 00       	mov    $0x41be,%esi
{
    101a:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    101b:	31 db                	xor    %ebx,%ebx
{
    101d:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    1020:	c7 45 d8 be 41 00 00 	movl   $0x41be,-0x28(%ebp)
  printf(1, "fourfiles test\n");
    1027:	68 c4 41 00 00       	push   $0x41c4
    102c:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    102e:	c7 45 dc 07 43 00 00 	movl   $0x4307,-0x24(%ebp)
    1035:	c7 45 e0 0b 43 00 00 	movl   $0x430b,-0x20(%ebp)
    103c:	c7 45 e4 c1 41 00 00 	movl   $0x41c1,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1043:	e8 a8 29 00 00       	call   39f0 <printf>
    1048:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    104b:	83 ec 0c             	sub    $0xc,%esp
    104e:	56                   	push   %esi
    104f:	e8 4f 28 00 00       	call   38a3 <unlink>
    pid = fork();
    1054:	e8 f2 27 00 00       	call   384b <fork>
    if(pid < 0){
    1059:	83 c4 10             	add    $0x10,%esp
    105c:	85 c0                	test   %eax,%eax
    105e:	0f 88 64 01 00 00    	js     11c8 <fourfiles+0x1b8>
    if(pid == 0){
    1064:	0f 84 e9 00 00 00    	je     1153 <fourfiles+0x143>
  for(pi = 0; pi < 4; pi++){
    106a:	83 c3 01             	add    $0x1,%ebx
    106d:	83 fb 04             	cmp    $0x4,%ebx
    1070:	74 06                	je     1078 <fourfiles+0x68>
    fname = names[pi];
    1072:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1076:	eb d3                	jmp    104b <fourfiles+0x3b>
    wait();
    1078:	e8 de 27 00 00       	call   385b <wait>
  for(i = 0; i < 2; i++){
    107d:	31 f6                	xor    %esi,%esi
    wait();
    107f:	e8 d7 27 00 00       	call   385b <wait>
    1084:	e8 d2 27 00 00       	call   385b <wait>
    1089:	e8 cd 27 00 00       	call   385b <wait>
    fname = names[i];
    108e:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    fd = open(fname, 0);
    1092:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    1095:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    1097:	6a 00                	push   $0x0
    1099:	50                   	push   %eax
    fname = names[i];
    109a:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    109d:	e8 f1 27 00 00       	call   3893 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10a2:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    10a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10af:	90                   	nop
    10b0:	83 ec 04             	sub    $0x4,%esp
    10b3:	68 00 20 00 00       	push   $0x2000
    10b8:	68 e0 84 00 00       	push   $0x84e0
    10bd:	ff 75 d4             	pushl  -0x2c(%ebp)
    10c0:	e8 a6 27 00 00       	call   386b <read>
    10c5:	83 c4 10             	add    $0x10,%esp
    10c8:	89 c7                	mov    %eax,%edi
    10ca:	85 c0                	test   %eax,%eax
    10cc:	7e 20                	jle    10ee <fourfiles+0xde>
      for(j = 0; j < n; j++){
    10ce:	31 c0                	xor    %eax,%eax
        if(buf[j] != '0'+i){
    10d0:	83 fe 01             	cmp    $0x1,%esi
    10d3:	0f be 88 e0 84 00 00 	movsbl 0x84e0(%eax),%ecx
    10da:	19 d2                	sbb    %edx,%edx
    10dc:	83 c2 31             	add    $0x31,%edx
    10df:	39 d1                	cmp    %edx,%ecx
    10e1:	75 5c                	jne    113f <fourfiles+0x12f>
      for(j = 0; j < n; j++){
    10e3:	83 c0 01             	add    $0x1,%eax
    10e6:	39 c7                	cmp    %eax,%edi
    10e8:	75 e6                	jne    10d0 <fourfiles+0xc0>
      total += n;
    10ea:	01 fb                	add    %edi,%ebx
    10ec:	eb c2                	jmp    10b0 <fourfiles+0xa0>
    close(fd);
    10ee:	83 ec 0c             	sub    $0xc,%esp
    10f1:	ff 75 d4             	pushl  -0x2c(%ebp)
    10f4:	e8 82 27 00 00       	call   387b <close>
    if(total != 12*500){
    10f9:	83 c4 10             	add    $0x10,%esp
    10fc:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1102:	0f 85 d4 00 00 00    	jne    11dc <fourfiles+0x1cc>
    unlink(fname);
    1108:	83 ec 0c             	sub    $0xc,%esp
    110b:	ff 75 d0             	pushl  -0x30(%ebp)
    110e:	e8 90 27 00 00       	call   38a3 <unlink>
  for(i = 0; i < 2; i++){
    1113:	83 c4 10             	add    $0x10,%esp
    1116:	83 fe 01             	cmp    $0x1,%esi
    1119:	75 1a                	jne    1135 <fourfiles+0x125>
  printf(1, "fourfiles ok\n");
    111b:	83 ec 08             	sub    $0x8,%esp
    111e:	68 02 42 00 00       	push   $0x4202
    1123:	6a 01                	push   $0x1
    1125:	e8 c6 28 00 00       	call   39f0 <printf>
}
    112a:	83 c4 10             	add    $0x10,%esp
    112d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1130:	5b                   	pop    %ebx
    1131:	5e                   	pop    %esi
    1132:	5f                   	pop    %edi
    1133:	5d                   	pop    %ebp
    1134:	c3                   	ret    
    1135:	be 01 00 00 00       	mov    $0x1,%esi
    113a:	e9 4f ff ff ff       	jmp    108e <fourfiles+0x7e>
          printf(1, "wrong char\n");
    113f:	83 ec 08             	sub    $0x8,%esp
    1142:	68 e5 41 00 00       	push   $0x41e5
    1147:	6a 01                	push   $0x1
    1149:	e8 a2 28 00 00       	call   39f0 <printf>
          exit();
    114e:	e8 00 27 00 00       	call   3853 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1153:	83 ec 08             	sub    $0x8,%esp
    1156:	68 02 02 00 00       	push   $0x202
    115b:	56                   	push   %esi
    115c:	e8 32 27 00 00       	call   3893 <open>
      if(fd < 0){
    1161:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    1164:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1166:	85 c0                	test   %eax,%eax
    1168:	78 45                	js     11af <fourfiles+0x19f>
      memset(buf, '0'+pi, 512);
    116a:	83 ec 04             	sub    $0x4,%esp
    116d:	83 c3 30             	add    $0x30,%ebx
    1170:	68 00 02 00 00       	push   $0x200
    1175:	53                   	push   %ebx
    1176:	bb 0c 00 00 00       	mov    $0xc,%ebx
    117b:	68 e0 84 00 00       	push   $0x84e0
    1180:	e8 2b 25 00 00       	call   36b0 <memset>
    1185:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    1188:	83 ec 04             	sub    $0x4,%esp
    118b:	68 f4 01 00 00       	push   $0x1f4
    1190:	68 e0 84 00 00       	push   $0x84e0
    1195:	56                   	push   %esi
    1196:	e8 d8 26 00 00       	call   3873 <write>
    119b:	83 c4 10             	add    $0x10,%esp
    119e:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11a3:	75 4a                	jne    11ef <fourfiles+0x1df>
      for(i = 0; i < 12; i++){
    11a5:	83 eb 01             	sub    $0x1,%ebx
    11a8:	75 de                	jne    1188 <fourfiles+0x178>
      exit();
    11aa:	e8 a4 26 00 00       	call   3853 <exit>
        printf(1, "create failed\n");
    11af:	51                   	push   %ecx
    11b0:	51                   	push   %ecx
    11b1:	68 5f 44 00 00       	push   $0x445f
    11b6:	6a 01                	push   $0x1
    11b8:	e8 33 28 00 00       	call   39f0 <printf>
        exit();
    11bd:	e8 91 26 00 00       	call   3853 <exit>
    11c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
    11c8:	83 ec 08             	sub    $0x8,%esp
    11cb:	68 99 4c 00 00       	push   $0x4c99
    11d0:	6a 01                	push   $0x1
    11d2:	e8 19 28 00 00       	call   39f0 <printf>
      exit();
    11d7:	e8 77 26 00 00       	call   3853 <exit>
      printf(1, "wrong length %d\n", total);
    11dc:	50                   	push   %eax
    11dd:	53                   	push   %ebx
    11de:	68 f1 41 00 00       	push   $0x41f1
    11e3:	6a 01                	push   $0x1
    11e5:	e8 06 28 00 00       	call   39f0 <printf>
      exit();
    11ea:	e8 64 26 00 00       	call   3853 <exit>
          printf(1, "write failed %d\n", n);
    11ef:	52                   	push   %edx
    11f0:	50                   	push   %eax
    11f1:	68 d4 41 00 00       	push   $0x41d4
    11f6:	6a 01                	push   $0x1
    11f8:	e8 f3 27 00 00       	call   39f0 <printf>
          exit();
    11fd:	e8 51 26 00 00       	call   3853 <exit>
    1202:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001210 <createdelete>:
{
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	57                   	push   %edi
    1214:	56                   	push   %esi
    1215:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1216:	31 db                	xor    %ebx,%ebx
{
    1218:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    121b:	68 10 42 00 00       	push   $0x4210
    1220:	6a 01                	push   $0x1
    1222:	e8 c9 27 00 00       	call   39f0 <printf>
    1227:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    122a:	e8 1c 26 00 00       	call   384b <fork>
    if(pid < 0){
    122f:	85 c0                	test   %eax,%eax
    1231:	0f 88 c3 01 00 00    	js     13fa <createdelete+0x1ea>
    if(pid == 0){
    1237:	0f 84 13 01 00 00    	je     1350 <createdelete+0x140>
  for(pi = 0; pi < 4; pi++){
    123d:	83 c3 01             	add    $0x1,%ebx
    1240:	83 fb 04             	cmp    $0x4,%ebx
    1243:	75 e5                	jne    122a <createdelete+0x1a>
    wait();
    1245:	e8 11 26 00 00       	call   385b <wait>
  for(i = 0; i < N; i++){
    124a:	31 f6                	xor    %esi,%esi
    124c:	8d 7d c8             	lea    -0x38(%ebp),%edi
    wait();
    124f:	e8 07 26 00 00       	call   385b <wait>
    1254:	e8 02 26 00 00       	call   385b <wait>
    1259:	e8 fd 25 00 00       	call   385b <wait>
  name[0] = name[1] = name[2] = 0;
    125e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    1262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if((i == 0 || i >= N/2) && fd < 0){
    1268:	83 fe 09             	cmp    $0x9,%esi
    126b:	8d 46 30             	lea    0x30(%esi),%eax
    126e:	0f 9f c3             	setg   %bl
    1271:	85 f6                	test   %esi,%esi
    1273:	88 45 c7             	mov    %al,-0x39(%ebp)
    1276:	0f 94 c0             	sete   %al
    1279:	09 c3                	or     %eax,%ebx
      } else if((i >= 1 && i < N/2) && fd >= 0){
    127b:	8d 46 ff             	lea    -0x1(%esi),%eax
    127e:	89 45 c0             	mov    %eax,-0x40(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    1281:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    1284:	bb 70 00 00 00       	mov    $0x70,%ebx
      fd = open(name, 0);
    1289:	83 ec 08             	sub    $0x8,%esp
      name[1] = '0' + i;
    128c:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      name[0] = 'p' + pi;
    1290:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    1293:	6a 00                	push   $0x0
    1295:	57                   	push   %edi
      name[1] = '0' + i;
    1296:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1299:	e8 f5 25 00 00       	call   3893 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    129e:	83 c4 10             	add    $0x10,%esp
    12a1:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12a5:	0f 84 85 00 00 00    	je     1330 <createdelete+0x120>
    12ab:	85 c0                	test   %eax,%eax
    12ad:	0f 88 32 01 00 00    	js     13e5 <createdelete+0x1d5>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12b3:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    12b7:	76 7b                	jbe    1334 <createdelete+0x124>
        close(fd);
    12b9:	83 ec 0c             	sub    $0xc,%esp
    12bc:	50                   	push   %eax
    12bd:	e8 b9 25 00 00       	call   387b <close>
    12c2:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    12c5:	83 c3 01             	add    $0x1,%ebx
    12c8:	80 fb 74             	cmp    $0x74,%bl
    12cb:	75 bc                	jne    1289 <createdelete+0x79>
  for(i = 0; i < N; i++){
    12cd:	83 c6 01             	add    $0x1,%esi
    12d0:	83 fe 14             	cmp    $0x14,%esi
    12d3:	75 93                	jne    1268 <createdelete+0x58>
    12d5:	be 70 00 00 00       	mov    $0x70,%esi
    12da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(pi = 0; pi < 4; pi++){
    12e0:	8d 46 c0             	lea    -0x40(%esi),%eax
      name[0] = 'p' + i;
    12e3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12e8:	88 45 c7             	mov    %al,-0x39(%ebp)
      unlink(name);
    12eb:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    12ee:	89 f0                	mov    %esi,%eax
      unlink(name);
    12f0:	57                   	push   %edi
      name[0] = 'p' + i;
    12f1:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    12f4:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    12f8:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    12fb:	e8 a3 25 00 00       	call   38a3 <unlink>
    for(pi = 0; pi < 4; pi++){
    1300:	83 c4 10             	add    $0x10,%esp
    1303:	83 eb 01             	sub    $0x1,%ebx
    1306:	75 e3                	jne    12eb <createdelete+0xdb>
  for(i = 0; i < N; i++){
    1308:	83 c6 01             	add    $0x1,%esi
    130b:	89 f0                	mov    %esi,%eax
    130d:	3c 84                	cmp    $0x84,%al
    130f:	75 cf                	jne    12e0 <createdelete+0xd0>
  printf(1, "createdelete ok\n");
    1311:	83 ec 08             	sub    $0x8,%esp
    1314:	68 23 42 00 00       	push   $0x4223
    1319:	6a 01                	push   $0x1
    131b:	e8 d0 26 00 00       	call   39f0 <printf>
}
    1320:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1323:	5b                   	pop    %ebx
    1324:	5e                   	pop    %esi
    1325:	5f                   	pop    %edi
    1326:	5d                   	pop    %ebp
    1327:	c3                   	ret    
    1328:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    132f:	90                   	nop
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1330:	85 c0                	test   %eax,%eax
    1332:	78 91                	js     12c5 <createdelete+0xb5>
        printf(1, "oops createdelete %s did exist\n", name);
    1334:	50                   	push   %eax
    1335:	57                   	push   %edi
    1336:	68 d0 4e 00 00       	push   $0x4ed0
    133b:	6a 01                	push   $0x1
    133d:	e8 ae 26 00 00       	call   39f0 <printf>
        exit();
    1342:	e8 0c 25 00 00       	call   3853 <exit>
    1347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    134e:	66 90                	xchg   %ax,%ax
      name[0] = 'p' + pi;
    1350:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    1353:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1357:	be 01 00 00 00       	mov    $0x1,%esi
    135c:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    135f:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1362:	31 db                	xor    %ebx,%ebx
    1364:	eb 15                	jmp    137b <createdelete+0x16b>
    1366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    136d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < N; i++){
    1370:	83 fe 14             	cmp    $0x14,%esi
    1373:	74 6b                	je     13e0 <createdelete+0x1d0>
    1375:	83 c3 01             	add    $0x1,%ebx
    1378:	83 c6 01             	add    $0x1,%esi
        fd = open(name, O_CREATE | O_RDWR);
    137b:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    137e:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    1381:	68 02 02 00 00       	push   $0x202
    1386:	57                   	push   %edi
        name[1] = '0' + i;
    1387:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    138a:	e8 04 25 00 00       	call   3893 <open>
        if(fd < 0){
    138f:	83 c4 10             	add    $0x10,%esp
    1392:	85 c0                	test   %eax,%eax
    1394:	78 78                	js     140e <createdelete+0x1fe>
        close(fd);
    1396:	83 ec 0c             	sub    $0xc,%esp
    1399:	50                   	push   %eax
    139a:	e8 dc 24 00 00       	call   387b <close>
        if(i > 0 && (i % 2 ) == 0){
    139f:	83 c4 10             	add    $0x10,%esp
    13a2:	85 db                	test   %ebx,%ebx
    13a4:	74 cf                	je     1375 <createdelete+0x165>
    13a6:	f6 c3 01             	test   $0x1,%bl
    13a9:	75 c5                	jne    1370 <createdelete+0x160>
          if(unlink(name) < 0){
    13ab:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    13ae:	89 d8                	mov    %ebx,%eax
          if(unlink(name) < 0){
    13b0:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    13b1:	d1 f8                	sar    %eax
    13b3:	83 c0 30             	add    $0x30,%eax
    13b6:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13b9:	e8 e5 24 00 00       	call   38a3 <unlink>
    13be:	83 c4 10             	add    $0x10,%esp
    13c1:	85 c0                	test   %eax,%eax
    13c3:	79 ab                	jns    1370 <createdelete+0x160>
            printf(1, "unlink failed\n");
    13c5:	52                   	push   %edx
    13c6:	52                   	push   %edx
    13c7:	68 11 3e 00 00       	push   $0x3e11
    13cc:	6a 01                	push   $0x1
    13ce:	e8 1d 26 00 00       	call   39f0 <printf>
            exit();
    13d3:	e8 7b 24 00 00       	call   3853 <exit>
    13d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13df:	90                   	nop
      exit();
    13e0:	e8 6e 24 00 00       	call   3853 <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    13e5:	83 ec 04             	sub    $0x4,%esp
    13e8:	57                   	push   %edi
    13e9:	68 ac 4e 00 00       	push   $0x4eac
    13ee:	6a 01                	push   $0x1
    13f0:	e8 fb 25 00 00       	call   39f0 <printf>
        exit();
    13f5:	e8 59 24 00 00       	call   3853 <exit>
      printf(1, "fork failed\n");
    13fa:	83 ec 08             	sub    $0x8,%esp
    13fd:	68 99 4c 00 00       	push   $0x4c99
    1402:	6a 01                	push   $0x1
    1404:	e8 e7 25 00 00       	call   39f0 <printf>
      exit();
    1409:	e8 45 24 00 00       	call   3853 <exit>
          printf(1, "create failed\n");
    140e:	83 ec 08             	sub    $0x8,%esp
    1411:	68 5f 44 00 00       	push   $0x445f
    1416:	6a 01                	push   $0x1
    1418:	e8 d3 25 00 00       	call   39f0 <printf>
          exit();
    141d:	e8 31 24 00 00       	call   3853 <exit>
    1422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001430 <unlinkread>:
{
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	56                   	push   %esi
    1434:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1435:	83 ec 08             	sub    $0x8,%esp
    1438:	68 34 42 00 00       	push   $0x4234
    143d:	6a 01                	push   $0x1
    143f:	e8 ac 25 00 00       	call   39f0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1444:	5b                   	pop    %ebx
    1445:	5e                   	pop    %esi
    1446:	68 02 02 00 00       	push   $0x202
    144b:	68 45 42 00 00       	push   $0x4245
    1450:	e8 3e 24 00 00       	call   3893 <open>
  if(fd < 0){
    1455:	83 c4 10             	add    $0x10,%esp
    1458:	85 c0                	test   %eax,%eax
    145a:	0f 88 e6 00 00 00    	js     1546 <unlinkread+0x116>
  write(fd, "hello", 5);
    1460:	83 ec 04             	sub    $0x4,%esp
    1463:	89 c3                	mov    %eax,%ebx
    1465:	6a 05                	push   $0x5
    1467:	68 6a 42 00 00       	push   $0x426a
    146c:	50                   	push   %eax
    146d:	e8 01 24 00 00       	call   3873 <write>
  close(fd);
    1472:	89 1c 24             	mov    %ebx,(%esp)
    1475:	e8 01 24 00 00       	call   387b <close>
  fd = open("unlinkread", O_RDWR);
    147a:	58                   	pop    %eax
    147b:	5a                   	pop    %edx
    147c:	6a 02                	push   $0x2
    147e:	68 45 42 00 00       	push   $0x4245
    1483:	e8 0b 24 00 00       	call   3893 <open>
  if(fd < 0){
    1488:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_RDWR);
    148b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    148d:	85 c0                	test   %eax,%eax
    148f:	0f 88 10 01 00 00    	js     15a5 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    1495:	83 ec 0c             	sub    $0xc,%esp
    1498:	68 45 42 00 00       	push   $0x4245
    149d:	e8 01 24 00 00       	call   38a3 <unlink>
    14a2:	83 c4 10             	add    $0x10,%esp
    14a5:	85 c0                	test   %eax,%eax
    14a7:	0f 85 e5 00 00 00    	jne    1592 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14ad:	83 ec 08             	sub    $0x8,%esp
    14b0:	68 02 02 00 00       	push   $0x202
    14b5:	68 45 42 00 00       	push   $0x4245
    14ba:	e8 d4 23 00 00       	call   3893 <open>
  write(fd1, "yyy", 3);
    14bf:	83 c4 0c             	add    $0xc,%esp
    14c2:	6a 03                	push   $0x3
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14c4:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14c6:	68 a2 42 00 00       	push   $0x42a2
    14cb:	50                   	push   %eax
    14cc:	e8 a2 23 00 00       	call   3873 <write>
  close(fd1);
    14d1:	89 34 24             	mov    %esi,(%esp)
    14d4:	e8 a2 23 00 00       	call   387b <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    14d9:	83 c4 0c             	add    $0xc,%esp
    14dc:	68 00 20 00 00       	push   $0x2000
    14e1:	68 e0 84 00 00       	push   $0x84e0
    14e6:	53                   	push   %ebx
    14e7:	e8 7f 23 00 00       	call   386b <read>
    14ec:	83 c4 10             	add    $0x10,%esp
    14ef:	83 f8 05             	cmp    $0x5,%eax
    14f2:	0f 85 87 00 00 00    	jne    157f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    14f8:	80 3d e0 84 00 00 68 	cmpb   $0x68,0x84e0
    14ff:	75 6b                	jne    156c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1501:	83 ec 04             	sub    $0x4,%esp
    1504:	6a 0a                	push   $0xa
    1506:	68 e0 84 00 00       	push   $0x84e0
    150b:	53                   	push   %ebx
    150c:	e8 62 23 00 00       	call   3873 <write>
    1511:	83 c4 10             	add    $0x10,%esp
    1514:	83 f8 0a             	cmp    $0xa,%eax
    1517:	75 40                	jne    1559 <unlinkread+0x129>
  close(fd);
    1519:	83 ec 0c             	sub    $0xc,%esp
    151c:	53                   	push   %ebx
    151d:	e8 59 23 00 00       	call   387b <close>
  unlink("unlinkread");
    1522:	c7 04 24 45 42 00 00 	movl   $0x4245,(%esp)
    1529:	e8 75 23 00 00       	call   38a3 <unlink>
  printf(1, "unlinkread ok\n");
    152e:	58                   	pop    %eax
    152f:	5a                   	pop    %edx
    1530:	68 ed 42 00 00       	push   $0x42ed
    1535:	6a 01                	push   $0x1
    1537:	e8 b4 24 00 00       	call   39f0 <printf>
}
    153c:	83 c4 10             	add    $0x10,%esp
    153f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1542:	5b                   	pop    %ebx
    1543:	5e                   	pop    %esi
    1544:	5d                   	pop    %ebp
    1545:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1546:	51                   	push   %ecx
    1547:	51                   	push   %ecx
    1548:	68 50 42 00 00       	push   $0x4250
    154d:	6a 01                	push   $0x1
    154f:	e8 9c 24 00 00       	call   39f0 <printf>
    exit();
    1554:	e8 fa 22 00 00       	call   3853 <exit>
    printf(1, "unlinkread write failed\n");
    1559:	51                   	push   %ecx
    155a:	51                   	push   %ecx
    155b:	68 d4 42 00 00       	push   $0x42d4
    1560:	6a 01                	push   $0x1
    1562:	e8 89 24 00 00       	call   39f0 <printf>
    exit();
    1567:	e8 e7 22 00 00       	call   3853 <exit>
    printf(1, "unlinkread wrong data\n");
    156c:	53                   	push   %ebx
    156d:	53                   	push   %ebx
    156e:	68 bd 42 00 00       	push   $0x42bd
    1573:	6a 01                	push   $0x1
    1575:	e8 76 24 00 00       	call   39f0 <printf>
    exit();
    157a:	e8 d4 22 00 00       	call   3853 <exit>
    printf(1, "unlinkread read failed");
    157f:	56                   	push   %esi
    1580:	56                   	push   %esi
    1581:	68 a6 42 00 00       	push   $0x42a6
    1586:	6a 01                	push   $0x1
    1588:	e8 63 24 00 00       	call   39f0 <printf>
    exit();
    158d:	e8 c1 22 00 00       	call   3853 <exit>
    printf(1, "unlink unlinkread failed\n");
    1592:	50                   	push   %eax
    1593:	50                   	push   %eax
    1594:	68 88 42 00 00       	push   $0x4288
    1599:	6a 01                	push   $0x1
    159b:	e8 50 24 00 00       	call   39f0 <printf>
    exit();
    15a0:	e8 ae 22 00 00       	call   3853 <exit>
    printf(1, "open unlinkread failed\n");
    15a5:	50                   	push   %eax
    15a6:	50                   	push   %eax
    15a7:	68 70 42 00 00       	push   $0x4270
    15ac:	6a 01                	push   $0x1
    15ae:	e8 3d 24 00 00       	call   39f0 <printf>
    exit();
    15b3:	e8 9b 22 00 00       	call   3853 <exit>
    15b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15bf:	90                   	nop

000015c0 <linktest>:
{
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	53                   	push   %ebx
    15c4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    15c7:	68 fc 42 00 00       	push   $0x42fc
    15cc:	6a 01                	push   $0x1
    15ce:	e8 1d 24 00 00       	call   39f0 <printf>
  unlink("lf1");
    15d3:	c7 04 24 06 43 00 00 	movl   $0x4306,(%esp)
    15da:	e8 c4 22 00 00       	call   38a3 <unlink>
  unlink("lf2");
    15df:	c7 04 24 0a 43 00 00 	movl   $0x430a,(%esp)
    15e6:	e8 b8 22 00 00       	call   38a3 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    15eb:	58                   	pop    %eax
    15ec:	5a                   	pop    %edx
    15ed:	68 02 02 00 00       	push   $0x202
    15f2:	68 06 43 00 00       	push   $0x4306
    15f7:	e8 97 22 00 00       	call   3893 <open>
  if(fd < 0){
    15fc:	83 c4 10             	add    $0x10,%esp
    15ff:	85 c0                	test   %eax,%eax
    1601:	0f 88 1e 01 00 00    	js     1725 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    1607:	83 ec 04             	sub    $0x4,%esp
    160a:	89 c3                	mov    %eax,%ebx
    160c:	6a 05                	push   $0x5
    160e:	68 6a 42 00 00       	push   $0x426a
    1613:	50                   	push   %eax
    1614:	e8 5a 22 00 00       	call   3873 <write>
    1619:	83 c4 10             	add    $0x10,%esp
    161c:	83 f8 05             	cmp    $0x5,%eax
    161f:	0f 85 98 01 00 00    	jne    17bd <linktest+0x1fd>
  close(fd);
    1625:	83 ec 0c             	sub    $0xc,%esp
    1628:	53                   	push   %ebx
    1629:	e8 4d 22 00 00       	call   387b <close>
  if(link("lf1", "lf2") < 0){
    162e:	5b                   	pop    %ebx
    162f:	58                   	pop    %eax
    1630:	68 0a 43 00 00       	push   $0x430a
    1635:	68 06 43 00 00       	push   $0x4306
    163a:	e8 74 22 00 00       	call   38b3 <link>
    163f:	83 c4 10             	add    $0x10,%esp
    1642:	85 c0                	test   %eax,%eax
    1644:	0f 88 60 01 00 00    	js     17aa <linktest+0x1ea>
  unlink("lf1");
    164a:	83 ec 0c             	sub    $0xc,%esp
    164d:	68 06 43 00 00       	push   $0x4306
    1652:	e8 4c 22 00 00       	call   38a3 <unlink>
  if(open("lf1", 0) >= 0){
    1657:	58                   	pop    %eax
    1658:	5a                   	pop    %edx
    1659:	6a 00                	push   $0x0
    165b:	68 06 43 00 00       	push   $0x4306
    1660:	e8 2e 22 00 00       	call   3893 <open>
    1665:	83 c4 10             	add    $0x10,%esp
    1668:	85 c0                	test   %eax,%eax
    166a:	0f 89 27 01 00 00    	jns    1797 <linktest+0x1d7>
  fd = open("lf2", 0);
    1670:	83 ec 08             	sub    $0x8,%esp
    1673:	6a 00                	push   $0x0
    1675:	68 0a 43 00 00       	push   $0x430a
    167a:	e8 14 22 00 00       	call   3893 <open>
  if(fd < 0){
    167f:	83 c4 10             	add    $0x10,%esp
  fd = open("lf2", 0);
    1682:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1684:	85 c0                	test   %eax,%eax
    1686:	0f 88 f8 00 00 00    	js     1784 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    168c:	83 ec 04             	sub    $0x4,%esp
    168f:	68 00 20 00 00       	push   $0x2000
    1694:	68 e0 84 00 00       	push   $0x84e0
    1699:	50                   	push   %eax
    169a:	e8 cc 21 00 00       	call   386b <read>
    169f:	83 c4 10             	add    $0x10,%esp
    16a2:	83 f8 05             	cmp    $0x5,%eax
    16a5:	0f 85 c6 00 00 00    	jne    1771 <linktest+0x1b1>
  close(fd);
    16ab:	83 ec 0c             	sub    $0xc,%esp
    16ae:	53                   	push   %ebx
    16af:	e8 c7 21 00 00       	call   387b <close>
  if(link("lf2", "lf2") >= 0){
    16b4:	58                   	pop    %eax
    16b5:	5a                   	pop    %edx
    16b6:	68 0a 43 00 00       	push   $0x430a
    16bb:	68 0a 43 00 00       	push   $0x430a
    16c0:	e8 ee 21 00 00       	call   38b3 <link>
    16c5:	83 c4 10             	add    $0x10,%esp
    16c8:	85 c0                	test   %eax,%eax
    16ca:	0f 89 8e 00 00 00    	jns    175e <linktest+0x19e>
  unlink("lf2");
    16d0:	83 ec 0c             	sub    $0xc,%esp
    16d3:	68 0a 43 00 00       	push   $0x430a
    16d8:	e8 c6 21 00 00       	call   38a3 <unlink>
  if(link("lf2", "lf1") >= 0){
    16dd:	59                   	pop    %ecx
    16de:	5b                   	pop    %ebx
    16df:	68 06 43 00 00       	push   $0x4306
    16e4:	68 0a 43 00 00       	push   $0x430a
    16e9:	e8 c5 21 00 00       	call   38b3 <link>
    16ee:	83 c4 10             	add    $0x10,%esp
    16f1:	85 c0                	test   %eax,%eax
    16f3:	79 56                	jns    174b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    16f5:	83 ec 08             	sub    $0x8,%esp
    16f8:	68 06 43 00 00       	push   $0x4306
    16fd:	68 ce 45 00 00       	push   $0x45ce
    1702:	e8 ac 21 00 00       	call   38b3 <link>
    1707:	83 c4 10             	add    $0x10,%esp
    170a:	85 c0                	test   %eax,%eax
    170c:	79 2a                	jns    1738 <linktest+0x178>
  printf(1, "linktest ok\n");
    170e:	83 ec 08             	sub    $0x8,%esp
    1711:	68 a4 43 00 00       	push   $0x43a4
    1716:	6a 01                	push   $0x1
    1718:	e8 d3 22 00 00       	call   39f0 <printf>
}
    171d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1720:	83 c4 10             	add    $0x10,%esp
    1723:	c9                   	leave  
    1724:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1725:	50                   	push   %eax
    1726:	50                   	push   %eax
    1727:	68 0e 43 00 00       	push   $0x430e
    172c:	6a 01                	push   $0x1
    172e:	e8 bd 22 00 00       	call   39f0 <printf>
    exit();
    1733:	e8 1b 21 00 00       	call   3853 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1738:	50                   	push   %eax
    1739:	50                   	push   %eax
    173a:	68 88 43 00 00       	push   $0x4388
    173f:	6a 01                	push   $0x1
    1741:	e8 aa 22 00 00       	call   39f0 <printf>
    exit();
    1746:	e8 08 21 00 00       	call   3853 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    174b:	52                   	push   %edx
    174c:	52                   	push   %edx
    174d:	68 18 4f 00 00       	push   $0x4f18
    1752:	6a 01                	push   $0x1
    1754:	e8 97 22 00 00       	call   39f0 <printf>
    exit();
    1759:	e8 f5 20 00 00       	call   3853 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    175e:	50                   	push   %eax
    175f:	50                   	push   %eax
    1760:	68 6a 43 00 00       	push   $0x436a
    1765:	6a 01                	push   $0x1
    1767:	e8 84 22 00 00       	call   39f0 <printf>
    exit();
    176c:	e8 e2 20 00 00       	call   3853 <exit>
    printf(1, "read lf2 failed\n");
    1771:	51                   	push   %ecx
    1772:	51                   	push   %ecx
    1773:	68 59 43 00 00       	push   $0x4359
    1778:	6a 01                	push   $0x1
    177a:	e8 71 22 00 00       	call   39f0 <printf>
    exit();
    177f:	e8 cf 20 00 00       	call   3853 <exit>
    printf(1, "open lf2 failed\n");
    1784:	53                   	push   %ebx
    1785:	53                   	push   %ebx
    1786:	68 48 43 00 00       	push   $0x4348
    178b:	6a 01                	push   $0x1
    178d:	e8 5e 22 00 00       	call   39f0 <printf>
    exit();
    1792:	e8 bc 20 00 00       	call   3853 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1797:	50                   	push   %eax
    1798:	50                   	push   %eax
    1799:	68 f0 4e 00 00       	push   $0x4ef0
    179e:	6a 01                	push   $0x1
    17a0:	e8 4b 22 00 00       	call   39f0 <printf>
    exit();
    17a5:	e8 a9 20 00 00       	call   3853 <exit>
    printf(1, "link lf1 lf2 failed\n");
    17aa:	51                   	push   %ecx
    17ab:	51                   	push   %ecx
    17ac:	68 33 43 00 00       	push   $0x4333
    17b1:	6a 01                	push   $0x1
    17b3:	e8 38 22 00 00       	call   39f0 <printf>
    exit();
    17b8:	e8 96 20 00 00       	call   3853 <exit>
    printf(1, "write lf1 failed\n");
    17bd:	50                   	push   %eax
    17be:	50                   	push   %eax
    17bf:	68 21 43 00 00       	push   $0x4321
    17c4:	6a 01                	push   $0x1
    17c6:	e8 25 22 00 00       	call   39f0 <printf>
    exit();
    17cb:	e8 83 20 00 00       	call   3853 <exit>

000017d0 <concreate>:
{
    17d0:	55                   	push   %ebp
    17d1:	89 e5                	mov    %esp,%ebp
    17d3:	57                   	push   %edi
    17d4:	56                   	push   %esi
  for(i = 0; i < 40; i++){
    17d5:	31 f6                	xor    %esi,%esi
{
    17d7:	53                   	push   %ebx
    17d8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17db:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    17de:	68 b1 43 00 00       	push   $0x43b1
    17e3:	6a 01                	push   $0x1
    17e5:	e8 06 22 00 00       	call   39f0 <printf>
  file[0] = 'C';
    17ea:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    17ee:	83 c4 10             	add    $0x10,%esp
    17f1:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    17f5:	eb 4c                	jmp    1843 <concreate+0x73>
    17f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    17fe:	66 90                	xchg   %ax,%ax
    1800:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    if(pid && (i % 3) == 1){
    1806:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    180b:	0f 83 af 00 00 00    	jae    18c0 <concreate+0xf0>
      fd = open(file, O_CREATE | O_RDWR);
    1811:	83 ec 08             	sub    $0x8,%esp
    1814:	68 02 02 00 00       	push   $0x202
    1819:	53                   	push   %ebx
    181a:	e8 74 20 00 00       	call   3893 <open>
      if(fd < 0){
    181f:	83 c4 10             	add    $0x10,%esp
    1822:	85 c0                	test   %eax,%eax
    1824:	78 5f                	js     1885 <concreate+0xb5>
      close(fd);
    1826:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    1829:	83 c6 01             	add    $0x1,%esi
      close(fd);
    182c:	50                   	push   %eax
    182d:	e8 49 20 00 00       	call   387b <close>
    1832:	83 c4 10             	add    $0x10,%esp
      wait();
    1835:	e8 21 20 00 00       	call   385b <wait>
  for(i = 0; i < 40; i++){
    183a:	83 fe 28             	cmp    $0x28,%esi
    183d:	0f 84 9f 00 00 00    	je     18e2 <concreate+0x112>
    unlink(file);
    1843:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    1846:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    1849:	53                   	push   %ebx
    file[1] = '0' + i;
    184a:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    184d:	e8 51 20 00 00       	call   38a3 <unlink>
    pid = fork();
    1852:	e8 f4 1f 00 00       	call   384b <fork>
    if(pid && (i % 3) == 1){
    1857:	83 c4 10             	add    $0x10,%esp
    185a:	85 c0                	test   %eax,%eax
    185c:	75 a2                	jne    1800 <concreate+0x30>
      link("C0", file);
    185e:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    } else if(pid == 0 && (i % 5) == 1){
    1864:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    186a:	73 34                	jae    18a0 <concreate+0xd0>
      fd = open(file, O_CREATE | O_RDWR);
    186c:	83 ec 08             	sub    $0x8,%esp
    186f:	68 02 02 00 00       	push   $0x202
    1874:	53                   	push   %ebx
    1875:	e8 19 20 00 00       	call   3893 <open>
      if(fd < 0){
    187a:	83 c4 10             	add    $0x10,%esp
    187d:	85 c0                	test   %eax,%eax
    187f:	0f 89 39 02 00 00    	jns    1abe <concreate+0x2ee>
        printf(1, "concreate create %s failed\n", file);
    1885:	83 ec 04             	sub    $0x4,%esp
    1888:	53                   	push   %ebx
    1889:	68 c4 43 00 00       	push   $0x43c4
    188e:	6a 01                	push   $0x1
    1890:	e8 5b 21 00 00       	call   39f0 <printf>
        exit();
    1895:	e8 b9 1f 00 00       	call   3853 <exit>
    189a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("C0", file);
    18a0:	83 ec 08             	sub    $0x8,%esp
    18a3:	53                   	push   %ebx
    18a4:	68 c1 43 00 00       	push   $0x43c1
    18a9:	e8 05 20 00 00       	call   38b3 <link>
    18ae:	83 c4 10             	add    $0x10,%esp
      exit();
    18b1:	e8 9d 1f 00 00       	call   3853 <exit>
    18b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18bd:	8d 76 00             	lea    0x0(%esi),%esi
      link("C0", file);
    18c0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    18c3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    18c6:	53                   	push   %ebx
    18c7:	68 c1 43 00 00       	push   $0x43c1
    18cc:	e8 e2 1f 00 00       	call   38b3 <link>
    18d1:	83 c4 10             	add    $0x10,%esp
      wait();
    18d4:	e8 82 1f 00 00       	call   385b <wait>
  for(i = 0; i < 40; i++){
    18d9:	83 fe 28             	cmp    $0x28,%esi
    18dc:	0f 85 61 ff ff ff    	jne    1843 <concreate+0x73>
  memset(fa, 0, sizeof(fa));
    18e2:	83 ec 04             	sub    $0x4,%esp
    18e5:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18e8:	6a 28                	push   $0x28
    18ea:	6a 00                	push   $0x0
    18ec:	50                   	push   %eax
    18ed:	e8 be 1d 00 00       	call   36b0 <memset>
  fd = open(".", 0);
    18f2:	5e                   	pop    %esi
    18f3:	5f                   	pop    %edi
    18f4:	6a 00                	push   $0x0
    18f6:	68 ce 45 00 00       	push   $0x45ce
    18fb:	8d 7d b0             	lea    -0x50(%ebp),%edi
    18fe:	e8 90 1f 00 00       	call   3893 <open>
  n = 0;
    1903:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    190a:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    190d:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    190f:	90                   	nop
    1910:	83 ec 04             	sub    $0x4,%esp
    1913:	6a 10                	push   $0x10
    1915:	57                   	push   %edi
    1916:	56                   	push   %esi
    1917:	e8 4f 1f 00 00       	call   386b <read>
    191c:	83 c4 10             	add    $0x10,%esp
    191f:	85 c0                	test   %eax,%eax
    1921:	7e 3d                	jle    1960 <concreate+0x190>
    if(de.inum == 0)
    1923:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1928:	74 e6                	je     1910 <concreate+0x140>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    192a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    192e:	75 e0                	jne    1910 <concreate+0x140>
    1930:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1934:	75 da                	jne    1910 <concreate+0x140>
      i = de.name[1] - '0';
    1936:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    193a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    193d:	83 f8 27             	cmp    $0x27,%eax
    1940:	0f 87 60 01 00 00    	ja     1aa6 <concreate+0x2d6>
      if(fa[i]){
    1946:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    194b:	0f 85 3d 01 00 00    	jne    1a8e <concreate+0x2be>
      n++;
    1951:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
      fa[i] = 1;
    1955:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    195a:	eb b4                	jmp    1910 <concreate+0x140>
    195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1960:	83 ec 0c             	sub    $0xc,%esp
    1963:	56                   	push   %esi
    1964:	e8 12 1f 00 00       	call   387b <close>
  if(n != 40){
    1969:	83 c4 10             	add    $0x10,%esp
    196c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1970:	0f 85 05 01 00 00    	jne    1a7b <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    1976:	31 f6                	xor    %esi,%esi
    1978:	eb 4c                	jmp    19c6 <concreate+0x1f6>
    197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    1980:	85 ff                	test   %edi,%edi
    1982:	74 05                	je     1989 <concreate+0x1b9>
    1984:	83 f8 01             	cmp    $0x1,%eax
    1987:	74 6c                	je     19f5 <concreate+0x225>
      unlink(file);
    1989:	83 ec 0c             	sub    $0xc,%esp
    198c:	53                   	push   %ebx
    198d:	e8 11 1f 00 00       	call   38a3 <unlink>
      unlink(file);
    1992:	89 1c 24             	mov    %ebx,(%esp)
    1995:	e8 09 1f 00 00       	call   38a3 <unlink>
      unlink(file);
    199a:	89 1c 24             	mov    %ebx,(%esp)
    199d:	e8 01 1f 00 00       	call   38a3 <unlink>
      unlink(file);
    19a2:	89 1c 24             	mov    %ebx,(%esp)
    19a5:	e8 f9 1e 00 00       	call   38a3 <unlink>
    19aa:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    19ad:	85 ff                	test   %edi,%edi
    19af:	0f 84 fc fe ff ff    	je     18b1 <concreate+0xe1>
      wait();
    19b5:	e8 a1 1e 00 00       	call   385b <wait>
  for(i = 0; i < 40; i++){
    19ba:	83 c6 01             	add    $0x1,%esi
    19bd:	83 fe 28             	cmp    $0x28,%esi
    19c0:	0f 84 8a 00 00 00    	je     1a50 <concreate+0x280>
    file[1] = '0' + i;
    19c6:	8d 46 30             	lea    0x30(%esi),%eax
    19c9:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19cc:	e8 7a 1e 00 00       	call   384b <fork>
    19d1:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19d3:	85 c0                	test   %eax,%eax
    19d5:	0f 88 8c 00 00 00    	js     1a67 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    19db:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19e0:	f7 e6                	mul    %esi
    19e2:	89 d0                	mov    %edx,%eax
    19e4:	83 e2 fe             	and    $0xfffffffe,%edx
    19e7:	d1 e8                	shr    %eax
    19e9:	01 c2                	add    %eax,%edx
    19eb:	89 f0                	mov    %esi,%eax
    19ed:	29 d0                	sub    %edx,%eax
    19ef:	89 c1                	mov    %eax,%ecx
    19f1:	09 f9                	or     %edi,%ecx
    19f3:	75 8b                	jne    1980 <concreate+0x1b0>
      close(open(file, 0));
    19f5:	83 ec 08             	sub    $0x8,%esp
    19f8:	6a 00                	push   $0x0
    19fa:	53                   	push   %ebx
    19fb:	e8 93 1e 00 00       	call   3893 <open>
    1a00:	89 04 24             	mov    %eax,(%esp)
    1a03:	e8 73 1e 00 00       	call   387b <close>
      close(open(file, 0));
    1a08:	58                   	pop    %eax
    1a09:	5a                   	pop    %edx
    1a0a:	6a 00                	push   $0x0
    1a0c:	53                   	push   %ebx
    1a0d:	e8 81 1e 00 00       	call   3893 <open>
    1a12:	89 04 24             	mov    %eax,(%esp)
    1a15:	e8 61 1e 00 00       	call   387b <close>
      close(open(file, 0));
    1a1a:	59                   	pop    %ecx
    1a1b:	58                   	pop    %eax
    1a1c:	6a 00                	push   $0x0
    1a1e:	53                   	push   %ebx
    1a1f:	e8 6f 1e 00 00       	call   3893 <open>
    1a24:	89 04 24             	mov    %eax,(%esp)
    1a27:	e8 4f 1e 00 00       	call   387b <close>
      close(open(file, 0));
    1a2c:	58                   	pop    %eax
    1a2d:	5a                   	pop    %edx
    1a2e:	6a 00                	push   $0x0
    1a30:	53                   	push   %ebx
    1a31:	e8 5d 1e 00 00       	call   3893 <open>
    1a36:	89 04 24             	mov    %eax,(%esp)
    1a39:	e8 3d 1e 00 00       	call   387b <close>
    1a3e:	83 c4 10             	add    $0x10,%esp
    1a41:	e9 67 ff ff ff       	jmp    19ad <concreate+0x1dd>
    1a46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1a4d:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "concreate ok\n");
    1a50:	83 ec 08             	sub    $0x8,%esp
    1a53:	68 16 44 00 00       	push   $0x4416
    1a58:	6a 01                	push   $0x1
    1a5a:	e8 91 1f 00 00       	call   39f0 <printf>
}
    1a5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a62:	5b                   	pop    %ebx
    1a63:	5e                   	pop    %esi
    1a64:	5f                   	pop    %edi
    1a65:	5d                   	pop    %ebp
    1a66:	c3                   	ret    
      printf(1, "fork failed\n");
    1a67:	83 ec 08             	sub    $0x8,%esp
    1a6a:	68 99 4c 00 00       	push   $0x4c99
    1a6f:	6a 01                	push   $0x1
    1a71:	e8 7a 1f 00 00       	call   39f0 <printf>
      exit();
    1a76:	e8 d8 1d 00 00       	call   3853 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a7b:	51                   	push   %ecx
    1a7c:	51                   	push   %ecx
    1a7d:	68 3c 4f 00 00       	push   $0x4f3c
    1a82:	6a 01                	push   $0x1
    1a84:	e8 67 1f 00 00       	call   39f0 <printf>
    exit();
    1a89:	e8 c5 1d 00 00       	call   3853 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1a8e:	83 ec 04             	sub    $0x4,%esp
    1a91:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a94:	50                   	push   %eax
    1a95:	68 f9 43 00 00       	push   $0x43f9
    1a9a:	6a 01                	push   $0x1
    1a9c:	e8 4f 1f 00 00       	call   39f0 <printf>
        exit();
    1aa1:	e8 ad 1d 00 00       	call   3853 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1aa6:	83 ec 04             	sub    $0x4,%esp
    1aa9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1aac:	50                   	push   %eax
    1aad:	68 e0 43 00 00       	push   $0x43e0
    1ab2:	6a 01                	push   $0x1
    1ab4:	e8 37 1f 00 00       	call   39f0 <printf>
        exit();
    1ab9:	e8 95 1d 00 00       	call   3853 <exit>
      close(fd);
    1abe:	83 ec 0c             	sub    $0xc,%esp
    1ac1:	50                   	push   %eax
    1ac2:	e8 b4 1d 00 00       	call   387b <close>
    1ac7:	83 c4 10             	add    $0x10,%esp
    1aca:	e9 e2 fd ff ff       	jmp    18b1 <concreate+0xe1>
    1acf:	90                   	nop

00001ad0 <linkunlink>:
{
    1ad0:	55                   	push   %ebp
    1ad1:	89 e5                	mov    %esp,%ebp
    1ad3:	57                   	push   %edi
    1ad4:	56                   	push   %esi
    1ad5:	53                   	push   %ebx
    1ad6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1ad9:	68 24 44 00 00       	push   $0x4424
    1ade:	6a 01                	push   $0x1
    1ae0:	e8 0b 1f 00 00       	call   39f0 <printf>
  unlink("x");
    1ae5:	c7 04 24 b1 46 00 00 	movl   $0x46b1,(%esp)
    1aec:	e8 b2 1d 00 00       	call   38a3 <unlink>
  pid = fork();
    1af1:	e8 55 1d 00 00       	call   384b <fork>
  if(pid < 0){
    1af6:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1af9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1afc:	85 c0                	test   %eax,%eax
    1afe:	0f 88 b6 00 00 00    	js     1bba <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1b04:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b08:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1b0d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b12:	19 ff                	sbb    %edi,%edi
    1b14:	83 e7 60             	and    $0x60,%edi
    1b17:	83 c7 01             	add    $0x1,%edi
    1b1a:	eb 1e                	jmp    1b3a <linkunlink+0x6a>
    1b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1b20:	83 f8 01             	cmp    $0x1,%eax
    1b23:	74 7b                	je     1ba0 <linkunlink+0xd0>
      unlink("x");
    1b25:	83 ec 0c             	sub    $0xc,%esp
    1b28:	68 b1 46 00 00       	push   $0x46b1
    1b2d:	e8 71 1d 00 00       	call   38a3 <unlink>
    1b32:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b35:	83 eb 01             	sub    $0x1,%ebx
    1b38:	74 41                	je     1b7b <linkunlink+0xab>
    x = x * 1103515245 + 12345;
    1b3a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b40:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b46:	89 f8                	mov    %edi,%eax
    1b48:	f7 e6                	mul    %esi
    1b4a:	89 d0                	mov    %edx,%eax
    1b4c:	83 e2 fe             	and    $0xfffffffe,%edx
    1b4f:	d1 e8                	shr    %eax
    1b51:	01 c2                	add    %eax,%edx
    1b53:	89 f8                	mov    %edi,%eax
    1b55:	29 d0                	sub    %edx,%eax
    1b57:	75 c7                	jne    1b20 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b59:	83 ec 08             	sub    $0x8,%esp
    1b5c:	68 02 02 00 00       	push   $0x202
    1b61:	68 b1 46 00 00       	push   $0x46b1
    1b66:	e8 28 1d 00 00       	call   3893 <open>
    1b6b:	89 04 24             	mov    %eax,(%esp)
    1b6e:	e8 08 1d 00 00       	call   387b <close>
    1b73:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b76:	83 eb 01             	sub    $0x1,%ebx
    1b79:	75 bf                	jne    1b3a <linkunlink+0x6a>
  if(pid)
    1b7b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b7e:	85 c0                	test   %eax,%eax
    1b80:	74 4b                	je     1bcd <linkunlink+0xfd>
    wait();
    1b82:	e8 d4 1c 00 00       	call   385b <wait>
  printf(1, "linkunlink ok\n");
    1b87:	83 ec 08             	sub    $0x8,%esp
    1b8a:	68 39 44 00 00       	push   $0x4439
    1b8f:	6a 01                	push   $0x1
    1b91:	e8 5a 1e 00 00       	call   39f0 <printf>
}
    1b96:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b99:	5b                   	pop    %ebx
    1b9a:	5e                   	pop    %esi
    1b9b:	5f                   	pop    %edi
    1b9c:	5d                   	pop    %ebp
    1b9d:	c3                   	ret    
    1b9e:	66 90                	xchg   %ax,%ax
      link("cat", "x");
    1ba0:	83 ec 08             	sub    $0x8,%esp
    1ba3:	68 b1 46 00 00       	push   $0x46b1
    1ba8:	68 35 44 00 00       	push   $0x4435
    1bad:	e8 01 1d 00 00       	call   38b3 <link>
    1bb2:	83 c4 10             	add    $0x10,%esp
    1bb5:	e9 7b ff ff ff       	jmp    1b35 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1bba:	52                   	push   %edx
    1bbb:	52                   	push   %edx
    1bbc:	68 99 4c 00 00       	push   $0x4c99
    1bc1:	6a 01                	push   $0x1
    1bc3:	e8 28 1e 00 00       	call   39f0 <printf>
    exit();
    1bc8:	e8 86 1c 00 00       	call   3853 <exit>
    exit();
    1bcd:	e8 81 1c 00 00       	call   3853 <exit>
    1bd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001be0 <bigdir>:
{
    1be0:	55                   	push   %ebp
    1be1:	89 e5                	mov    %esp,%ebp
    1be3:	57                   	push   %edi
    1be4:	56                   	push   %esi
    1be5:	53                   	push   %ebx
    1be6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1be9:	68 48 44 00 00       	push   $0x4448
    1bee:	6a 01                	push   $0x1
    1bf0:	e8 fb 1d 00 00       	call   39f0 <printf>
  unlink("bd");
    1bf5:	c7 04 24 55 44 00 00 	movl   $0x4455,(%esp)
    1bfc:	e8 a2 1c 00 00       	call   38a3 <unlink>
  fd = open("bd", O_CREATE);
    1c01:	5a                   	pop    %edx
    1c02:	59                   	pop    %ecx
    1c03:	68 00 02 00 00       	push   $0x200
    1c08:	68 55 44 00 00       	push   $0x4455
    1c0d:	e8 81 1c 00 00       	call   3893 <open>
  if(fd < 0){
    1c12:	83 c4 10             	add    $0x10,%esp
    1c15:	85 c0                	test   %eax,%eax
    1c17:	0f 88 de 00 00 00    	js     1cfb <bigdir+0x11b>
  close(fd);
    1c1d:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1c20:	31 f6                	xor    %esi,%esi
    1c22:	8d 7d de             	lea    -0x22(%ebp),%edi
  close(fd);
    1c25:	50                   	push   %eax
    1c26:	e8 50 1c 00 00       	call   387b <close>
    1c2b:	83 c4 10             	add    $0x10,%esp
    1c2e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c30:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c32:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c35:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c39:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c3c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c3d:	83 c0 30             	add    $0x30,%eax
    if(link("bd", name) != 0){
    1c40:	68 55 44 00 00       	push   $0x4455
    name[1] = '0' + (i / 64);
    1c45:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c48:	89 f0                	mov    %esi,%eax
    1c4a:	83 e0 3f             	and    $0x3f,%eax
    name[3] = '\0';
    1c4d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[2] = '0' + (i % 64);
    1c51:	83 c0 30             	add    $0x30,%eax
    1c54:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c57:	e8 57 1c 00 00       	call   38b3 <link>
    1c5c:	83 c4 10             	add    $0x10,%esp
    1c5f:	89 c3                	mov    %eax,%ebx
    1c61:	85 c0                	test   %eax,%eax
    1c63:	75 6e                	jne    1cd3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c65:	83 c6 01             	add    $0x1,%esi
    1c68:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c6e:	75 c0                	jne    1c30 <bigdir+0x50>
  unlink("bd");
    1c70:	83 ec 0c             	sub    $0xc,%esp
    1c73:	68 55 44 00 00       	push   $0x4455
    1c78:	e8 26 1c 00 00       	call   38a3 <unlink>
    1c7d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    1c80:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1c82:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1c85:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c89:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1c8c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c8d:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1c90:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c94:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c97:	89 d8                	mov    %ebx,%eax
    1c99:	83 e0 3f             	and    $0x3f,%eax
    1c9c:	83 c0 30             	add    $0x30,%eax
    1c9f:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1ca2:	e8 fc 1b 00 00       	call   38a3 <unlink>
    1ca7:	83 c4 10             	add    $0x10,%esp
    1caa:	85 c0                	test   %eax,%eax
    1cac:	75 39                	jne    1ce7 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1cae:	83 c3 01             	add    $0x1,%ebx
    1cb1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cb7:	75 c7                	jne    1c80 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1cb9:	83 ec 08             	sub    $0x8,%esp
    1cbc:	68 97 44 00 00       	push   $0x4497
    1cc1:	6a 01                	push   $0x1
    1cc3:	e8 28 1d 00 00       	call   39f0 <printf>
    1cc8:	83 c4 10             	add    $0x10,%esp
}
    1ccb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cce:	5b                   	pop    %ebx
    1ccf:	5e                   	pop    %esi
    1cd0:	5f                   	pop    %edi
    1cd1:	5d                   	pop    %ebp
    1cd2:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1cd3:	83 ec 08             	sub    $0x8,%esp
    1cd6:	68 6e 44 00 00       	push   $0x446e
    1cdb:	6a 01                	push   $0x1
    1cdd:	e8 0e 1d 00 00       	call   39f0 <printf>
      exit();
    1ce2:	e8 6c 1b 00 00       	call   3853 <exit>
      printf(1, "bigdir unlink failed");
    1ce7:	83 ec 08             	sub    $0x8,%esp
    1cea:	68 82 44 00 00       	push   $0x4482
    1cef:	6a 01                	push   $0x1
    1cf1:	e8 fa 1c 00 00       	call   39f0 <printf>
      exit();
    1cf6:	e8 58 1b 00 00       	call   3853 <exit>
    printf(1, "bigdir create failed\n");
    1cfb:	50                   	push   %eax
    1cfc:	50                   	push   %eax
    1cfd:	68 58 44 00 00       	push   $0x4458
    1d02:	6a 01                	push   $0x1
    1d04:	e8 e7 1c 00 00       	call   39f0 <printf>
    exit();
    1d09:	e8 45 1b 00 00       	call   3853 <exit>
    1d0e:	66 90                	xchg   %ax,%ax

00001d10 <subdir>:
{
    1d10:	55                   	push   %ebp
    1d11:	89 e5                	mov    %esp,%ebp
    1d13:	53                   	push   %ebx
    1d14:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1d17:	68 a2 44 00 00       	push   $0x44a2
    1d1c:	6a 01                	push   $0x1
    1d1e:	e8 cd 1c 00 00       	call   39f0 <printf>
  unlink("ff");
    1d23:	c7 04 24 2b 45 00 00 	movl   $0x452b,(%esp)
    1d2a:	e8 74 1b 00 00       	call   38a3 <unlink>
  if(mkdir("dd") != 0){
    1d2f:	c7 04 24 c8 45 00 00 	movl   $0x45c8,(%esp)
    1d36:	e8 80 1b 00 00       	call   38bb <mkdir>
    1d3b:	83 c4 10             	add    $0x10,%esp
    1d3e:	85 c0                	test   %eax,%eax
    1d40:	0f 85 b3 05 00 00    	jne    22f9 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d46:	83 ec 08             	sub    $0x8,%esp
    1d49:	68 02 02 00 00       	push   $0x202
    1d4e:	68 01 45 00 00       	push   $0x4501
    1d53:	e8 3b 1b 00 00       	call   3893 <open>
  if(fd < 0){
    1d58:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d5b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d5d:	85 c0                	test   %eax,%eax
    1d5f:	0f 88 81 05 00 00    	js     22e6 <subdir+0x5d6>
  write(fd, "ff", 2);
    1d65:	83 ec 04             	sub    $0x4,%esp
    1d68:	6a 02                	push   $0x2
    1d6a:	68 2b 45 00 00       	push   $0x452b
    1d6f:	50                   	push   %eax
    1d70:	e8 fe 1a 00 00       	call   3873 <write>
  close(fd);
    1d75:	89 1c 24             	mov    %ebx,(%esp)
    1d78:	e8 fe 1a 00 00       	call   387b <close>
  if(unlink("dd") >= 0){
    1d7d:	c7 04 24 c8 45 00 00 	movl   $0x45c8,(%esp)
    1d84:	e8 1a 1b 00 00       	call   38a3 <unlink>
    1d89:	83 c4 10             	add    $0x10,%esp
    1d8c:	85 c0                	test   %eax,%eax
    1d8e:	0f 89 3f 05 00 00    	jns    22d3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1d94:	83 ec 0c             	sub    $0xc,%esp
    1d97:	68 dc 44 00 00       	push   $0x44dc
    1d9c:	e8 1a 1b 00 00       	call   38bb <mkdir>
    1da1:	83 c4 10             	add    $0x10,%esp
    1da4:	85 c0                	test   %eax,%eax
    1da6:	0f 85 14 05 00 00    	jne    22c0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dac:	83 ec 08             	sub    $0x8,%esp
    1daf:	68 02 02 00 00       	push   $0x202
    1db4:	68 fe 44 00 00       	push   $0x44fe
    1db9:	e8 d5 1a 00 00       	call   3893 <open>
  if(fd < 0){
    1dbe:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dc1:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1dc3:	85 c0                	test   %eax,%eax
    1dc5:	0f 88 24 04 00 00    	js     21ef <subdir+0x4df>
  write(fd, "FF", 2);
    1dcb:	83 ec 04             	sub    $0x4,%esp
    1dce:	6a 02                	push   $0x2
    1dd0:	68 1f 45 00 00       	push   $0x451f
    1dd5:	50                   	push   %eax
    1dd6:	e8 98 1a 00 00       	call   3873 <write>
  close(fd);
    1ddb:	89 1c 24             	mov    %ebx,(%esp)
    1dde:	e8 98 1a 00 00       	call   387b <close>
  fd = open("dd/dd/../ff", 0);
    1de3:	58                   	pop    %eax
    1de4:	5a                   	pop    %edx
    1de5:	6a 00                	push   $0x0
    1de7:	68 22 45 00 00       	push   $0x4522
    1dec:	e8 a2 1a 00 00       	call   3893 <open>
  if(fd < 0){
    1df1:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/../ff", 0);
    1df4:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1df6:	85 c0                	test   %eax,%eax
    1df8:	0f 88 de 03 00 00    	js     21dc <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    1dfe:	83 ec 04             	sub    $0x4,%esp
    1e01:	68 00 20 00 00       	push   $0x2000
    1e06:	68 e0 84 00 00       	push   $0x84e0
    1e0b:	50                   	push   %eax
    1e0c:	e8 5a 1a 00 00       	call   386b <read>
  if(cc != 2 || buf[0] != 'f'){
    1e11:	83 c4 10             	add    $0x10,%esp
    1e14:	83 f8 02             	cmp    $0x2,%eax
    1e17:	0f 85 3a 03 00 00    	jne    2157 <subdir+0x447>
    1e1d:	80 3d e0 84 00 00 66 	cmpb   $0x66,0x84e0
    1e24:	0f 85 2d 03 00 00    	jne    2157 <subdir+0x447>
  close(fd);
    1e2a:	83 ec 0c             	sub    $0xc,%esp
    1e2d:	53                   	push   %ebx
    1e2e:	e8 48 1a 00 00       	call   387b <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e33:	59                   	pop    %ecx
    1e34:	5b                   	pop    %ebx
    1e35:	68 62 45 00 00       	push   $0x4562
    1e3a:	68 fe 44 00 00       	push   $0x44fe
    1e3f:	e8 6f 1a 00 00       	call   38b3 <link>
    1e44:	83 c4 10             	add    $0x10,%esp
    1e47:	85 c0                	test   %eax,%eax
    1e49:	0f 85 c6 03 00 00    	jne    2215 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e4f:	83 ec 0c             	sub    $0xc,%esp
    1e52:	68 fe 44 00 00       	push   $0x44fe
    1e57:	e8 47 1a 00 00       	call   38a3 <unlink>
    1e5c:	83 c4 10             	add    $0x10,%esp
    1e5f:	85 c0                	test   %eax,%eax
    1e61:	0f 85 16 03 00 00    	jne    217d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e67:	83 ec 08             	sub    $0x8,%esp
    1e6a:	6a 00                	push   $0x0
    1e6c:	68 fe 44 00 00       	push   $0x44fe
    1e71:	e8 1d 1a 00 00       	call   3893 <open>
    1e76:	83 c4 10             	add    $0x10,%esp
    1e79:	85 c0                	test   %eax,%eax
    1e7b:	0f 89 2c 04 00 00    	jns    22ad <subdir+0x59d>
  if(chdir("dd") != 0){
    1e81:	83 ec 0c             	sub    $0xc,%esp
    1e84:	68 c8 45 00 00       	push   $0x45c8
    1e89:	e8 35 1a 00 00       	call   38c3 <chdir>
    1e8e:	83 c4 10             	add    $0x10,%esp
    1e91:	85 c0                	test   %eax,%eax
    1e93:	0f 85 01 04 00 00    	jne    229a <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1e99:	83 ec 0c             	sub    $0xc,%esp
    1e9c:	68 96 45 00 00       	push   $0x4596
    1ea1:	e8 1d 1a 00 00       	call   38c3 <chdir>
    1ea6:	83 c4 10             	add    $0x10,%esp
    1ea9:	85 c0                	test   %eax,%eax
    1eab:	0f 85 b9 02 00 00    	jne    216a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1eb1:	83 ec 0c             	sub    $0xc,%esp
    1eb4:	68 bc 45 00 00       	push   $0x45bc
    1eb9:	e8 05 1a 00 00       	call   38c3 <chdir>
    1ebe:	83 c4 10             	add    $0x10,%esp
    1ec1:	85 c0                	test   %eax,%eax
    1ec3:	0f 85 a1 02 00 00    	jne    216a <subdir+0x45a>
  if(chdir("./..") != 0){
    1ec9:	83 ec 0c             	sub    $0xc,%esp
    1ecc:	68 cb 45 00 00       	push   $0x45cb
    1ed1:	e8 ed 19 00 00       	call   38c3 <chdir>
    1ed6:	83 c4 10             	add    $0x10,%esp
    1ed9:	85 c0                	test   %eax,%eax
    1edb:	0f 85 21 03 00 00    	jne    2202 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1ee1:	83 ec 08             	sub    $0x8,%esp
    1ee4:	6a 00                	push   $0x0
    1ee6:	68 62 45 00 00       	push   $0x4562
    1eeb:	e8 a3 19 00 00       	call   3893 <open>
  if(fd < 0){
    1ef0:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ffff", 0);
    1ef3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ef5:	85 c0                	test   %eax,%eax
    1ef7:	0f 88 e0 04 00 00    	js     23dd <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    1efd:	83 ec 04             	sub    $0x4,%esp
    1f00:	68 00 20 00 00       	push   $0x2000
    1f05:	68 e0 84 00 00       	push   $0x84e0
    1f0a:	50                   	push   %eax
    1f0b:	e8 5b 19 00 00       	call   386b <read>
    1f10:	83 c4 10             	add    $0x10,%esp
    1f13:	83 f8 02             	cmp    $0x2,%eax
    1f16:	0f 85 ae 04 00 00    	jne    23ca <subdir+0x6ba>
  close(fd);
    1f1c:	83 ec 0c             	sub    $0xc,%esp
    1f1f:	53                   	push   %ebx
    1f20:	e8 56 19 00 00       	call   387b <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f25:	58                   	pop    %eax
    1f26:	5a                   	pop    %edx
    1f27:	6a 00                	push   $0x0
    1f29:	68 fe 44 00 00       	push   $0x44fe
    1f2e:	e8 60 19 00 00       	call   3893 <open>
    1f33:	83 c4 10             	add    $0x10,%esp
    1f36:	85 c0                	test   %eax,%eax
    1f38:	0f 89 65 02 00 00    	jns    21a3 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f3e:	83 ec 08             	sub    $0x8,%esp
    1f41:	68 02 02 00 00       	push   $0x202
    1f46:	68 16 46 00 00       	push   $0x4616
    1f4b:	e8 43 19 00 00       	call   3893 <open>
    1f50:	83 c4 10             	add    $0x10,%esp
    1f53:	85 c0                	test   %eax,%eax
    1f55:	0f 89 35 02 00 00    	jns    2190 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f5b:	83 ec 08             	sub    $0x8,%esp
    1f5e:	68 02 02 00 00       	push   $0x202
    1f63:	68 3b 46 00 00       	push   $0x463b
    1f68:	e8 26 19 00 00       	call   3893 <open>
    1f6d:	83 c4 10             	add    $0x10,%esp
    1f70:	85 c0                	test   %eax,%eax
    1f72:	0f 89 0f 03 00 00    	jns    2287 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f78:	83 ec 08             	sub    $0x8,%esp
    1f7b:	68 00 02 00 00       	push   $0x200
    1f80:	68 c8 45 00 00       	push   $0x45c8
    1f85:	e8 09 19 00 00       	call   3893 <open>
    1f8a:	83 c4 10             	add    $0x10,%esp
    1f8d:	85 c0                	test   %eax,%eax
    1f8f:	0f 89 df 02 00 00    	jns    2274 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1f95:	83 ec 08             	sub    $0x8,%esp
    1f98:	6a 02                	push   $0x2
    1f9a:	68 c8 45 00 00       	push   $0x45c8
    1f9f:	e8 ef 18 00 00       	call   3893 <open>
    1fa4:	83 c4 10             	add    $0x10,%esp
    1fa7:	85 c0                	test   %eax,%eax
    1fa9:	0f 89 b2 02 00 00    	jns    2261 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1faf:	83 ec 08             	sub    $0x8,%esp
    1fb2:	6a 01                	push   $0x1
    1fb4:	68 c8 45 00 00       	push   $0x45c8
    1fb9:	e8 d5 18 00 00       	call   3893 <open>
    1fbe:	83 c4 10             	add    $0x10,%esp
    1fc1:	85 c0                	test   %eax,%eax
    1fc3:	0f 89 85 02 00 00    	jns    224e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fc9:	83 ec 08             	sub    $0x8,%esp
    1fcc:	68 aa 46 00 00       	push   $0x46aa
    1fd1:	68 16 46 00 00       	push   $0x4616
    1fd6:	e8 d8 18 00 00       	call   38b3 <link>
    1fdb:	83 c4 10             	add    $0x10,%esp
    1fde:	85 c0                	test   %eax,%eax
    1fe0:	0f 84 55 02 00 00    	je     223b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1fe6:	83 ec 08             	sub    $0x8,%esp
    1fe9:	68 aa 46 00 00       	push   $0x46aa
    1fee:	68 3b 46 00 00       	push   $0x463b
    1ff3:	e8 bb 18 00 00       	call   38b3 <link>
    1ff8:	83 c4 10             	add    $0x10,%esp
    1ffb:	85 c0                	test   %eax,%eax
    1ffd:	0f 84 25 02 00 00    	je     2228 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2003:	83 ec 08             	sub    $0x8,%esp
    2006:	68 62 45 00 00       	push   $0x4562
    200b:	68 01 45 00 00       	push   $0x4501
    2010:	e8 9e 18 00 00       	call   38b3 <link>
    2015:	83 c4 10             	add    $0x10,%esp
    2018:	85 c0                	test   %eax,%eax
    201a:	0f 84 a9 01 00 00    	je     21c9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2020:	83 ec 0c             	sub    $0xc,%esp
    2023:	68 16 46 00 00       	push   $0x4616
    2028:	e8 8e 18 00 00       	call   38bb <mkdir>
    202d:	83 c4 10             	add    $0x10,%esp
    2030:	85 c0                	test   %eax,%eax
    2032:	0f 84 7e 01 00 00    	je     21b6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2038:	83 ec 0c             	sub    $0xc,%esp
    203b:	68 3b 46 00 00       	push   $0x463b
    2040:	e8 76 18 00 00       	call   38bb <mkdir>
    2045:	83 c4 10             	add    $0x10,%esp
    2048:	85 c0                	test   %eax,%eax
    204a:	0f 84 67 03 00 00    	je     23b7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2050:	83 ec 0c             	sub    $0xc,%esp
    2053:	68 62 45 00 00       	push   $0x4562
    2058:	e8 5e 18 00 00       	call   38bb <mkdir>
    205d:	83 c4 10             	add    $0x10,%esp
    2060:	85 c0                	test   %eax,%eax
    2062:	0f 84 3c 03 00 00    	je     23a4 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2068:	83 ec 0c             	sub    $0xc,%esp
    206b:	68 3b 46 00 00       	push   $0x463b
    2070:	e8 2e 18 00 00       	call   38a3 <unlink>
    2075:	83 c4 10             	add    $0x10,%esp
    2078:	85 c0                	test   %eax,%eax
    207a:	0f 84 11 03 00 00    	je     2391 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    2080:	83 ec 0c             	sub    $0xc,%esp
    2083:	68 16 46 00 00       	push   $0x4616
    2088:	e8 16 18 00 00       	call   38a3 <unlink>
    208d:	83 c4 10             	add    $0x10,%esp
    2090:	85 c0                	test   %eax,%eax
    2092:	0f 84 e6 02 00 00    	je     237e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    2098:	83 ec 0c             	sub    $0xc,%esp
    209b:	68 01 45 00 00       	push   $0x4501
    20a0:	e8 1e 18 00 00       	call   38c3 <chdir>
    20a5:	83 c4 10             	add    $0x10,%esp
    20a8:	85 c0                	test   %eax,%eax
    20aa:	0f 84 bb 02 00 00    	je     236b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20b0:	83 ec 0c             	sub    $0xc,%esp
    20b3:	68 ad 46 00 00       	push   $0x46ad
    20b8:	e8 06 18 00 00       	call   38c3 <chdir>
    20bd:	83 c4 10             	add    $0x10,%esp
    20c0:	85 c0                	test   %eax,%eax
    20c2:	0f 84 90 02 00 00    	je     2358 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20c8:	83 ec 0c             	sub    $0xc,%esp
    20cb:	68 62 45 00 00       	push   $0x4562
    20d0:	e8 ce 17 00 00       	call   38a3 <unlink>
    20d5:	83 c4 10             	add    $0x10,%esp
    20d8:	85 c0                	test   %eax,%eax
    20da:	0f 85 9d 00 00 00    	jne    217d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    20e0:	83 ec 0c             	sub    $0xc,%esp
    20e3:	68 01 45 00 00       	push   $0x4501
    20e8:	e8 b6 17 00 00       	call   38a3 <unlink>
    20ed:	83 c4 10             	add    $0x10,%esp
    20f0:	85 c0                	test   %eax,%eax
    20f2:	0f 85 4d 02 00 00    	jne    2345 <subdir+0x635>
  if(unlink("dd") == 0){
    20f8:	83 ec 0c             	sub    $0xc,%esp
    20fb:	68 c8 45 00 00       	push   $0x45c8
    2100:	e8 9e 17 00 00       	call   38a3 <unlink>
    2105:	83 c4 10             	add    $0x10,%esp
    2108:	85 c0                	test   %eax,%eax
    210a:	0f 84 22 02 00 00    	je     2332 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2110:	83 ec 0c             	sub    $0xc,%esp
    2113:	68 dd 44 00 00       	push   $0x44dd
    2118:	e8 86 17 00 00       	call   38a3 <unlink>
    211d:	83 c4 10             	add    $0x10,%esp
    2120:	85 c0                	test   %eax,%eax
    2122:	0f 88 f7 01 00 00    	js     231f <subdir+0x60f>
  if(unlink("dd") < 0){
    2128:	83 ec 0c             	sub    $0xc,%esp
    212b:	68 c8 45 00 00       	push   $0x45c8
    2130:	e8 6e 17 00 00       	call   38a3 <unlink>
    2135:	83 c4 10             	add    $0x10,%esp
    2138:	85 c0                	test   %eax,%eax
    213a:	0f 88 cc 01 00 00    	js     230c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2140:	83 ec 08             	sub    $0x8,%esp
    2143:	68 aa 47 00 00       	push   $0x47aa
    2148:	6a 01                	push   $0x1
    214a:	e8 a1 18 00 00       	call   39f0 <printf>
}
    214f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2152:	83 c4 10             	add    $0x10,%esp
    2155:	c9                   	leave  
    2156:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2157:	50                   	push   %eax
    2158:	50                   	push   %eax
    2159:	68 47 45 00 00       	push   $0x4547
    215e:	6a 01                	push   $0x1
    2160:	e8 8b 18 00 00       	call   39f0 <printf>
    exit();
    2165:	e8 e9 16 00 00       	call   3853 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    216a:	50                   	push   %eax
    216b:	50                   	push   %eax
    216c:	68 a2 45 00 00       	push   $0x45a2
    2171:	6a 01                	push   $0x1
    2173:	e8 78 18 00 00       	call   39f0 <printf>
    exit();
    2178:	e8 d6 16 00 00       	call   3853 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    217d:	50                   	push   %eax
    217e:	50                   	push   %eax
    217f:	68 6d 45 00 00       	push   $0x456d
    2184:	6a 01                	push   $0x1
    2186:	e8 65 18 00 00       	call   39f0 <printf>
    exit();
    218b:	e8 c3 16 00 00       	call   3853 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    2190:	51                   	push   %ecx
    2191:	51                   	push   %ecx
    2192:	68 1f 46 00 00       	push   $0x461f
    2197:	6a 01                	push   $0x1
    2199:	e8 52 18 00 00       	call   39f0 <printf>
    exit();
    219e:	e8 b0 16 00 00       	call   3853 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    21a3:	53                   	push   %ebx
    21a4:	53                   	push   %ebx
    21a5:	68 e0 4f 00 00       	push   $0x4fe0
    21aa:	6a 01                	push   $0x1
    21ac:	e8 3f 18 00 00       	call   39f0 <printf>
    exit();
    21b1:	e8 9d 16 00 00       	call   3853 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21b6:	51                   	push   %ecx
    21b7:	51                   	push   %ecx
    21b8:	68 b3 46 00 00       	push   $0x46b3
    21bd:	6a 01                	push   $0x1
    21bf:	e8 2c 18 00 00       	call   39f0 <printf>
    exit();
    21c4:	e8 8a 16 00 00       	call   3853 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21c9:	53                   	push   %ebx
    21ca:	53                   	push   %ebx
    21cb:	68 50 50 00 00       	push   $0x5050
    21d0:	6a 01                	push   $0x1
    21d2:	e8 19 18 00 00       	call   39f0 <printf>
    exit();
    21d7:	e8 77 16 00 00       	call   3853 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21dc:	50                   	push   %eax
    21dd:	50                   	push   %eax
    21de:	68 2e 45 00 00       	push   $0x452e
    21e3:	6a 01                	push   $0x1
    21e5:	e8 06 18 00 00       	call   39f0 <printf>
    exit();
    21ea:	e8 64 16 00 00       	call   3853 <exit>
    printf(1, "create dd/dd/ff failed\n");
    21ef:	51                   	push   %ecx
    21f0:	51                   	push   %ecx
    21f1:	68 07 45 00 00       	push   $0x4507
    21f6:	6a 01                	push   $0x1
    21f8:	e8 f3 17 00 00       	call   39f0 <printf>
    exit();
    21fd:	e8 51 16 00 00       	call   3853 <exit>
    printf(1, "chdir ./.. failed\n");
    2202:	50                   	push   %eax
    2203:	50                   	push   %eax
    2204:	68 d0 45 00 00       	push   $0x45d0
    2209:	6a 01                	push   $0x1
    220b:	e8 e0 17 00 00       	call   39f0 <printf>
    exit();
    2210:	e8 3e 16 00 00       	call   3853 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2215:	52                   	push   %edx
    2216:	52                   	push   %edx
    2217:	68 98 4f 00 00       	push   $0x4f98
    221c:	6a 01                	push   $0x1
    221e:	e8 cd 17 00 00       	call   39f0 <printf>
    exit();
    2223:	e8 2b 16 00 00       	call   3853 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2228:	50                   	push   %eax
    2229:	50                   	push   %eax
    222a:	68 2c 50 00 00       	push   $0x502c
    222f:	6a 01                	push   $0x1
    2231:	e8 ba 17 00 00       	call   39f0 <printf>
    exit();
    2236:	e8 18 16 00 00       	call   3853 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    223b:	50                   	push   %eax
    223c:	50                   	push   %eax
    223d:	68 08 50 00 00       	push   $0x5008
    2242:	6a 01                	push   $0x1
    2244:	e8 a7 17 00 00       	call   39f0 <printf>
    exit();
    2249:	e8 05 16 00 00       	call   3853 <exit>
    printf(1, "open dd wronly succeeded!\n");
    224e:	50                   	push   %eax
    224f:	50                   	push   %eax
    2250:	68 8f 46 00 00       	push   $0x468f
    2255:	6a 01                	push   $0x1
    2257:	e8 94 17 00 00       	call   39f0 <printf>
    exit();
    225c:	e8 f2 15 00 00       	call   3853 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2261:	50                   	push   %eax
    2262:	50                   	push   %eax
    2263:	68 76 46 00 00       	push   $0x4676
    2268:	6a 01                	push   $0x1
    226a:	e8 81 17 00 00       	call   39f0 <printf>
    exit();
    226f:	e8 df 15 00 00       	call   3853 <exit>
    printf(1, "create dd succeeded!\n");
    2274:	50                   	push   %eax
    2275:	50                   	push   %eax
    2276:	68 60 46 00 00       	push   $0x4660
    227b:	6a 01                	push   $0x1
    227d:	e8 6e 17 00 00       	call   39f0 <printf>
    exit();
    2282:	e8 cc 15 00 00       	call   3853 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2287:	52                   	push   %edx
    2288:	52                   	push   %edx
    2289:	68 44 46 00 00       	push   $0x4644
    228e:	6a 01                	push   $0x1
    2290:	e8 5b 17 00 00       	call   39f0 <printf>
    exit();
    2295:	e8 b9 15 00 00       	call   3853 <exit>
    printf(1, "chdir dd failed\n");
    229a:	50                   	push   %eax
    229b:	50                   	push   %eax
    229c:	68 85 45 00 00       	push   $0x4585
    22a1:	6a 01                	push   $0x1
    22a3:	e8 48 17 00 00       	call   39f0 <printf>
    exit();
    22a8:	e8 a6 15 00 00       	call   3853 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    22ad:	50                   	push   %eax
    22ae:	50                   	push   %eax
    22af:	68 bc 4f 00 00       	push   $0x4fbc
    22b4:	6a 01                	push   $0x1
    22b6:	e8 35 17 00 00       	call   39f0 <printf>
    exit();
    22bb:	e8 93 15 00 00       	call   3853 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    22c0:	53                   	push   %ebx
    22c1:	53                   	push   %ebx
    22c2:	68 e3 44 00 00       	push   $0x44e3
    22c7:	6a 01                	push   $0x1
    22c9:	e8 22 17 00 00       	call   39f0 <printf>
    exit();
    22ce:	e8 80 15 00 00       	call   3853 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22d3:	50                   	push   %eax
    22d4:	50                   	push   %eax
    22d5:	68 70 4f 00 00       	push   $0x4f70
    22da:	6a 01                	push   $0x1
    22dc:	e8 0f 17 00 00       	call   39f0 <printf>
    exit();
    22e1:	e8 6d 15 00 00       	call   3853 <exit>
    printf(1, "create dd/ff failed\n");
    22e6:	50                   	push   %eax
    22e7:	50                   	push   %eax
    22e8:	68 c7 44 00 00       	push   $0x44c7
    22ed:	6a 01                	push   $0x1
    22ef:	e8 fc 16 00 00       	call   39f0 <printf>
    exit();
    22f4:	e8 5a 15 00 00       	call   3853 <exit>
    printf(1, "subdir mkdir dd failed\n");
    22f9:	50                   	push   %eax
    22fa:	50                   	push   %eax
    22fb:	68 af 44 00 00       	push   $0x44af
    2300:	6a 01                	push   $0x1
    2302:	e8 e9 16 00 00       	call   39f0 <printf>
    exit();
    2307:	e8 47 15 00 00       	call   3853 <exit>
    printf(1, "unlink dd failed\n");
    230c:	50                   	push   %eax
    230d:	50                   	push   %eax
    230e:	68 98 47 00 00       	push   $0x4798
    2313:	6a 01                	push   $0x1
    2315:	e8 d6 16 00 00       	call   39f0 <printf>
    exit();
    231a:	e8 34 15 00 00       	call   3853 <exit>
    printf(1, "unlink dd/dd failed\n");
    231f:	52                   	push   %edx
    2320:	52                   	push   %edx
    2321:	68 83 47 00 00       	push   $0x4783
    2326:	6a 01                	push   $0x1
    2328:	e8 c3 16 00 00       	call   39f0 <printf>
    exit();
    232d:	e8 21 15 00 00       	call   3853 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2332:	51                   	push   %ecx
    2333:	51                   	push   %ecx
    2334:	68 74 50 00 00       	push   $0x5074
    2339:	6a 01                	push   $0x1
    233b:	e8 b0 16 00 00       	call   39f0 <printf>
    exit();
    2340:	e8 0e 15 00 00       	call   3853 <exit>
    printf(1, "unlink dd/ff failed\n");
    2345:	53                   	push   %ebx
    2346:	53                   	push   %ebx
    2347:	68 6e 47 00 00       	push   $0x476e
    234c:	6a 01                	push   $0x1
    234e:	e8 9d 16 00 00       	call   39f0 <printf>
    exit();
    2353:	e8 fb 14 00 00       	call   3853 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2358:	50                   	push   %eax
    2359:	50                   	push   %eax
    235a:	68 56 47 00 00       	push   $0x4756
    235f:	6a 01                	push   $0x1
    2361:	e8 8a 16 00 00       	call   39f0 <printf>
    exit();
    2366:	e8 e8 14 00 00       	call   3853 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    236b:	50                   	push   %eax
    236c:	50                   	push   %eax
    236d:	68 3e 47 00 00       	push   $0x473e
    2372:	6a 01                	push   $0x1
    2374:	e8 77 16 00 00       	call   39f0 <printf>
    exit();
    2379:	e8 d5 14 00 00       	call   3853 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    237e:	50                   	push   %eax
    237f:	50                   	push   %eax
    2380:	68 22 47 00 00       	push   $0x4722
    2385:	6a 01                	push   $0x1
    2387:	e8 64 16 00 00       	call   39f0 <printf>
    exit();
    238c:	e8 c2 14 00 00       	call   3853 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2391:	50                   	push   %eax
    2392:	50                   	push   %eax
    2393:	68 06 47 00 00       	push   $0x4706
    2398:	6a 01                	push   $0x1
    239a:	e8 51 16 00 00       	call   39f0 <printf>
    exit();
    239f:	e8 af 14 00 00       	call   3853 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    23a4:	50                   	push   %eax
    23a5:	50                   	push   %eax
    23a6:	68 e9 46 00 00       	push   $0x46e9
    23ab:	6a 01                	push   $0x1
    23ad:	e8 3e 16 00 00       	call   39f0 <printf>
    exit();
    23b2:	e8 9c 14 00 00       	call   3853 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    23b7:	52                   	push   %edx
    23b8:	52                   	push   %edx
    23b9:	68 ce 46 00 00       	push   $0x46ce
    23be:	6a 01                	push   $0x1
    23c0:	e8 2b 16 00 00       	call   39f0 <printf>
    exit();
    23c5:	e8 89 14 00 00       	call   3853 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    23ca:	51                   	push   %ecx
    23cb:	51                   	push   %ecx
    23cc:	68 fb 45 00 00       	push   $0x45fb
    23d1:	6a 01                	push   $0x1
    23d3:	e8 18 16 00 00       	call   39f0 <printf>
    exit();
    23d8:	e8 76 14 00 00       	call   3853 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    23dd:	53                   	push   %ebx
    23de:	53                   	push   %ebx
    23df:	68 e3 45 00 00       	push   $0x45e3
    23e4:	6a 01                	push   $0x1
    23e6:	e8 05 16 00 00       	call   39f0 <printf>
    exit();
    23eb:	e8 63 14 00 00       	call   3853 <exit>

000023f0 <bigwrite>:
{
    23f0:	55                   	push   %ebp
    23f1:	89 e5                	mov    %esp,%ebp
    23f3:	56                   	push   %esi
    23f4:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    23f5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    23fa:	83 ec 08             	sub    $0x8,%esp
    23fd:	68 b5 47 00 00       	push   $0x47b5
    2402:	6a 01                	push   $0x1
    2404:	e8 e7 15 00 00       	call   39f0 <printf>
  unlink("bigwrite");
    2409:	c7 04 24 c4 47 00 00 	movl   $0x47c4,(%esp)
    2410:	e8 8e 14 00 00       	call   38a3 <unlink>
    2415:	83 c4 10             	add    $0x10,%esp
    2418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    241f:	90                   	nop
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2420:	83 ec 08             	sub    $0x8,%esp
    2423:	68 02 02 00 00       	push   $0x202
    2428:	68 c4 47 00 00       	push   $0x47c4
    242d:	e8 61 14 00 00       	call   3893 <open>
    if(fd < 0){
    2432:	83 c4 10             	add    $0x10,%esp
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2435:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2437:	85 c0                	test   %eax,%eax
    2439:	78 7e                	js     24b9 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    243b:	83 ec 04             	sub    $0x4,%esp
    243e:	53                   	push   %ebx
    243f:	68 e0 84 00 00       	push   $0x84e0
    2444:	50                   	push   %eax
    2445:	e8 29 14 00 00       	call   3873 <write>
      if(cc != sz){
    244a:	83 c4 10             	add    $0x10,%esp
    244d:	39 d8                	cmp    %ebx,%eax
    244f:	75 55                	jne    24a6 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2451:	83 ec 04             	sub    $0x4,%esp
    2454:	53                   	push   %ebx
    2455:	68 e0 84 00 00       	push   $0x84e0
    245a:	56                   	push   %esi
    245b:	e8 13 14 00 00       	call   3873 <write>
      if(cc != sz){
    2460:	83 c4 10             	add    $0x10,%esp
    2463:	39 d8                	cmp    %ebx,%eax
    2465:	75 3f                	jne    24a6 <bigwrite+0xb6>
    close(fd);
    2467:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    246a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2470:	56                   	push   %esi
    2471:	e8 05 14 00 00       	call   387b <close>
    unlink("bigwrite");
    2476:	c7 04 24 c4 47 00 00 	movl   $0x47c4,(%esp)
    247d:	e8 21 14 00 00       	call   38a3 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2482:	83 c4 10             	add    $0x10,%esp
    2485:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    248b:	75 93                	jne    2420 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    248d:	83 ec 08             	sub    $0x8,%esp
    2490:	68 f7 47 00 00       	push   $0x47f7
    2495:	6a 01                	push   $0x1
    2497:	e8 54 15 00 00       	call   39f0 <printf>
}
    249c:	83 c4 10             	add    $0x10,%esp
    249f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24a2:	5b                   	pop    %ebx
    24a3:	5e                   	pop    %esi
    24a4:	5d                   	pop    %ebp
    24a5:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    24a6:	50                   	push   %eax
    24a7:	53                   	push   %ebx
    24a8:	68 e5 47 00 00       	push   $0x47e5
    24ad:	6a 01                	push   $0x1
    24af:	e8 3c 15 00 00       	call   39f0 <printf>
        exit();
    24b4:	e8 9a 13 00 00       	call   3853 <exit>
      printf(1, "cannot create bigwrite\n");
    24b9:	83 ec 08             	sub    $0x8,%esp
    24bc:	68 cd 47 00 00       	push   $0x47cd
    24c1:	6a 01                	push   $0x1
    24c3:	e8 28 15 00 00       	call   39f0 <printf>
      exit();
    24c8:	e8 86 13 00 00       	call   3853 <exit>
    24cd:	8d 76 00             	lea    0x0(%esi),%esi

000024d0 <bigfile>:
{
    24d0:	55                   	push   %ebp
    24d1:	89 e5                	mov    %esp,%ebp
    24d3:	57                   	push   %edi
    24d4:	56                   	push   %esi
    24d5:	53                   	push   %ebx
    24d6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    24d9:	68 04 48 00 00       	push   $0x4804
    24de:	6a 01                	push   $0x1
    24e0:	e8 0b 15 00 00       	call   39f0 <printf>
  unlink("bigfile");
    24e5:	c7 04 24 20 48 00 00 	movl   $0x4820,(%esp)
    24ec:	e8 b2 13 00 00       	call   38a3 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    24f1:	58                   	pop    %eax
    24f2:	5a                   	pop    %edx
    24f3:	68 02 02 00 00       	push   $0x202
    24f8:	68 20 48 00 00       	push   $0x4820
    24fd:	e8 91 13 00 00       	call   3893 <open>
  if(fd < 0){
    2502:	83 c4 10             	add    $0x10,%esp
    2505:	85 c0                	test   %eax,%eax
    2507:	0f 88 5e 01 00 00    	js     266b <bigfile+0x19b>
    250d:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    250f:	31 db                	xor    %ebx,%ebx
    2511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2518:	83 ec 04             	sub    $0x4,%esp
    251b:	68 58 02 00 00       	push   $0x258
    2520:	53                   	push   %ebx
    2521:	68 e0 84 00 00       	push   $0x84e0
    2526:	e8 85 11 00 00       	call   36b0 <memset>
    if(write(fd, buf, 600) != 600){
    252b:	83 c4 0c             	add    $0xc,%esp
    252e:	68 58 02 00 00       	push   $0x258
    2533:	68 e0 84 00 00       	push   $0x84e0
    2538:	56                   	push   %esi
    2539:	e8 35 13 00 00       	call   3873 <write>
    253e:	83 c4 10             	add    $0x10,%esp
    2541:	3d 58 02 00 00       	cmp    $0x258,%eax
    2546:	0f 85 f8 00 00 00    	jne    2644 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    254c:	83 c3 01             	add    $0x1,%ebx
    254f:	83 fb 14             	cmp    $0x14,%ebx
    2552:	75 c4                	jne    2518 <bigfile+0x48>
  close(fd);
    2554:	83 ec 0c             	sub    $0xc,%esp
    2557:	56                   	push   %esi
    2558:	e8 1e 13 00 00       	call   387b <close>
  fd = open("bigfile", 0);
    255d:	5e                   	pop    %esi
    255e:	5f                   	pop    %edi
    255f:	6a 00                	push   $0x0
    2561:	68 20 48 00 00       	push   $0x4820
    2566:	e8 28 13 00 00       	call   3893 <open>
  if(fd < 0){
    256b:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", 0);
    256e:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2570:	85 c0                	test   %eax,%eax
    2572:	0f 88 e0 00 00 00    	js     2658 <bigfile+0x188>
  total = 0;
    2578:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    257a:	31 ff                	xor    %edi,%edi
    257c:	eb 30                	jmp    25ae <bigfile+0xde>
    257e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2580:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2585:	0f 85 91 00 00 00    	jne    261c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    258b:	89 fa                	mov    %edi,%edx
    258d:	0f be 05 e0 84 00 00 	movsbl 0x84e0,%eax
    2594:	d1 fa                	sar    %edx
    2596:	39 d0                	cmp    %edx,%eax
    2598:	75 6e                	jne    2608 <bigfile+0x138>
    259a:	0f be 15 0b 86 00 00 	movsbl 0x860b,%edx
    25a1:	39 d0                	cmp    %edx,%eax
    25a3:	75 63                	jne    2608 <bigfile+0x138>
    total += cc;
    25a5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    25ab:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    25ae:	83 ec 04             	sub    $0x4,%esp
    25b1:	68 2c 01 00 00       	push   $0x12c
    25b6:	68 e0 84 00 00       	push   $0x84e0
    25bb:	56                   	push   %esi
    25bc:	e8 aa 12 00 00       	call   386b <read>
    if(cc < 0){
    25c1:	83 c4 10             	add    $0x10,%esp
    25c4:	85 c0                	test   %eax,%eax
    25c6:	78 68                	js     2630 <bigfile+0x160>
    if(cc == 0)
    25c8:	75 b6                	jne    2580 <bigfile+0xb0>
  close(fd);
    25ca:	83 ec 0c             	sub    $0xc,%esp
    25cd:	56                   	push   %esi
    25ce:	e8 a8 12 00 00       	call   387b <close>
  if(total != 20*600){
    25d3:	83 c4 10             	add    $0x10,%esp
    25d6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25dc:	0f 85 9c 00 00 00    	jne    267e <bigfile+0x1ae>
  unlink("bigfile");
    25e2:	83 ec 0c             	sub    $0xc,%esp
    25e5:	68 20 48 00 00       	push   $0x4820
    25ea:	e8 b4 12 00 00       	call   38a3 <unlink>
  printf(1, "bigfile test ok\n");
    25ef:	58                   	pop    %eax
    25f0:	5a                   	pop    %edx
    25f1:	68 af 48 00 00       	push   $0x48af
    25f6:	6a 01                	push   $0x1
    25f8:	e8 f3 13 00 00       	call   39f0 <printf>
}
    25fd:	83 c4 10             	add    $0x10,%esp
    2600:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2603:	5b                   	pop    %ebx
    2604:	5e                   	pop    %esi
    2605:	5f                   	pop    %edi
    2606:	5d                   	pop    %ebp
    2607:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2608:	83 ec 08             	sub    $0x8,%esp
    260b:	68 7c 48 00 00       	push   $0x487c
    2610:	6a 01                	push   $0x1
    2612:	e8 d9 13 00 00       	call   39f0 <printf>
      exit();
    2617:	e8 37 12 00 00       	call   3853 <exit>
      printf(1, "short read bigfile\n");
    261c:	83 ec 08             	sub    $0x8,%esp
    261f:	68 68 48 00 00       	push   $0x4868
    2624:	6a 01                	push   $0x1
    2626:	e8 c5 13 00 00       	call   39f0 <printf>
      exit();
    262b:	e8 23 12 00 00       	call   3853 <exit>
      printf(1, "read bigfile failed\n");
    2630:	83 ec 08             	sub    $0x8,%esp
    2633:	68 53 48 00 00       	push   $0x4853
    2638:	6a 01                	push   $0x1
    263a:	e8 b1 13 00 00       	call   39f0 <printf>
      exit();
    263f:	e8 0f 12 00 00       	call   3853 <exit>
      printf(1, "write bigfile failed\n");
    2644:	83 ec 08             	sub    $0x8,%esp
    2647:	68 28 48 00 00       	push   $0x4828
    264c:	6a 01                	push   $0x1
    264e:	e8 9d 13 00 00       	call   39f0 <printf>
      exit();
    2653:	e8 fb 11 00 00       	call   3853 <exit>
    printf(1, "cannot open bigfile\n");
    2658:	53                   	push   %ebx
    2659:	53                   	push   %ebx
    265a:	68 3e 48 00 00       	push   $0x483e
    265f:	6a 01                	push   $0x1
    2661:	e8 8a 13 00 00       	call   39f0 <printf>
    exit();
    2666:	e8 e8 11 00 00       	call   3853 <exit>
    printf(1, "cannot create bigfile");
    266b:	50                   	push   %eax
    266c:	50                   	push   %eax
    266d:	68 12 48 00 00       	push   $0x4812
    2672:	6a 01                	push   $0x1
    2674:	e8 77 13 00 00       	call   39f0 <printf>
    exit();
    2679:	e8 d5 11 00 00       	call   3853 <exit>
    printf(1, "read bigfile wrong total\n");
    267e:	51                   	push   %ecx
    267f:	51                   	push   %ecx
    2680:	68 95 48 00 00       	push   $0x4895
    2685:	6a 01                	push   $0x1
    2687:	e8 64 13 00 00       	call   39f0 <printf>
    exit();
    268c:	e8 c2 11 00 00       	call   3853 <exit>
    2691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    269f:	90                   	nop

000026a0 <fourteen>:
{
    26a0:	55                   	push   %ebp
    26a1:	89 e5                	mov    %esp,%ebp
    26a3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    26a6:	68 c0 48 00 00       	push   $0x48c0
    26ab:	6a 01                	push   $0x1
    26ad:	e8 3e 13 00 00       	call   39f0 <printf>
  if(mkdir("12345678901234") != 0){
    26b2:	c7 04 24 fb 48 00 00 	movl   $0x48fb,(%esp)
    26b9:	e8 fd 11 00 00       	call   38bb <mkdir>
    26be:	83 c4 10             	add    $0x10,%esp
    26c1:	85 c0                	test   %eax,%eax
    26c3:	0f 85 97 00 00 00    	jne    2760 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26c9:	83 ec 0c             	sub    $0xc,%esp
    26cc:	68 94 50 00 00       	push   $0x5094
    26d1:	e8 e5 11 00 00       	call   38bb <mkdir>
    26d6:	83 c4 10             	add    $0x10,%esp
    26d9:	85 c0                	test   %eax,%eax
    26db:	0f 85 de 00 00 00    	jne    27bf <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26e1:	83 ec 08             	sub    $0x8,%esp
    26e4:	68 00 02 00 00       	push   $0x200
    26e9:	68 e4 50 00 00       	push   $0x50e4
    26ee:	e8 a0 11 00 00       	call   3893 <open>
  if(fd < 0){
    26f3:	83 c4 10             	add    $0x10,%esp
    26f6:	85 c0                	test   %eax,%eax
    26f8:	0f 88 ae 00 00 00    	js     27ac <fourteen+0x10c>
  close(fd);
    26fe:	83 ec 0c             	sub    $0xc,%esp
    2701:	50                   	push   %eax
    2702:	e8 74 11 00 00       	call   387b <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2707:	58                   	pop    %eax
    2708:	5a                   	pop    %edx
    2709:	6a 00                	push   $0x0
    270b:	68 54 51 00 00       	push   $0x5154
    2710:	e8 7e 11 00 00       	call   3893 <open>
  if(fd < 0){
    2715:	83 c4 10             	add    $0x10,%esp
    2718:	85 c0                	test   %eax,%eax
    271a:	78 7d                	js     2799 <fourteen+0xf9>
  close(fd);
    271c:	83 ec 0c             	sub    $0xc,%esp
    271f:	50                   	push   %eax
    2720:	e8 56 11 00 00       	call   387b <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2725:	c7 04 24 ec 48 00 00 	movl   $0x48ec,(%esp)
    272c:	e8 8a 11 00 00       	call   38bb <mkdir>
    2731:	83 c4 10             	add    $0x10,%esp
    2734:	85 c0                	test   %eax,%eax
    2736:	74 4e                	je     2786 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2738:	83 ec 0c             	sub    $0xc,%esp
    273b:	68 f0 51 00 00       	push   $0x51f0
    2740:	e8 76 11 00 00       	call   38bb <mkdir>
    2745:	83 c4 10             	add    $0x10,%esp
    2748:	85 c0                	test   %eax,%eax
    274a:	74 27                	je     2773 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    274c:	83 ec 08             	sub    $0x8,%esp
    274f:	68 0a 49 00 00       	push   $0x490a
    2754:	6a 01                	push   $0x1
    2756:	e8 95 12 00 00       	call   39f0 <printf>
}
    275b:	83 c4 10             	add    $0x10,%esp
    275e:	c9                   	leave  
    275f:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2760:	50                   	push   %eax
    2761:	50                   	push   %eax
    2762:	68 cf 48 00 00       	push   $0x48cf
    2767:	6a 01                	push   $0x1
    2769:	e8 82 12 00 00       	call   39f0 <printf>
    exit();
    276e:	e8 e0 10 00 00       	call   3853 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2773:	50                   	push   %eax
    2774:	50                   	push   %eax
    2775:	68 10 52 00 00       	push   $0x5210
    277a:	6a 01                	push   $0x1
    277c:	e8 6f 12 00 00       	call   39f0 <printf>
    exit();
    2781:	e8 cd 10 00 00       	call   3853 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2786:	52                   	push   %edx
    2787:	52                   	push   %edx
    2788:	68 c0 51 00 00       	push   $0x51c0
    278d:	6a 01                	push   $0x1
    278f:	e8 5c 12 00 00       	call   39f0 <printf>
    exit();
    2794:	e8 ba 10 00 00       	call   3853 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2799:	51                   	push   %ecx
    279a:	51                   	push   %ecx
    279b:	68 84 51 00 00       	push   $0x5184
    27a0:	6a 01                	push   $0x1
    27a2:	e8 49 12 00 00       	call   39f0 <printf>
    exit();
    27a7:	e8 a7 10 00 00       	call   3853 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27ac:	51                   	push   %ecx
    27ad:	51                   	push   %ecx
    27ae:	68 14 51 00 00       	push   $0x5114
    27b3:	6a 01                	push   $0x1
    27b5:	e8 36 12 00 00       	call   39f0 <printf>
    exit();
    27ba:	e8 94 10 00 00       	call   3853 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27bf:	50                   	push   %eax
    27c0:	50                   	push   %eax
    27c1:	68 b4 50 00 00       	push   $0x50b4
    27c6:	6a 01                	push   $0x1
    27c8:	e8 23 12 00 00       	call   39f0 <printf>
    exit();
    27cd:	e8 81 10 00 00       	call   3853 <exit>
    27d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000027e0 <rmdot>:
{
    27e0:	55                   	push   %ebp
    27e1:	89 e5                	mov    %esp,%ebp
    27e3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    27e6:	68 17 49 00 00       	push   $0x4917
    27eb:	6a 01                	push   $0x1
    27ed:	e8 fe 11 00 00       	call   39f0 <printf>
  if(mkdir("dots") != 0){
    27f2:	c7 04 24 23 49 00 00 	movl   $0x4923,(%esp)
    27f9:	e8 bd 10 00 00       	call   38bb <mkdir>
    27fe:	83 c4 10             	add    $0x10,%esp
    2801:	85 c0                	test   %eax,%eax
    2803:	0f 85 b0 00 00 00    	jne    28b9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2809:	83 ec 0c             	sub    $0xc,%esp
    280c:	68 23 49 00 00       	push   $0x4923
    2811:	e8 ad 10 00 00       	call   38c3 <chdir>
    2816:	83 c4 10             	add    $0x10,%esp
    2819:	85 c0                	test   %eax,%eax
    281b:	0f 85 1d 01 00 00    	jne    293e <rmdot+0x15e>
  if(unlink(".") == 0){
    2821:	83 ec 0c             	sub    $0xc,%esp
    2824:	68 ce 45 00 00       	push   $0x45ce
    2829:	e8 75 10 00 00       	call   38a3 <unlink>
    282e:	83 c4 10             	add    $0x10,%esp
    2831:	85 c0                	test   %eax,%eax
    2833:	0f 84 f2 00 00 00    	je     292b <rmdot+0x14b>
  if(unlink("..") == 0){
    2839:	83 ec 0c             	sub    $0xc,%esp
    283c:	68 cd 45 00 00       	push   $0x45cd
    2841:	e8 5d 10 00 00       	call   38a3 <unlink>
    2846:	83 c4 10             	add    $0x10,%esp
    2849:	85 c0                	test   %eax,%eax
    284b:	0f 84 c7 00 00 00    	je     2918 <rmdot+0x138>
  if(chdir("/") != 0){
    2851:	83 ec 0c             	sub    $0xc,%esp
    2854:	68 a1 3d 00 00       	push   $0x3da1
    2859:	e8 65 10 00 00       	call   38c3 <chdir>
    285e:	83 c4 10             	add    $0x10,%esp
    2861:	85 c0                	test   %eax,%eax
    2863:	0f 85 9c 00 00 00    	jne    2905 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2869:	83 ec 0c             	sub    $0xc,%esp
    286c:	68 6b 49 00 00       	push   $0x496b
    2871:	e8 2d 10 00 00       	call   38a3 <unlink>
    2876:	83 c4 10             	add    $0x10,%esp
    2879:	85 c0                	test   %eax,%eax
    287b:	74 75                	je     28f2 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    287d:	83 ec 0c             	sub    $0xc,%esp
    2880:	68 89 49 00 00       	push   $0x4989
    2885:	e8 19 10 00 00       	call   38a3 <unlink>
    288a:	83 c4 10             	add    $0x10,%esp
    288d:	85 c0                	test   %eax,%eax
    288f:	74 4e                	je     28df <rmdot+0xff>
  if(unlink("dots") != 0){
    2891:	83 ec 0c             	sub    $0xc,%esp
    2894:	68 23 49 00 00       	push   $0x4923
    2899:	e8 05 10 00 00       	call   38a3 <unlink>
    289e:	83 c4 10             	add    $0x10,%esp
    28a1:	85 c0                	test   %eax,%eax
    28a3:	75 27                	jne    28cc <rmdot+0xec>
  printf(1, "rmdot ok\n");
    28a5:	83 ec 08             	sub    $0x8,%esp
    28a8:	68 be 49 00 00       	push   $0x49be
    28ad:	6a 01                	push   $0x1
    28af:	e8 3c 11 00 00       	call   39f0 <printf>
}
    28b4:	83 c4 10             	add    $0x10,%esp
    28b7:	c9                   	leave  
    28b8:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    28b9:	50                   	push   %eax
    28ba:	50                   	push   %eax
    28bb:	68 28 49 00 00       	push   $0x4928
    28c0:	6a 01                	push   $0x1
    28c2:	e8 29 11 00 00       	call   39f0 <printf>
    exit();
    28c7:	e8 87 0f 00 00       	call   3853 <exit>
    printf(1, "unlink dots failed!\n");
    28cc:	50                   	push   %eax
    28cd:	50                   	push   %eax
    28ce:	68 a9 49 00 00       	push   $0x49a9
    28d3:	6a 01                	push   $0x1
    28d5:	e8 16 11 00 00       	call   39f0 <printf>
    exit();
    28da:	e8 74 0f 00 00       	call   3853 <exit>
    printf(1, "unlink dots/.. worked!\n");
    28df:	52                   	push   %edx
    28e0:	52                   	push   %edx
    28e1:	68 91 49 00 00       	push   $0x4991
    28e6:	6a 01                	push   $0x1
    28e8:	e8 03 11 00 00       	call   39f0 <printf>
    exit();
    28ed:	e8 61 0f 00 00       	call   3853 <exit>
    printf(1, "unlink dots/. worked!\n");
    28f2:	51                   	push   %ecx
    28f3:	51                   	push   %ecx
    28f4:	68 72 49 00 00       	push   $0x4972
    28f9:	6a 01                	push   $0x1
    28fb:	e8 f0 10 00 00       	call   39f0 <printf>
    exit();
    2900:	e8 4e 0f 00 00       	call   3853 <exit>
    printf(1, "chdir / failed\n");
    2905:	50                   	push   %eax
    2906:	50                   	push   %eax
    2907:	68 a3 3d 00 00       	push   $0x3da3
    290c:	6a 01                	push   $0x1
    290e:	e8 dd 10 00 00       	call   39f0 <printf>
    exit();
    2913:	e8 3b 0f 00 00       	call   3853 <exit>
    printf(1, "rm .. worked!\n");
    2918:	50                   	push   %eax
    2919:	50                   	push   %eax
    291a:	68 5c 49 00 00       	push   $0x495c
    291f:	6a 01                	push   $0x1
    2921:	e8 ca 10 00 00       	call   39f0 <printf>
    exit();
    2926:	e8 28 0f 00 00       	call   3853 <exit>
    printf(1, "rm . worked!\n");
    292b:	50                   	push   %eax
    292c:	50                   	push   %eax
    292d:	68 4e 49 00 00       	push   $0x494e
    2932:	6a 01                	push   $0x1
    2934:	e8 b7 10 00 00       	call   39f0 <printf>
    exit();
    2939:	e8 15 0f 00 00       	call   3853 <exit>
    printf(1, "chdir dots failed\n");
    293e:	50                   	push   %eax
    293f:	50                   	push   %eax
    2940:	68 3b 49 00 00       	push   $0x493b
    2945:	6a 01                	push   $0x1
    2947:	e8 a4 10 00 00       	call   39f0 <printf>
    exit();
    294c:	e8 02 0f 00 00       	call   3853 <exit>
    2951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    295f:	90                   	nop

00002960 <dirfile>:
{
    2960:	55                   	push   %ebp
    2961:	89 e5                	mov    %esp,%ebp
    2963:	53                   	push   %ebx
    2964:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2967:	68 c8 49 00 00       	push   $0x49c8
    296c:	6a 01                	push   $0x1
    296e:	e8 7d 10 00 00       	call   39f0 <printf>
  fd = open("dirfile", O_CREATE);
    2973:	5b                   	pop    %ebx
    2974:	58                   	pop    %eax
    2975:	68 00 02 00 00       	push   $0x200
    297a:	68 d5 49 00 00       	push   $0x49d5
    297f:	e8 0f 0f 00 00       	call   3893 <open>
  if(fd < 0){
    2984:	83 c4 10             	add    $0x10,%esp
    2987:	85 c0                	test   %eax,%eax
    2989:	0f 88 43 01 00 00    	js     2ad2 <dirfile+0x172>
  close(fd);
    298f:	83 ec 0c             	sub    $0xc,%esp
    2992:	50                   	push   %eax
    2993:	e8 e3 0e 00 00       	call   387b <close>
  if(chdir("dirfile") == 0){
    2998:	c7 04 24 d5 49 00 00 	movl   $0x49d5,(%esp)
    299f:	e8 1f 0f 00 00       	call   38c3 <chdir>
    29a4:	83 c4 10             	add    $0x10,%esp
    29a7:	85 c0                	test   %eax,%eax
    29a9:	0f 84 10 01 00 00    	je     2abf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    29af:	83 ec 08             	sub    $0x8,%esp
    29b2:	6a 00                	push   $0x0
    29b4:	68 0e 4a 00 00       	push   $0x4a0e
    29b9:	e8 d5 0e 00 00       	call   3893 <open>
  if(fd >= 0){
    29be:	83 c4 10             	add    $0x10,%esp
    29c1:	85 c0                	test   %eax,%eax
    29c3:	0f 89 e3 00 00 00    	jns    2aac <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    29c9:	83 ec 08             	sub    $0x8,%esp
    29cc:	68 00 02 00 00       	push   $0x200
    29d1:	68 0e 4a 00 00       	push   $0x4a0e
    29d6:	e8 b8 0e 00 00       	call   3893 <open>
  if(fd >= 0){
    29db:	83 c4 10             	add    $0x10,%esp
    29de:	85 c0                	test   %eax,%eax
    29e0:	0f 89 c6 00 00 00    	jns    2aac <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    29e6:	83 ec 0c             	sub    $0xc,%esp
    29e9:	68 0e 4a 00 00       	push   $0x4a0e
    29ee:	e8 c8 0e 00 00       	call   38bb <mkdir>
    29f3:	83 c4 10             	add    $0x10,%esp
    29f6:	85 c0                	test   %eax,%eax
    29f8:	0f 84 46 01 00 00    	je     2b44 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    29fe:	83 ec 0c             	sub    $0xc,%esp
    2a01:	68 0e 4a 00 00       	push   $0x4a0e
    2a06:	e8 98 0e 00 00       	call   38a3 <unlink>
    2a0b:	83 c4 10             	add    $0x10,%esp
    2a0e:	85 c0                	test   %eax,%eax
    2a10:	0f 84 1b 01 00 00    	je     2b31 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a16:	83 ec 08             	sub    $0x8,%esp
    2a19:	68 0e 4a 00 00       	push   $0x4a0e
    2a1e:	68 72 4a 00 00       	push   $0x4a72
    2a23:	e8 8b 0e 00 00       	call   38b3 <link>
    2a28:	83 c4 10             	add    $0x10,%esp
    2a2b:	85 c0                	test   %eax,%eax
    2a2d:	0f 84 eb 00 00 00    	je     2b1e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a33:	83 ec 0c             	sub    $0xc,%esp
    2a36:	68 d5 49 00 00       	push   $0x49d5
    2a3b:	e8 63 0e 00 00       	call   38a3 <unlink>
    2a40:	83 c4 10             	add    $0x10,%esp
    2a43:	85 c0                	test   %eax,%eax
    2a45:	0f 85 c0 00 00 00    	jne    2b0b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a4b:	83 ec 08             	sub    $0x8,%esp
    2a4e:	6a 02                	push   $0x2
    2a50:	68 ce 45 00 00       	push   $0x45ce
    2a55:	e8 39 0e 00 00       	call   3893 <open>
  if(fd >= 0){
    2a5a:	83 c4 10             	add    $0x10,%esp
    2a5d:	85 c0                	test   %eax,%eax
    2a5f:	0f 89 93 00 00 00    	jns    2af8 <dirfile+0x198>
  fd = open(".", 0);
    2a65:	83 ec 08             	sub    $0x8,%esp
    2a68:	6a 00                	push   $0x0
    2a6a:	68 ce 45 00 00       	push   $0x45ce
    2a6f:	e8 1f 0e 00 00       	call   3893 <open>
  if(write(fd, "x", 1) > 0){
    2a74:	83 c4 0c             	add    $0xc,%esp
    2a77:	6a 01                	push   $0x1
  fd = open(".", 0);
    2a79:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a7b:	68 b1 46 00 00       	push   $0x46b1
    2a80:	50                   	push   %eax
    2a81:	e8 ed 0d 00 00       	call   3873 <write>
    2a86:	83 c4 10             	add    $0x10,%esp
    2a89:	85 c0                	test   %eax,%eax
    2a8b:	7f 58                	jg     2ae5 <dirfile+0x185>
  close(fd);
    2a8d:	83 ec 0c             	sub    $0xc,%esp
    2a90:	53                   	push   %ebx
    2a91:	e8 e5 0d 00 00       	call   387b <close>
  printf(1, "dir vs file OK\n");
    2a96:	58                   	pop    %eax
    2a97:	5a                   	pop    %edx
    2a98:	68 a5 4a 00 00       	push   $0x4aa5
    2a9d:	6a 01                	push   $0x1
    2a9f:	e8 4c 0f 00 00       	call   39f0 <printf>
}
    2aa4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2aa7:	83 c4 10             	add    $0x10,%esp
    2aaa:	c9                   	leave  
    2aab:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2aac:	50                   	push   %eax
    2aad:	50                   	push   %eax
    2aae:	68 19 4a 00 00       	push   $0x4a19
    2ab3:	6a 01                	push   $0x1
    2ab5:	e8 36 0f 00 00       	call   39f0 <printf>
    exit();
    2aba:	e8 94 0d 00 00       	call   3853 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2abf:	52                   	push   %edx
    2ac0:	52                   	push   %edx
    2ac1:	68 f4 49 00 00       	push   $0x49f4
    2ac6:	6a 01                	push   $0x1
    2ac8:	e8 23 0f 00 00       	call   39f0 <printf>
    exit();
    2acd:	e8 81 0d 00 00       	call   3853 <exit>
    printf(1, "create dirfile failed\n");
    2ad2:	51                   	push   %ecx
    2ad3:	51                   	push   %ecx
    2ad4:	68 dd 49 00 00       	push   $0x49dd
    2ad9:	6a 01                	push   $0x1
    2adb:	e8 10 0f 00 00       	call   39f0 <printf>
    exit();
    2ae0:	e8 6e 0d 00 00       	call   3853 <exit>
    printf(1, "write . succeeded!\n");
    2ae5:	51                   	push   %ecx
    2ae6:	51                   	push   %ecx
    2ae7:	68 91 4a 00 00       	push   $0x4a91
    2aec:	6a 01                	push   $0x1
    2aee:	e8 fd 0e 00 00       	call   39f0 <printf>
    exit();
    2af3:	e8 5b 0d 00 00       	call   3853 <exit>
    printf(1, "open . for writing succeeded!\n");
    2af8:	53                   	push   %ebx
    2af9:	53                   	push   %ebx
    2afa:	68 64 52 00 00       	push   $0x5264
    2aff:	6a 01                	push   $0x1
    2b01:	e8 ea 0e 00 00       	call   39f0 <printf>
    exit();
    2b06:	e8 48 0d 00 00       	call   3853 <exit>
    printf(1, "unlink dirfile failed!\n");
    2b0b:	50                   	push   %eax
    2b0c:	50                   	push   %eax
    2b0d:	68 79 4a 00 00       	push   $0x4a79
    2b12:	6a 01                	push   $0x1
    2b14:	e8 d7 0e 00 00       	call   39f0 <printf>
    exit();
    2b19:	e8 35 0d 00 00       	call   3853 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b1e:	50                   	push   %eax
    2b1f:	50                   	push   %eax
    2b20:	68 44 52 00 00       	push   $0x5244
    2b25:	6a 01                	push   $0x1
    2b27:	e8 c4 0e 00 00       	call   39f0 <printf>
    exit();
    2b2c:	e8 22 0d 00 00       	call   3853 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b31:	50                   	push   %eax
    2b32:	50                   	push   %eax
    2b33:	68 54 4a 00 00       	push   $0x4a54
    2b38:	6a 01                	push   $0x1
    2b3a:	e8 b1 0e 00 00       	call   39f0 <printf>
    exit();
    2b3f:	e8 0f 0d 00 00       	call   3853 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b44:	50                   	push   %eax
    2b45:	50                   	push   %eax
    2b46:	68 37 4a 00 00       	push   $0x4a37
    2b4b:	6a 01                	push   $0x1
    2b4d:	e8 9e 0e 00 00       	call   39f0 <printf>
    exit();
    2b52:	e8 fc 0c 00 00       	call   3853 <exit>
    2b57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2b5e:	66 90                	xchg   %ax,%ax

00002b60 <iref>:
{
    2b60:	55                   	push   %ebp
    2b61:	89 e5                	mov    %esp,%ebp
    2b63:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b64:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b69:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2b6c:	68 b5 4a 00 00       	push   $0x4ab5
    2b71:	6a 01                	push   $0x1
    2b73:	e8 78 0e 00 00       	call   39f0 <printf>
    2b78:	83 c4 10             	add    $0x10,%esp
    2b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b7f:	90                   	nop
    if(mkdir("irefd") != 0){
    2b80:	83 ec 0c             	sub    $0xc,%esp
    2b83:	68 c6 4a 00 00       	push   $0x4ac6
    2b88:	e8 2e 0d 00 00       	call   38bb <mkdir>
    2b8d:	83 c4 10             	add    $0x10,%esp
    2b90:	85 c0                	test   %eax,%eax
    2b92:	0f 85 bb 00 00 00    	jne    2c53 <iref+0xf3>
    if(chdir("irefd") != 0){
    2b98:	83 ec 0c             	sub    $0xc,%esp
    2b9b:	68 c6 4a 00 00       	push   $0x4ac6
    2ba0:	e8 1e 0d 00 00       	call   38c3 <chdir>
    2ba5:	83 c4 10             	add    $0x10,%esp
    2ba8:	85 c0                	test   %eax,%eax
    2baa:	0f 85 b7 00 00 00    	jne    2c67 <iref+0x107>
    mkdir("");
    2bb0:	83 ec 0c             	sub    $0xc,%esp
    2bb3:	68 7b 41 00 00       	push   $0x417b
    2bb8:	e8 fe 0c 00 00       	call   38bb <mkdir>
    link("README", "");
    2bbd:	59                   	pop    %ecx
    2bbe:	58                   	pop    %eax
    2bbf:	68 7b 41 00 00       	push   $0x417b
    2bc4:	68 72 4a 00 00       	push   $0x4a72
    2bc9:	e8 e5 0c 00 00       	call   38b3 <link>
    fd = open("", O_CREATE);
    2bce:	58                   	pop    %eax
    2bcf:	5a                   	pop    %edx
    2bd0:	68 00 02 00 00       	push   $0x200
    2bd5:	68 7b 41 00 00       	push   $0x417b
    2bda:	e8 b4 0c 00 00       	call   3893 <open>
    if(fd >= 0)
    2bdf:	83 c4 10             	add    $0x10,%esp
    2be2:	85 c0                	test   %eax,%eax
    2be4:	78 0c                	js     2bf2 <iref+0x92>
      close(fd);
    2be6:	83 ec 0c             	sub    $0xc,%esp
    2be9:	50                   	push   %eax
    2bea:	e8 8c 0c 00 00       	call   387b <close>
    2bef:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2bf2:	83 ec 08             	sub    $0x8,%esp
    2bf5:	68 00 02 00 00       	push   $0x200
    2bfa:	68 b0 46 00 00       	push   $0x46b0
    2bff:	e8 8f 0c 00 00       	call   3893 <open>
    if(fd >= 0)
    2c04:	83 c4 10             	add    $0x10,%esp
    2c07:	85 c0                	test   %eax,%eax
    2c09:	78 0c                	js     2c17 <iref+0xb7>
      close(fd);
    2c0b:	83 ec 0c             	sub    $0xc,%esp
    2c0e:	50                   	push   %eax
    2c0f:	e8 67 0c 00 00       	call   387b <close>
    2c14:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c17:	83 ec 0c             	sub    $0xc,%esp
    2c1a:	68 b0 46 00 00       	push   $0x46b0
    2c1f:	e8 7f 0c 00 00       	call   38a3 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2c24:	83 c4 10             	add    $0x10,%esp
    2c27:	83 eb 01             	sub    $0x1,%ebx
    2c2a:	0f 85 50 ff ff ff    	jne    2b80 <iref+0x20>
  chdir("/");
    2c30:	83 ec 0c             	sub    $0xc,%esp
    2c33:	68 a1 3d 00 00       	push   $0x3da1
    2c38:	e8 86 0c 00 00       	call   38c3 <chdir>
  printf(1, "empty file name OK\n");
    2c3d:	58                   	pop    %eax
    2c3e:	5a                   	pop    %edx
    2c3f:	68 f4 4a 00 00       	push   $0x4af4
    2c44:	6a 01                	push   $0x1
    2c46:	e8 a5 0d 00 00       	call   39f0 <printf>
}
    2c4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c4e:	83 c4 10             	add    $0x10,%esp
    2c51:	c9                   	leave  
    2c52:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2c53:	83 ec 08             	sub    $0x8,%esp
    2c56:	68 cc 4a 00 00       	push   $0x4acc
    2c5b:	6a 01                	push   $0x1
    2c5d:	e8 8e 0d 00 00       	call   39f0 <printf>
      exit();
    2c62:	e8 ec 0b 00 00       	call   3853 <exit>
      printf(1, "chdir irefd failed\n");
    2c67:	83 ec 08             	sub    $0x8,%esp
    2c6a:	68 e0 4a 00 00       	push   $0x4ae0
    2c6f:	6a 01                	push   $0x1
    2c71:	e8 7a 0d 00 00       	call   39f0 <printf>
      exit();
    2c76:	e8 d8 0b 00 00       	call   3853 <exit>
    2c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2c7f:	90                   	nop

00002c80 <forktest>:
{
    2c80:	55                   	push   %ebp
    2c81:	89 e5                	mov    %esp,%ebp
    2c83:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2c84:	31 db                	xor    %ebx,%ebx
{
    2c86:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2c89:	68 08 4b 00 00       	push   $0x4b08
    2c8e:	6a 01                	push   $0x1
    2c90:	e8 5b 0d 00 00       	call   39f0 <printf>
    2c95:	83 c4 10             	add    $0x10,%esp
    2c98:	eb 13                	jmp    2cad <forktest+0x2d>
    2c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    2ca0:	74 4a                	je     2cec <forktest+0x6c>
  for(n=0; n<1000; n++){
    2ca2:	83 c3 01             	add    $0x1,%ebx
    2ca5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2cab:	74 6b                	je     2d18 <forktest+0x98>
    pid = fork();
    2cad:	e8 99 0b 00 00       	call   384b <fork>
    if(pid < 0)
    2cb2:	85 c0                	test   %eax,%eax
    2cb4:	79 ea                	jns    2ca0 <forktest+0x20>
  for(; n > 0; n--){
    2cb6:	85 db                	test   %ebx,%ebx
    2cb8:	74 14                	je     2cce <forktest+0x4e>
    2cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2cc0:	e8 96 0b 00 00       	call   385b <wait>
    2cc5:	85 c0                	test   %eax,%eax
    2cc7:	78 28                	js     2cf1 <forktest+0x71>
  for(; n > 0; n--){
    2cc9:	83 eb 01             	sub    $0x1,%ebx
    2ccc:	75 f2                	jne    2cc0 <forktest+0x40>
  if(wait() != -1){
    2cce:	e8 88 0b 00 00       	call   385b <wait>
    2cd3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cd6:	75 2d                	jne    2d05 <forktest+0x85>
  printf(1, "fork test OK\n");
    2cd8:	83 ec 08             	sub    $0x8,%esp
    2cdb:	68 3a 4b 00 00       	push   $0x4b3a
    2ce0:	6a 01                	push   $0x1
    2ce2:	e8 09 0d 00 00       	call   39f0 <printf>
}
    2ce7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cea:	c9                   	leave  
    2ceb:	c3                   	ret    
      exit();
    2cec:	e8 62 0b 00 00       	call   3853 <exit>
      printf(1, "wait stopped early\n");
    2cf1:	83 ec 08             	sub    $0x8,%esp
    2cf4:	68 13 4b 00 00       	push   $0x4b13
    2cf9:	6a 01                	push   $0x1
    2cfb:	e8 f0 0c 00 00       	call   39f0 <printf>
      exit();
    2d00:	e8 4e 0b 00 00       	call   3853 <exit>
    printf(1, "wait got too many\n");
    2d05:	52                   	push   %edx
    2d06:	52                   	push   %edx
    2d07:	68 27 4b 00 00       	push   $0x4b27
    2d0c:	6a 01                	push   $0x1
    2d0e:	e8 dd 0c 00 00       	call   39f0 <printf>
    exit();
    2d13:	e8 3b 0b 00 00       	call   3853 <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    2d18:	50                   	push   %eax
    2d19:	50                   	push   %eax
    2d1a:	68 84 52 00 00       	push   $0x5284
    2d1f:	6a 01                	push   $0x1
    2d21:	e8 ca 0c 00 00       	call   39f0 <printf>
    exit();
    2d26:	e8 28 0b 00 00       	call   3853 <exit>
    2d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d2f:	90                   	nop

00002d30 <sbrktest>:
{
    2d30:	55                   	push   %ebp
    2d31:	89 e5                	mov    %esp,%ebp
    2d33:	57                   	push   %edi
    2d34:	56                   	push   %esi
  for(i = 0; i < 5000; i++){
    2d35:	31 f6                	xor    %esi,%esi
{
    2d37:	53                   	push   %ebx
    2d38:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2d3b:	68 48 4b 00 00       	push   $0x4b48
    2d40:	ff 35 a0 5d 00 00    	pushl  0x5da0
    2d46:	e8 a5 0c 00 00       	call   39f0 <printf>
  oldbrk = sbrk(0);
    2d4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d52:	e8 84 0b 00 00       	call   38db <sbrk>
  a = sbrk(0);
    2d57:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    2d5e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  a = sbrk(0);
    2d61:	e8 75 0b 00 00       	call   38db <sbrk>
    2d66:	83 c4 10             	add    $0x10,%esp
    2d69:	89 c3                	mov    %eax,%ebx
  for(i = 0; i < 5000; i++){
    2d6b:	eb 05                	jmp    2d72 <sbrktest+0x42>
    2d6d:	8d 76 00             	lea    0x0(%esi),%esi
    a = b + 1;
    2d70:	89 c3                	mov    %eax,%ebx
    b = sbrk(1);
    2d72:	83 ec 0c             	sub    $0xc,%esp
    2d75:	6a 01                	push   $0x1
    2d77:	e8 5f 0b 00 00       	call   38db <sbrk>
    if(b != a){
    2d7c:	83 c4 10             	add    $0x10,%esp
    2d7f:	39 d8                	cmp    %ebx,%eax
    2d81:	0f 85 9c 02 00 00    	jne    3023 <sbrktest+0x2f3>
  for(i = 0; i < 5000; i++){
    2d87:	83 c6 01             	add    $0x1,%esi
    *b = 1;
    2d8a:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2d8d:	8d 43 01             	lea    0x1(%ebx),%eax
  for(i = 0; i < 5000; i++){
    2d90:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2d96:	75 d8                	jne    2d70 <sbrktest+0x40>
  pid = fork();
    2d98:	e8 ae 0a 00 00       	call   384b <fork>
    2d9d:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    2d9f:	85 c0                	test   %eax,%eax
    2da1:	0f 88 02 03 00 00    	js     30a9 <sbrktest+0x379>
  c = sbrk(1);
    2da7:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2daa:	83 c3 02             	add    $0x2,%ebx
  c = sbrk(1);
    2dad:	6a 01                	push   $0x1
    2daf:	e8 27 0b 00 00       	call   38db <sbrk>
  c = sbrk(1);
    2db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dbb:	e8 1b 0b 00 00       	call   38db <sbrk>
  if(c != a + 1){
    2dc0:	83 c4 10             	add    $0x10,%esp
    2dc3:	39 c3                	cmp    %eax,%ebx
    2dc5:	0f 85 3b 03 00 00    	jne    3106 <sbrktest+0x3d6>
  if(pid == 0)
    2dcb:	85 f6                	test   %esi,%esi
    2dcd:	0f 84 2e 03 00 00    	je     3101 <sbrktest+0x3d1>
  wait();
    2dd3:	e8 83 0a 00 00       	call   385b <wait>
  a = sbrk(0);
    2dd8:	83 ec 0c             	sub    $0xc,%esp
    2ddb:	6a 00                	push   $0x0
    2ddd:	e8 f9 0a 00 00       	call   38db <sbrk>
    2de2:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2de4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2de9:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2deb:	89 04 24             	mov    %eax,(%esp)
    2dee:	e8 e8 0a 00 00       	call   38db <sbrk>
  if (p != a) {
    2df3:	83 c4 10             	add    $0x10,%esp
    2df6:	39 c3                	cmp    %eax,%ebx
    2df8:	0f 85 94 02 00 00    	jne    3092 <sbrktest+0x362>
  a = sbrk(0);
    2dfe:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    2e01:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2e08:	6a 00                	push   $0x0
    2e0a:	e8 cc 0a 00 00       	call   38db <sbrk>
  c = sbrk(-4096);
    2e0f:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2e16:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2e18:	e8 be 0a 00 00       	call   38db <sbrk>
  if(c == (char*)0xffffffff){
    2e1d:	83 c4 10             	add    $0x10,%esp
    2e20:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e23:	0f 84 22 03 00 00    	je     314b <sbrktest+0x41b>
  c = sbrk(0);
    2e29:	83 ec 0c             	sub    $0xc,%esp
    2e2c:	6a 00                	push   $0x0
    2e2e:	e8 a8 0a 00 00       	call   38db <sbrk>
  if(c != a - 4096){
    2e33:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2e39:	83 c4 10             	add    $0x10,%esp
    2e3c:	39 d0                	cmp    %edx,%eax
    2e3e:	0f 85 f0 02 00 00    	jne    3134 <sbrktest+0x404>
  a = sbrk(0);
    2e44:	83 ec 0c             	sub    $0xc,%esp
    2e47:	6a 00                	push   $0x0
    2e49:	e8 8d 0a 00 00       	call   38db <sbrk>
  c = sbrk(4096);
    2e4e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    2e55:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2e57:	e8 7f 0a 00 00       	call   38db <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e5c:	83 c4 10             	add    $0x10,%esp
  c = sbrk(4096);
    2e5f:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2e61:	39 c3                	cmp    %eax,%ebx
    2e63:	0f 85 b4 02 00 00    	jne    311d <sbrktest+0x3ed>
    2e69:	83 ec 0c             	sub    $0xc,%esp
    2e6c:	6a 00                	push   $0x0
    2e6e:	e8 68 0a 00 00       	call   38db <sbrk>
    2e73:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2e79:	83 c4 10             	add    $0x10,%esp
    2e7c:	39 c2                	cmp    %eax,%edx
    2e7e:	0f 85 99 02 00 00    	jne    311d <sbrktest+0x3ed>
  if(*lastaddr == 99){
    2e84:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e8b:	0f 84 2f 02 00 00    	je     30c0 <sbrktest+0x390>
  a = sbrk(0);
    2e91:	83 ec 0c             	sub    $0xc,%esp
    2e94:	6a 00                	push   $0x0
    2e96:	e8 40 0a 00 00       	call   38db <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2e9b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2ea2:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2ea4:	e8 32 0a 00 00       	call   38db <sbrk>
    2ea9:	89 c2                	mov    %eax,%edx
    2eab:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    2eae:	29 d0                	sub    %edx,%eax
    2eb0:	89 04 24             	mov    %eax,(%esp)
    2eb3:	e8 23 0a 00 00       	call   38db <sbrk>
  if(c != a){
    2eb8:	83 c4 10             	add    $0x10,%esp
    2ebb:	39 c3                	cmp    %eax,%ebx
    2ebd:	0f 85 b8 01 00 00    	jne    307b <sbrktest+0x34b>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ec3:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2ec8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2ecf:	90                   	nop
    ppid = getpid();
    2ed0:	e8 fe 09 00 00       	call   38d3 <getpid>
    2ed5:	89 c6                	mov    %eax,%esi
    pid = fork();
    2ed7:	e8 6f 09 00 00       	call   384b <fork>
    if(pid < 0){
    2edc:	85 c0                	test   %eax,%eax
    2ede:	0f 88 5d 01 00 00    	js     3041 <sbrktest+0x311>
    if(pid == 0){
    2ee4:	0f 84 6f 01 00 00    	je     3059 <sbrktest+0x329>
    wait();
    2eea:	e8 6c 09 00 00       	call   385b <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eef:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2ef5:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2efb:	75 d3                	jne    2ed0 <sbrktest+0x1a0>
  if(pipe(fds) != 0){
    2efd:	83 ec 0c             	sub    $0xc,%esp
    2f00:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f03:	50                   	push   %eax
    2f04:	e8 5a 09 00 00       	call   3863 <pipe>
    2f09:	83 c4 10             	add    $0x10,%esp
    2f0c:	85 c0                	test   %eax,%eax
    2f0e:	0f 85 da 01 00 00    	jne    30ee <sbrktest+0x3be>
    2f14:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2f17:	8d 75 e8             	lea    -0x18(%ebp),%esi
    2f1a:	89 df                	mov    %ebx,%edi
    2f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((pids[i] = fork()) == 0){
    2f20:	e8 26 09 00 00       	call   384b <fork>
    2f25:	89 07                	mov    %eax,(%edi)
    2f27:	85 c0                	test   %eax,%eax
    2f29:	0f 84 91 00 00 00    	je     2fc0 <sbrktest+0x290>
    if(pids[i] != -1)
    2f2f:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f32:	74 14                	je     2f48 <sbrktest+0x218>
      read(fds[0], &scratch, 1);
    2f34:	83 ec 04             	sub    $0x4,%esp
    2f37:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f3a:	6a 01                	push   $0x1
    2f3c:	50                   	push   %eax
    2f3d:	ff 75 b8             	pushl  -0x48(%ebp)
    2f40:	e8 26 09 00 00       	call   386b <read>
    2f45:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f48:	83 c7 04             	add    $0x4,%edi
    2f4b:	39 f7                	cmp    %esi,%edi
    2f4d:	75 d1                	jne    2f20 <sbrktest+0x1f0>
  c = sbrk(4096);
    2f4f:	83 ec 0c             	sub    $0xc,%esp
    2f52:	68 00 10 00 00       	push   $0x1000
    2f57:	e8 7f 09 00 00       	call   38db <sbrk>
    2f5c:	83 c4 10             	add    $0x10,%esp
    2f5f:	89 c7                	mov    %eax,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pids[i] == -1)
    2f68:	8b 03                	mov    (%ebx),%eax
    2f6a:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f6d:	74 11                	je     2f80 <sbrktest+0x250>
    kill(pids[i]);
    2f6f:	83 ec 0c             	sub    $0xc,%esp
    2f72:	50                   	push   %eax
    2f73:	e8 0b 09 00 00       	call   3883 <kill>
    wait();
    2f78:	e8 de 08 00 00       	call   385b <wait>
    2f7d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f80:	83 c3 04             	add    $0x4,%ebx
    2f83:	39 de                	cmp    %ebx,%esi
    2f85:	75 e1                	jne    2f68 <sbrktest+0x238>
  if(c == (char*)0xffffffff){
    2f87:	83 ff ff             	cmp    $0xffffffff,%edi
    2f8a:	0f 84 47 01 00 00    	je     30d7 <sbrktest+0x3a7>
  if(sbrk(0) > oldbrk)
    2f90:	83 ec 0c             	sub    $0xc,%esp
    2f93:	6a 00                	push   $0x0
    2f95:	e8 41 09 00 00       	call   38db <sbrk>
    2f9a:	83 c4 10             	add    $0x10,%esp
    2f9d:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2fa0:	72 60                	jb     3002 <sbrktest+0x2d2>
  printf(stdout, "sbrk test OK\n");
    2fa2:	83 ec 08             	sub    $0x8,%esp
    2fa5:	68 f0 4b 00 00       	push   $0x4bf0
    2faa:	ff 35 a0 5d 00 00    	pushl  0x5da0
    2fb0:	e8 3b 0a 00 00       	call   39f0 <printf>
}
    2fb5:	83 c4 10             	add    $0x10,%esp
    2fb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fbb:	5b                   	pop    %ebx
    2fbc:	5e                   	pop    %esi
    2fbd:	5f                   	pop    %edi
    2fbe:	5d                   	pop    %ebp
    2fbf:	c3                   	ret    
      sbrk(BIG - (uint)sbrk(0));
    2fc0:	83 ec 0c             	sub    $0xc,%esp
    2fc3:	6a 00                	push   $0x0
    2fc5:	e8 11 09 00 00       	call   38db <sbrk>
    2fca:	89 c2                	mov    %eax,%edx
    2fcc:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2fd1:	29 d0                	sub    %edx,%eax
    2fd3:	89 04 24             	mov    %eax,(%esp)
    2fd6:	e8 00 09 00 00       	call   38db <sbrk>
      write(fds[1], "x", 1);
    2fdb:	83 c4 0c             	add    $0xc,%esp
    2fde:	6a 01                	push   $0x1
    2fe0:	68 b1 46 00 00       	push   $0x46b1
    2fe5:	ff 75 bc             	pushl  -0x44(%ebp)
    2fe8:	e8 86 08 00 00       	call   3873 <write>
    2fed:	83 c4 10             	add    $0x10,%esp
      for(;;) sleep(1000);
    2ff0:	83 ec 0c             	sub    $0xc,%esp
    2ff3:	68 e8 03 00 00       	push   $0x3e8
    2ff8:	e8 e6 08 00 00       	call   38e3 <sleep>
    2ffd:	83 c4 10             	add    $0x10,%esp
    3000:	eb ee                	jmp    2ff0 <sbrktest+0x2c0>
    sbrk(-(sbrk(0) - oldbrk));
    3002:	83 ec 0c             	sub    $0xc,%esp
    3005:	6a 00                	push   $0x0
    3007:	e8 cf 08 00 00       	call   38db <sbrk>
    300c:	89 c2                	mov    %eax,%edx
    300e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3011:	29 d0                	sub    %edx,%eax
    3013:	89 04 24             	mov    %eax,(%esp)
    3016:	e8 c0 08 00 00       	call   38db <sbrk>
    301b:	83 c4 10             	add    $0x10,%esp
    301e:	e9 7f ff ff ff       	jmp    2fa2 <sbrktest+0x272>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3023:	83 ec 0c             	sub    $0xc,%esp
    3026:	50                   	push   %eax
    3027:	53                   	push   %ebx
    3028:	56                   	push   %esi
    3029:	68 53 4b 00 00       	push   $0x4b53
    302e:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3034:	e8 b7 09 00 00       	call   39f0 <printf>
      exit();
    3039:	83 c4 20             	add    $0x20,%esp
    303c:	e8 12 08 00 00       	call   3853 <exit>
      printf(stdout, "fork failed\n");
    3041:	83 ec 08             	sub    $0x8,%esp
    3044:	68 99 4c 00 00       	push   $0x4c99
    3049:	ff 35 a0 5d 00 00    	pushl  0x5da0
    304f:	e8 9c 09 00 00       	call   39f0 <printf>
      exit();
    3054:	e8 fa 07 00 00       	call   3853 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3059:	0f be 03             	movsbl (%ebx),%eax
    305c:	50                   	push   %eax
    305d:	53                   	push   %ebx
    305e:	68 bc 4b 00 00       	push   $0x4bbc
    3063:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3069:	e8 82 09 00 00       	call   39f0 <printf>
      kill(ppid);
    306e:	89 34 24             	mov    %esi,(%esp)
    3071:	e8 0d 08 00 00       	call   3883 <kill>
      exit();
    3076:	e8 d8 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    307b:	50                   	push   %eax
    307c:	53                   	push   %ebx
    307d:	68 78 53 00 00       	push   $0x5378
    3082:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3088:	e8 63 09 00 00       	call   39f0 <printf>
    exit();
    308d:	e8 c1 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3092:	56                   	push   %esi
    3093:	56                   	push   %esi
    3094:	68 a8 52 00 00       	push   $0x52a8
    3099:	ff 35 a0 5d 00 00    	pushl  0x5da0
    309f:	e8 4c 09 00 00       	call   39f0 <printf>
    exit();
    30a4:	e8 aa 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk test fork failed\n");
    30a9:	50                   	push   %eax
    30aa:	50                   	push   %eax
    30ab:	68 6e 4b 00 00       	push   $0x4b6e
    30b0:	ff 35 a0 5d 00 00    	pushl  0x5da0
    30b6:	e8 35 09 00 00       	call   39f0 <printf>
    exit();
    30bb:	e8 93 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    30c0:	51                   	push   %ecx
    30c1:	51                   	push   %ecx
    30c2:	68 48 53 00 00       	push   $0x5348
    30c7:	ff 35 a0 5d 00 00    	pushl  0x5da0
    30cd:	e8 1e 09 00 00       	call   39f0 <printf>
    exit();
    30d2:	e8 7c 07 00 00       	call   3853 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    30d7:	50                   	push   %eax
    30d8:	50                   	push   %eax
    30d9:	68 d5 4b 00 00       	push   $0x4bd5
    30de:	ff 35 a0 5d 00 00    	pushl  0x5da0
    30e4:	e8 07 09 00 00       	call   39f0 <printf>
    exit();
    30e9:	e8 65 07 00 00       	call   3853 <exit>
    printf(1, "pipe() failed\n");
    30ee:	52                   	push   %edx
    30ef:	52                   	push   %edx
    30f0:	68 91 40 00 00       	push   $0x4091
    30f5:	6a 01                	push   $0x1
    30f7:	e8 f4 08 00 00       	call   39f0 <printf>
    exit();
    30fc:	e8 52 07 00 00       	call   3853 <exit>
    exit();
    3101:	e8 4d 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3106:	57                   	push   %edi
    3107:	57                   	push   %edi
    3108:	68 85 4b 00 00       	push   $0x4b85
    310d:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3113:	e8 d8 08 00 00       	call   39f0 <printf>
    exit();
    3118:	e8 36 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    311d:	56                   	push   %esi
    311e:	53                   	push   %ebx
    311f:	68 20 53 00 00       	push   $0x5320
    3124:	ff 35 a0 5d 00 00    	pushl  0x5da0
    312a:	e8 c1 08 00 00       	call   39f0 <printf>
    exit();
    312f:	e8 1f 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3134:	50                   	push   %eax
    3135:	53                   	push   %ebx
    3136:	68 e8 52 00 00       	push   $0x52e8
    313b:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3141:	e8 aa 08 00 00       	call   39f0 <printf>
    exit();
    3146:	e8 08 07 00 00       	call   3853 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    314b:	53                   	push   %ebx
    314c:	53                   	push   %ebx
    314d:	68 a1 4b 00 00       	push   $0x4ba1
    3152:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3158:	e8 93 08 00 00       	call   39f0 <printf>
    exit();
    315d:	e8 f1 06 00 00       	call   3853 <exit>
    3162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003170 <validateint>:
}
    3170:	c3                   	ret    
    3171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3178:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    317f:	90                   	nop

00003180 <validatetest>:
{
    3180:	55                   	push   %ebp
    3181:	89 e5                	mov    %esp,%ebp
    3183:	56                   	push   %esi
  for(p = 0; p <= (uint)hi; p += 4096){
    3184:	31 f6                	xor    %esi,%esi
{
    3186:	53                   	push   %ebx
  printf(stdout, "validate test\n");
    3187:	83 ec 08             	sub    $0x8,%esp
    318a:	68 fe 4b 00 00       	push   $0x4bfe
    318f:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3195:	e8 56 08 00 00       	call   39f0 <printf>
    319a:	83 c4 10             	add    $0x10,%esp
    319d:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    31a0:	e8 a6 06 00 00       	call   384b <fork>
    31a5:	89 c3                	mov    %eax,%ebx
    31a7:	85 c0                	test   %eax,%eax
    31a9:	74 63                	je     320e <validatetest+0x8e>
    sleep(0);
    31ab:	83 ec 0c             	sub    $0xc,%esp
    31ae:	6a 00                	push   $0x0
    31b0:	e8 2e 07 00 00       	call   38e3 <sleep>
    sleep(0);
    31b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31bc:	e8 22 07 00 00       	call   38e3 <sleep>
    kill(pid);
    31c1:	89 1c 24             	mov    %ebx,(%esp)
    31c4:	e8 ba 06 00 00       	call   3883 <kill>
    wait();
    31c9:	e8 8d 06 00 00       	call   385b <wait>
    if(link("nosuchfile", (char*)p) != -1){
    31ce:	58                   	pop    %eax
    31cf:	5a                   	pop    %edx
    31d0:	56                   	push   %esi
    31d1:	68 0d 4c 00 00       	push   $0x4c0d
    31d6:	e8 d8 06 00 00       	call   38b3 <link>
    31db:	83 c4 10             	add    $0x10,%esp
    31de:	83 f8 ff             	cmp    $0xffffffff,%eax
    31e1:	75 30                	jne    3213 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    31e3:	81 c6 00 10 00 00    	add    $0x1000,%esi
    31e9:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    31ef:	75 af                	jne    31a0 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    31f1:	83 ec 08             	sub    $0x8,%esp
    31f4:	68 31 4c 00 00       	push   $0x4c31
    31f9:	ff 35 a0 5d 00 00    	pushl  0x5da0
    31ff:	e8 ec 07 00 00       	call   39f0 <printf>
}
    3204:	83 c4 10             	add    $0x10,%esp
    3207:	8d 65 f8             	lea    -0x8(%ebp),%esp
    320a:	5b                   	pop    %ebx
    320b:	5e                   	pop    %esi
    320c:	5d                   	pop    %ebp
    320d:	c3                   	ret    
      exit();
    320e:	e8 40 06 00 00       	call   3853 <exit>
      printf(stdout, "link should not succeed\n");
    3213:	83 ec 08             	sub    $0x8,%esp
    3216:	68 18 4c 00 00       	push   $0x4c18
    321b:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3221:	e8 ca 07 00 00       	call   39f0 <printf>
      exit();
    3226:	e8 28 06 00 00       	call   3853 <exit>
    322b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    322f:	90                   	nop

00003230 <bsstest>:
{
    3230:	55                   	push   %ebp
    3231:	89 e5                	mov    %esp,%ebp
    3233:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    3236:	68 3e 4c 00 00       	push   $0x4c3e
    323b:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3241:	e8 aa 07 00 00       	call   39f0 <printf>
    3246:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3249:	31 c0                	xor    %eax,%eax
    324b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    324f:	90                   	nop
    if(uninit[i] != '\0'){
    3250:	80 b8 c0 5d 00 00 00 	cmpb   $0x0,0x5dc0(%eax)
    3257:	75 22                	jne    327b <bsstest+0x4b>
  for(i = 0; i < sizeof(uninit); i++){
    3259:	83 c0 01             	add    $0x1,%eax
    325c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3261:	75 ed                	jne    3250 <bsstest+0x20>
  printf(stdout, "bss test ok\n");
    3263:	83 ec 08             	sub    $0x8,%esp
    3266:	68 59 4c 00 00       	push   $0x4c59
    326b:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3271:	e8 7a 07 00 00       	call   39f0 <printf>
}
    3276:	83 c4 10             	add    $0x10,%esp
    3279:	c9                   	leave  
    327a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    327b:	83 ec 08             	sub    $0x8,%esp
    327e:	68 48 4c 00 00       	push   $0x4c48
    3283:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3289:	e8 62 07 00 00       	call   39f0 <printf>
      exit();
    328e:	e8 c0 05 00 00       	call   3853 <exit>
    3293:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    329a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000032a0 <bigargtest>:
{
    32a0:	55                   	push   %ebp
    32a1:	89 e5                	mov    %esp,%ebp
    32a3:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    32a6:	68 66 4c 00 00       	push   $0x4c66
    32ab:	e8 f3 05 00 00       	call   38a3 <unlink>
  pid = fork();
    32b0:	e8 96 05 00 00       	call   384b <fork>
  if(pid == 0){
    32b5:	83 c4 10             	add    $0x10,%esp
    32b8:	85 c0                	test   %eax,%eax
    32ba:	74 44                	je     3300 <bigargtest+0x60>
  } else if(pid < 0){
    32bc:	0f 88 c5 00 00 00    	js     3387 <bigargtest+0xe7>
  wait();
    32c2:	e8 94 05 00 00       	call   385b <wait>
  fd = open("bigarg-ok", 0);
    32c7:	83 ec 08             	sub    $0x8,%esp
    32ca:	6a 00                	push   $0x0
    32cc:	68 66 4c 00 00       	push   $0x4c66
    32d1:	e8 bd 05 00 00       	call   3893 <open>
  if(fd < 0){
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	85 c0                	test   %eax,%eax
    32db:	0f 88 8f 00 00 00    	js     3370 <bigargtest+0xd0>
  close(fd);
    32e1:	83 ec 0c             	sub    $0xc,%esp
    32e4:	50                   	push   %eax
    32e5:	e8 91 05 00 00       	call   387b <close>
  unlink("bigarg-ok");
    32ea:	c7 04 24 66 4c 00 00 	movl   $0x4c66,(%esp)
    32f1:	e8 ad 05 00 00       	call   38a3 <unlink>
}
    32f6:	83 c4 10             	add    $0x10,%esp
    32f9:	c9                   	leave  
    32fa:	c3                   	ret    
    32fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    32ff:	90                   	nop
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3300:	c7 04 85 e0 a4 00 00 	movl   $0x539c,0xa4e0(,%eax,4)
    3307:	9c 53 00 00 
    for(i = 0; i < MAXARG-1; i++)
    330b:	83 c0 01             	add    $0x1,%eax
    330e:	83 f8 1f             	cmp    $0x1f,%eax
    3311:	75 ed                	jne    3300 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    3313:	51                   	push   %ecx
    3314:	51                   	push   %ecx
    3315:	68 70 4c 00 00       	push   $0x4c70
    331a:	ff 35 a0 5d 00 00    	pushl  0x5da0
    args[MAXARG-1] = 0;
    3320:	c7 05 5c a5 00 00 00 	movl   $0x0,0xa55c
    3327:	00 00 00 
    printf(stdout, "bigarg test\n");
    332a:	e8 c1 06 00 00       	call   39f0 <printf>
    exec("echo", args);
    332f:	58                   	pop    %eax
    3330:	5a                   	pop    %edx
    3331:	68 e0 a4 00 00       	push   $0xa4e0
    3336:	68 3d 3e 00 00       	push   $0x3e3d
    333b:	e8 4b 05 00 00       	call   388b <exec>
    printf(stdout, "bigarg test ok\n");
    3340:	59                   	pop    %ecx
    3341:	58                   	pop    %eax
    3342:	68 7d 4c 00 00       	push   $0x4c7d
    3347:	ff 35 a0 5d 00 00    	pushl  0x5da0
    334d:	e8 9e 06 00 00       	call   39f0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3352:	58                   	pop    %eax
    3353:	5a                   	pop    %edx
    3354:	68 00 02 00 00       	push   $0x200
    3359:	68 66 4c 00 00       	push   $0x4c66
    335e:	e8 30 05 00 00       	call   3893 <open>
    close(fd);
    3363:	89 04 24             	mov    %eax,(%esp)
    3366:	e8 10 05 00 00       	call   387b <close>
    exit();
    336b:	e8 e3 04 00 00       	call   3853 <exit>
    printf(stdout, "bigarg test failed!\n");
    3370:	50                   	push   %eax
    3371:	50                   	push   %eax
    3372:	68 a6 4c 00 00       	push   $0x4ca6
    3377:	ff 35 a0 5d 00 00    	pushl  0x5da0
    337d:	e8 6e 06 00 00       	call   39f0 <printf>
    exit();
    3382:	e8 cc 04 00 00       	call   3853 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3387:	52                   	push   %edx
    3388:	52                   	push   %edx
    3389:	68 8d 4c 00 00       	push   $0x4c8d
    338e:	ff 35 a0 5d 00 00    	pushl  0x5da0
    3394:	e8 57 06 00 00       	call   39f0 <printf>
    exit();
    3399:	e8 b5 04 00 00       	call   3853 <exit>
    339e:	66 90                	xchg   %ax,%ax

000033a0 <fsfull>:
{
    33a0:	55                   	push   %ebp
    33a1:	89 e5                	mov    %esp,%ebp
    33a3:	57                   	push   %edi
    33a4:	56                   	push   %esi
  for(nfiles = 0; ; nfiles++){
    33a5:	31 f6                	xor    %esi,%esi
{
    33a7:	53                   	push   %ebx
    33a8:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    33ab:	68 bb 4c 00 00       	push   $0x4cbb
    33b0:	6a 01                	push   $0x1
    33b2:	e8 39 06 00 00       	call   39f0 <printf>
    33b7:	83 c4 10             	add    $0x10,%esp
    33ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    33c0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33c5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    33ca:	83 ec 04             	sub    $0x4,%esp
    name[0] = 'f';
    33cd:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    33d1:	f7 e6                	mul    %esi
    name[5] = '\0';
    33d3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    33d7:	c1 ea 06             	shr    $0x6,%edx
    33da:	8d 42 30             	lea    0x30(%edx),%eax
    33dd:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    33e0:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    33e6:	89 f2                	mov    %esi,%edx
    33e8:	29 c2                	sub    %eax,%edx
    33ea:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33ef:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    33f1:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33f6:	c1 ea 05             	shr    $0x5,%edx
    33f9:	83 c2 30             	add    $0x30,%edx
    33fc:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    33ff:	f7 e6                	mul    %esi
    3401:	c1 ea 05             	shr    $0x5,%edx
    3404:	6b c2 64             	imul   $0x64,%edx,%eax
    3407:	89 f2                	mov    %esi,%edx
    3409:	29 c2                	sub    %eax,%edx
    340b:	89 d0                	mov    %edx,%eax
    340d:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    340f:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3411:	c1 ea 03             	shr    $0x3,%edx
    3414:	83 c2 30             	add    $0x30,%edx
    3417:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    341a:	f7 e1                	mul    %ecx
    341c:	89 f0                	mov    %esi,%eax
    341e:	c1 ea 03             	shr    $0x3,%edx
    3421:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3424:	01 d2                	add    %edx,%edx
    3426:	29 d0                	sub    %edx,%eax
    3428:	83 c0 30             	add    $0x30,%eax
    342b:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    342e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3431:	50                   	push   %eax
    3432:	68 c8 4c 00 00       	push   $0x4cc8
    3437:	6a 01                	push   $0x1
    3439:	e8 b2 05 00 00       	call   39f0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    343e:	58                   	pop    %eax
    343f:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3442:	5a                   	pop    %edx
    3443:	68 02 02 00 00       	push   $0x202
    3448:	50                   	push   %eax
    3449:	e8 45 04 00 00       	call   3893 <open>
    if(fd < 0){
    344e:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3451:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3453:	85 c0                	test   %eax,%eax
    3455:	78 4f                	js     34a6 <fsfull+0x106>
    int total = 0;
    3457:	31 db                	xor    %ebx,%ebx
    3459:	eb 07                	jmp    3462 <fsfull+0xc2>
    345b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    345f:	90                   	nop
      total += cc;
    3460:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    3462:	83 ec 04             	sub    $0x4,%esp
    3465:	68 00 02 00 00       	push   $0x200
    346a:	68 e0 84 00 00       	push   $0x84e0
    346f:	57                   	push   %edi
    3470:	e8 fe 03 00 00       	call   3873 <write>
      if(cc < 512)
    3475:	83 c4 10             	add    $0x10,%esp
    3478:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    347d:	7f e1                	jg     3460 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    347f:	83 ec 04             	sub    $0x4,%esp
    3482:	53                   	push   %ebx
    3483:	68 e4 4c 00 00       	push   $0x4ce4
    3488:	6a 01                	push   $0x1
    348a:	e8 61 05 00 00       	call   39f0 <printf>
    close(fd);
    348f:	89 3c 24             	mov    %edi,(%esp)
    3492:	e8 e4 03 00 00       	call   387b <close>
    if(total == 0)
    3497:	83 c4 10             	add    $0x10,%esp
    349a:	85 db                	test   %ebx,%ebx
    349c:	74 1e                	je     34bc <fsfull+0x11c>
  for(nfiles = 0; ; nfiles++){
    349e:	83 c6 01             	add    $0x1,%esi
    34a1:	e9 1a ff ff ff       	jmp    33c0 <fsfull+0x20>
      printf(1, "open %s failed\n", name);
    34a6:	83 ec 04             	sub    $0x4,%esp
    34a9:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34ac:	50                   	push   %eax
    34ad:	68 d4 4c 00 00       	push   $0x4cd4
    34b2:	6a 01                	push   $0x1
    34b4:	e8 37 05 00 00       	call   39f0 <printf>
      break;
    34b9:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    34bc:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    34c1:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    34c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34cd:	8d 76 00             	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    34d0:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    34d2:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    unlink(name);
    34d7:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'f';
    34da:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    34de:	f7 e7                	mul    %edi
    name[5] = '\0';
    34e0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    34e4:	c1 ea 06             	shr    $0x6,%edx
    34e7:	8d 42 30             	lea    0x30(%edx),%eax
    34ea:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    34ed:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    34f3:	89 f2                	mov    %esi,%edx
    34f5:	29 c2                	sub    %eax,%edx
    34f7:	89 d0                	mov    %edx,%eax
    34f9:	f7 e3                	mul    %ebx
    name[3] = '0' + (nfiles % 100) / 10;
    34fb:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34fd:	c1 ea 05             	shr    $0x5,%edx
    3500:	83 c2 30             	add    $0x30,%edx
    3503:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3506:	f7 e3                	mul    %ebx
    3508:	c1 ea 05             	shr    $0x5,%edx
    350b:	6b c2 64             	imul   $0x64,%edx,%eax
    350e:	89 f2                	mov    %esi,%edx
    3510:	29 c2                	sub    %eax,%edx
    3512:	89 d0                	mov    %edx,%eax
    3514:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    3516:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3518:	c1 ea 03             	shr    $0x3,%edx
    351b:	83 c2 30             	add    $0x30,%edx
    351e:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3521:	f7 e1                	mul    %ecx
    3523:	89 f0                	mov    %esi,%eax
    nfiles--;
    3525:	83 ee 01             	sub    $0x1,%esi
    name[4] = '0' + (nfiles % 10);
    3528:	c1 ea 03             	shr    $0x3,%edx
    352b:	8d 14 92             	lea    (%edx,%edx,4),%edx
    352e:	01 d2                	add    %edx,%edx
    3530:	29 d0                	sub    %edx,%eax
    3532:	83 c0 30             	add    $0x30,%eax
    3535:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3538:	8d 45 a8             	lea    -0x58(%ebp),%eax
    353b:	50                   	push   %eax
    353c:	e8 62 03 00 00       	call   38a3 <unlink>
  while(nfiles >= 0){
    3541:	83 c4 10             	add    $0x10,%esp
    3544:	83 fe ff             	cmp    $0xffffffff,%esi
    3547:	75 87                	jne    34d0 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    3549:	83 ec 08             	sub    $0x8,%esp
    354c:	68 f4 4c 00 00       	push   $0x4cf4
    3551:	6a 01                	push   $0x1
    3553:	e8 98 04 00 00       	call   39f0 <printf>
}
    3558:	83 c4 10             	add    $0x10,%esp
    355b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    355e:	5b                   	pop    %ebx
    355f:	5e                   	pop    %esi
    3560:	5f                   	pop    %edi
    3561:	5d                   	pop    %ebp
    3562:	c3                   	ret    
    3563:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    356a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003570 <uio>:
{
    3570:	55                   	push   %ebp
    3571:	89 e5                	mov    %esp,%ebp
    3573:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3576:	68 0a 4d 00 00       	push   $0x4d0a
    357b:	6a 01                	push   $0x1
    357d:	e8 6e 04 00 00       	call   39f0 <printf>
  pid = fork();
    3582:	e8 c4 02 00 00       	call   384b <fork>
  if(pid == 0){
    3587:	83 c4 10             	add    $0x10,%esp
    358a:	85 c0                	test   %eax,%eax
    358c:	74 1b                	je     35a9 <uio+0x39>
  } else if(pid < 0){
    358e:	78 3d                	js     35cd <uio+0x5d>
  wait();
    3590:	e8 c6 02 00 00       	call   385b <wait>
  printf(1, "uio test done\n");
    3595:	83 ec 08             	sub    $0x8,%esp
    3598:	68 14 4d 00 00       	push   $0x4d14
    359d:	6a 01                	push   $0x1
    359f:	e8 4c 04 00 00       	call   39f0 <printf>
}
    35a4:	83 c4 10             	add    $0x10,%esp
    35a7:	c9                   	leave  
    35a8:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    35a9:	b8 09 00 00 00       	mov    $0x9,%eax
    35ae:	ba 70 00 00 00       	mov    $0x70,%edx
    35b3:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    35b4:	ba 71 00 00 00       	mov    $0x71,%edx
    35b9:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    35ba:	52                   	push   %edx
    35bb:	52                   	push   %edx
    35bc:	68 7c 54 00 00       	push   $0x547c
    35c1:	6a 01                	push   $0x1
    35c3:	e8 28 04 00 00       	call   39f0 <printf>
    exit();
    35c8:	e8 86 02 00 00       	call   3853 <exit>
    printf (1, "fork failed\n");
    35cd:	50                   	push   %eax
    35ce:	50                   	push   %eax
    35cf:	68 99 4c 00 00       	push   $0x4c99
    35d4:	6a 01                	push   $0x1
    35d6:	e8 15 04 00 00       	call   39f0 <printf>
    exit();
    35db:	e8 73 02 00 00       	call   3853 <exit>

000035e0 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    35e0:	69 05 9c 5d 00 00 0d 	imul   $0x19660d,0x5d9c,%eax
    35e7:	66 19 00 
    35ea:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    35ef:	a3 9c 5d 00 00       	mov    %eax,0x5d9c
}
    35f4:	c3                   	ret    
    35f5:	66 90                	xchg   %ax,%ax
    35f7:	66 90                	xchg   %ax,%ax
    35f9:	66 90                	xchg   %ax,%ax
    35fb:	66 90                	xchg   %ax,%ax
    35fd:	66 90                	xchg   %ax,%ax
    35ff:	90                   	nop

00003600 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3600:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3601:	31 c0                	xor    %eax,%eax
{
    3603:	89 e5                	mov    %esp,%ebp
    3605:	53                   	push   %ebx
    3606:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3609:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    360c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3610:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3614:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3617:	83 c0 01             	add    $0x1,%eax
    361a:	84 d2                	test   %dl,%dl
    361c:	75 f2                	jne    3610 <strcpy+0x10>
    ;
  return os;
}
    361e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3621:	89 c8                	mov    %ecx,%eax
    3623:	c9                   	leave  
    3624:	c3                   	ret    
    3625:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003630 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3630:	55                   	push   %ebp
    3631:	89 e5                	mov    %esp,%ebp
    3633:	53                   	push   %ebx
    3634:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3637:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
    363a:	0f b6 01             	movzbl (%ecx),%eax
    363d:	0f b6 1a             	movzbl (%edx),%ebx
    3640:	84 c0                	test   %al,%al
    3642:	75 1d                	jne    3661 <strcmp+0x31>
    3644:	eb 2a                	jmp    3670 <strcmp+0x40>
    3646:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    364d:	8d 76 00             	lea    0x0(%esi),%esi
    3650:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
    3654:	83 c1 01             	add    $0x1,%ecx
    3657:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
    365a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
    365d:	84 c0                	test   %al,%al
    365f:	74 0f                	je     3670 <strcmp+0x40>
    3661:	38 d8                	cmp    %bl,%al
    3663:	74 eb                	je     3650 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    3665:	29 d8                	sub    %ebx,%eax
}
    3667:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    366a:	c9                   	leave  
    366b:	c3                   	ret    
    366c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3670:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    3672:	29 d8                	sub    %ebx,%eax
}
    3674:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3677:	c9                   	leave  
    3678:	c3                   	ret    
    3679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003680 <strlen>:

uint
strlen(char *s)
{
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    3686:	80 3a 00             	cmpb   $0x0,(%edx)
    3689:	74 15                	je     36a0 <strlen+0x20>
    368b:	31 c0                	xor    %eax,%eax
    368d:	8d 76 00             	lea    0x0(%esi),%esi
    3690:	83 c0 01             	add    $0x1,%eax
    3693:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    3697:	89 c1                	mov    %eax,%ecx
    3699:	75 f5                	jne    3690 <strlen+0x10>
    ;
  return n;
}
    369b:	89 c8                	mov    %ecx,%eax
    369d:	5d                   	pop    %ebp
    369e:	c3                   	ret    
    369f:	90                   	nop
  for(n = 0; s[n]; n++)
    36a0:	31 c9                	xor    %ecx,%ecx
}
    36a2:	5d                   	pop    %ebp
    36a3:	89 c8                	mov    %ecx,%eax
    36a5:	c3                   	ret    
    36a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36ad:	8d 76 00             	lea    0x0(%esi),%esi

000036b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    36b0:	55                   	push   %ebp
    36b1:	89 e5                	mov    %esp,%ebp
    36b3:	57                   	push   %edi
    36b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    36b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    36ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    36bd:	89 d7                	mov    %edx,%edi
    36bf:	fc                   	cld    
    36c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    36c2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    36c5:	89 d0                	mov    %edx,%eax
    36c7:	c9                   	leave  
    36c8:	c3                   	ret    
    36c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000036d0 <strchr>:

char*
strchr(const char *s, char c)
{
    36d0:	55                   	push   %ebp
    36d1:	89 e5                	mov    %esp,%ebp
    36d3:	8b 45 08             	mov    0x8(%ebp),%eax
    36d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    36da:	0f b6 10             	movzbl (%eax),%edx
    36dd:	84 d2                	test   %dl,%dl
    36df:	75 12                	jne    36f3 <strchr+0x23>
    36e1:	eb 1d                	jmp    3700 <strchr+0x30>
    36e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    36e7:	90                   	nop
    36e8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    36ec:	83 c0 01             	add    $0x1,%eax
    36ef:	84 d2                	test   %dl,%dl
    36f1:	74 0d                	je     3700 <strchr+0x30>
    if(*s == c)
    36f3:	38 d1                	cmp    %dl,%cl
    36f5:	75 f1                	jne    36e8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    36f7:	5d                   	pop    %ebp
    36f8:	c3                   	ret    
    36f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3700:	31 c0                	xor    %eax,%eax
}
    3702:	5d                   	pop    %ebp
    3703:	c3                   	ret    
    3704:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    370b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    370f:	90                   	nop

00003710 <gets>:

char*
gets(char *buf, int max)
{
    3710:	55                   	push   %ebp
    3711:	89 e5                	mov    %esp,%ebp
    3713:	57                   	push   %edi
    3714:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3715:	31 f6                	xor    %esi,%esi
{
    3717:	53                   	push   %ebx
    3718:	89 f3                	mov    %esi,%ebx
    371a:	83 ec 1c             	sub    $0x1c,%esp
    371d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    3720:	eb 2f                	jmp    3751 <gets+0x41>
    3722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    3728:	83 ec 04             	sub    $0x4,%esp
    372b:	8d 45 e7             	lea    -0x19(%ebp),%eax
    372e:	6a 01                	push   $0x1
    3730:	50                   	push   %eax
    3731:	6a 00                	push   $0x0
    3733:	e8 33 01 00 00       	call   386b <read>
    if(cc < 1)
    3738:	83 c4 10             	add    $0x10,%esp
    373b:	85 c0                	test   %eax,%eax
    373d:	7e 1c                	jle    375b <gets+0x4b>
      break;
    buf[i++] = c;
    373f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
    3743:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
    3746:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    3749:	3c 0a                	cmp    $0xa,%al
    374b:	74 23                	je     3770 <gets+0x60>
    374d:	3c 0d                	cmp    $0xd,%al
    374f:	74 1f                	je     3770 <gets+0x60>
  for(i=0; i+1 < max; ){
    3751:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
    3754:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
    3756:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3759:	7c cd                	jl     3728 <gets+0x18>
    375b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    375d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    3760:	c6 03 00             	movb   $0x0,(%ebx)
}
    3763:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3766:	5b                   	pop    %ebx
    3767:	5e                   	pop    %esi
    3768:	5f                   	pop    %edi
    3769:	5d                   	pop    %ebp
    376a:	c3                   	ret    
    376b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    376f:	90                   	nop
  buf[i] = '\0';
    3770:	8b 75 08             	mov    0x8(%ebp),%esi
}
    3773:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    3776:	01 de                	add    %ebx,%esi
    3778:	89 f3                	mov    %esi,%ebx
    377a:	c6 03 00             	movb   $0x0,(%ebx)
}
    377d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3780:	5b                   	pop    %ebx
    3781:	5e                   	pop    %esi
    3782:	5f                   	pop    %edi
    3783:	5d                   	pop    %ebp
    3784:	c3                   	ret    
    3785:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003790 <stat>:

int
stat(char *n, struct stat *st)
{
    3790:	55                   	push   %ebp
    3791:	89 e5                	mov    %esp,%ebp
    3793:	56                   	push   %esi
    3794:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3795:	83 ec 08             	sub    $0x8,%esp
    3798:	6a 00                	push   $0x0
    379a:	ff 75 08             	pushl  0x8(%ebp)
    379d:	e8 f1 00 00 00       	call   3893 <open>
  if(fd < 0)
    37a2:	83 c4 10             	add    $0x10,%esp
    37a5:	85 c0                	test   %eax,%eax
    37a7:	78 27                	js     37d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    37a9:	83 ec 08             	sub    $0x8,%esp
    37ac:	ff 75 0c             	pushl  0xc(%ebp)
    37af:	89 c3                	mov    %eax,%ebx
    37b1:	50                   	push   %eax
    37b2:	e8 f4 00 00 00       	call   38ab <fstat>
  close(fd);
    37b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    37ba:	89 c6                	mov    %eax,%esi
  close(fd);
    37bc:	e8 ba 00 00 00       	call   387b <close>
  return r;
    37c1:	83 c4 10             	add    $0x10,%esp
}
    37c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    37c7:	89 f0                	mov    %esi,%eax
    37c9:	5b                   	pop    %ebx
    37ca:	5e                   	pop    %esi
    37cb:	5d                   	pop    %ebp
    37cc:	c3                   	ret    
    37cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    37d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    37d5:	eb ed                	jmp    37c4 <stat+0x34>
    37d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37de:	66 90                	xchg   %ax,%ax

000037e0 <atoi>:

int
atoi(const char *s)
{
    37e0:	55                   	push   %ebp
    37e1:	89 e5                	mov    %esp,%ebp
    37e3:	53                   	push   %ebx
    37e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    37e7:	0f be 02             	movsbl (%edx),%eax
    37ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
    37ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    37f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    37f5:	77 1e                	ja     3815 <atoi+0x35>
    37f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3800:	83 c2 01             	add    $0x1,%edx
    3803:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3806:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    380a:	0f be 02             	movsbl (%edx),%eax
    380d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3810:	80 fb 09             	cmp    $0x9,%bl
    3813:	76 eb                	jbe    3800 <atoi+0x20>
  return n;
}
    3815:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3818:	89 c8                	mov    %ecx,%eax
    381a:	c9                   	leave  
    381b:	c3                   	ret    
    381c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003820 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3820:	55                   	push   %ebp
    3821:	89 e5                	mov    %esp,%ebp
    3823:	57                   	push   %edi
    3824:	8b 45 10             	mov    0x10(%ebp),%eax
    3827:	8b 55 08             	mov    0x8(%ebp),%edx
    382a:	56                   	push   %esi
    382b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    382e:	85 c0                	test   %eax,%eax
    3830:	7e 13                	jle    3845 <memmove+0x25>
    3832:	01 d0                	add    %edx,%eax
  dst = vdst;
    3834:	89 d7                	mov    %edx,%edi
    3836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    383d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3840:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3841:	39 f8                	cmp    %edi,%eax
    3843:	75 fb                	jne    3840 <memmove+0x20>
  return vdst;
}
    3845:	5e                   	pop    %esi
    3846:	89 d0                	mov    %edx,%eax
    3848:	5f                   	pop    %edi
    3849:	5d                   	pop    %ebp
    384a:	c3                   	ret    

0000384b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    384b:	b8 01 00 00 00       	mov    $0x1,%eax
    3850:	cd 40                	int    $0x40
    3852:	c3                   	ret    

00003853 <exit>:
SYSCALL(exit)
    3853:	b8 02 00 00 00       	mov    $0x2,%eax
    3858:	cd 40                	int    $0x40
    385a:	c3                   	ret    

0000385b <wait>:
SYSCALL(wait)
    385b:	b8 03 00 00 00       	mov    $0x3,%eax
    3860:	cd 40                	int    $0x40
    3862:	c3                   	ret    

00003863 <pipe>:
SYSCALL(pipe)
    3863:	b8 04 00 00 00       	mov    $0x4,%eax
    3868:	cd 40                	int    $0x40
    386a:	c3                   	ret    

0000386b <read>:
SYSCALL(read)
    386b:	b8 05 00 00 00       	mov    $0x5,%eax
    3870:	cd 40                	int    $0x40
    3872:	c3                   	ret    

00003873 <write>:
SYSCALL(write)
    3873:	b8 10 00 00 00       	mov    $0x10,%eax
    3878:	cd 40                	int    $0x40
    387a:	c3                   	ret    

0000387b <close>:
SYSCALL(close)
    387b:	b8 15 00 00 00       	mov    $0x15,%eax
    3880:	cd 40                	int    $0x40
    3882:	c3                   	ret    

00003883 <kill>:
SYSCALL(kill)
    3883:	b8 06 00 00 00       	mov    $0x6,%eax
    3888:	cd 40                	int    $0x40
    388a:	c3                   	ret    

0000388b <exec>:
SYSCALL(exec)
    388b:	b8 07 00 00 00       	mov    $0x7,%eax
    3890:	cd 40                	int    $0x40
    3892:	c3                   	ret    

00003893 <open>:
SYSCALL(open)
    3893:	b8 0f 00 00 00       	mov    $0xf,%eax
    3898:	cd 40                	int    $0x40
    389a:	c3                   	ret    

0000389b <mknod>:
SYSCALL(mknod)
    389b:	b8 11 00 00 00       	mov    $0x11,%eax
    38a0:	cd 40                	int    $0x40
    38a2:	c3                   	ret    

000038a3 <unlink>:
SYSCALL(unlink)
    38a3:	b8 12 00 00 00       	mov    $0x12,%eax
    38a8:	cd 40                	int    $0x40
    38aa:	c3                   	ret    

000038ab <fstat>:
SYSCALL(fstat)
    38ab:	b8 08 00 00 00       	mov    $0x8,%eax
    38b0:	cd 40                	int    $0x40
    38b2:	c3                   	ret    

000038b3 <link>:
SYSCALL(link)
    38b3:	b8 13 00 00 00       	mov    $0x13,%eax
    38b8:	cd 40                	int    $0x40
    38ba:	c3                   	ret    

000038bb <mkdir>:
SYSCALL(mkdir)
    38bb:	b8 14 00 00 00       	mov    $0x14,%eax
    38c0:	cd 40                	int    $0x40
    38c2:	c3                   	ret    

000038c3 <chdir>:
SYSCALL(chdir)
    38c3:	b8 09 00 00 00       	mov    $0x9,%eax
    38c8:	cd 40                	int    $0x40
    38ca:	c3                   	ret    

000038cb <dup>:
SYSCALL(dup)
    38cb:	b8 0a 00 00 00       	mov    $0xa,%eax
    38d0:	cd 40                	int    $0x40
    38d2:	c3                   	ret    

000038d3 <getpid>:
SYSCALL(getpid)
    38d3:	b8 0b 00 00 00       	mov    $0xb,%eax
    38d8:	cd 40                	int    $0x40
    38da:	c3                   	ret    

000038db <sbrk>:
SYSCALL(sbrk)
    38db:	b8 0c 00 00 00       	mov    $0xc,%eax
    38e0:	cd 40                	int    $0x40
    38e2:	c3                   	ret    

000038e3 <sleep>:
SYSCALL(sleep)
    38e3:	b8 0d 00 00 00       	mov    $0xd,%eax
    38e8:	cd 40                	int    $0x40
    38ea:	c3                   	ret    

000038eb <uptime>:
SYSCALL(uptime)
    38eb:	b8 0e 00 00 00       	mov    $0xe,%eax
    38f0:	cd 40                	int    $0x40
    38f2:	c3                   	ret    

000038f3 <halt>:
SYSCALL(halt)
    38f3:	b8 16 00 00 00       	mov    $0x16,%eax
    38f8:	cd 40                	int    $0x40
    38fa:	c3                   	ret    

000038fb <cps>:
SYSCALL(cps)
    38fb:	b8 17 00 00 00       	mov    $0x17,%eax
    3900:	cd 40                	int    $0x40
    3902:	c3                   	ret    

00003903 <chpr>:
SYSCALL(chpr)
    3903:	b8 18 00 00 00       	mov    $0x18,%eax
    3908:	cd 40                	int    $0x40
    390a:	c3                   	ret    

0000390b <getNumProc>:
SYSCALL(getNumProc)
    390b:	b8 19 00 00 00       	mov    $0x19,%eax
    3910:	cd 40                	int    $0x40
    3912:	c3                   	ret    

00003913 <getMaxPid>:
SYSCALL(getMaxPid)
    3913:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3918:	cd 40                	int    $0x40
    391a:	c3                   	ret    

0000391b <getProcInfo>:
SYSCALL(getProcInfo)
    391b:	b8 1b 00 00 00       	mov    $0x1b,%eax
    3920:	cd 40                	int    $0x40
    3922:	c3                   	ret    

00003923 <setprio>:
SYSCALL(setprio)
    3923:	b8 1c 00 00 00       	mov    $0x1c,%eax
    3928:	cd 40                	int    $0x40
    392a:	c3                   	ret    

0000392b <getprio>:
SYSCALL(getprio)
    392b:	b8 1d 00 00 00       	mov    $0x1d,%eax
    3930:	cd 40                	int    $0x40
    3932:	c3                   	ret    
    3933:	66 90                	xchg   %ax,%ax
    3935:	66 90                	xchg   %ax,%ax
    3937:	66 90                	xchg   %ax,%ax
    3939:	66 90                	xchg   %ax,%ax
    393b:	66 90                	xchg   %ax,%ax
    393d:	66 90                	xchg   %ax,%ax
    393f:	90                   	nop

00003940 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3940:	55                   	push   %ebp
    3941:	89 e5                	mov    %esp,%ebp
    3943:	57                   	push   %edi
    3944:	56                   	push   %esi
    3945:	53                   	push   %ebx
    3946:	83 ec 3c             	sub    $0x3c,%esp
    3949:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    394c:	89 d1                	mov    %edx,%ecx
{
    394e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3951:	85 d2                	test   %edx,%edx
    3953:	0f 89 7f 00 00 00    	jns    39d8 <printint+0x98>
    3959:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    395d:	74 79                	je     39d8 <printint+0x98>
    neg = 1;
    395f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3966:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3968:	31 db                	xor    %ebx,%ebx
    396a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    396d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3970:	89 c8                	mov    %ecx,%eax
    3972:	31 d2                	xor    %edx,%edx
    3974:	89 cf                	mov    %ecx,%edi
    3976:	f7 75 c4             	divl   -0x3c(%ebp)
    3979:	0f b6 92 d4 54 00 00 	movzbl 0x54d4(%edx),%edx
    3980:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3983:	89 d8                	mov    %ebx,%eax
    3985:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3988:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    398b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    398e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3991:	76 dd                	jbe    3970 <printint+0x30>
  if(neg)
    3993:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3996:	85 c9                	test   %ecx,%ecx
    3998:	74 0c                	je     39a6 <printint+0x66>
    buf[i++] = '-';
    399a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    399f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    39a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    39a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    39a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    39ad:	eb 07                	jmp    39b6 <printint+0x76>
    39af:	90                   	nop
    putc(fd, buf[i]);
    39b0:	0f b6 13             	movzbl (%ebx),%edx
    39b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    39b6:	83 ec 04             	sub    $0x4,%esp
    39b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    39bc:	6a 01                	push   $0x1
    39be:	56                   	push   %esi
    39bf:	57                   	push   %edi
    39c0:	e8 ae fe ff ff       	call   3873 <write>
  while(--i >= 0)
    39c5:	83 c4 10             	add    $0x10,%esp
    39c8:	39 de                	cmp    %ebx,%esi
    39ca:	75 e4                	jne    39b0 <printint+0x70>
}
    39cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    39cf:	5b                   	pop    %ebx
    39d0:	5e                   	pop    %esi
    39d1:	5f                   	pop    %edi
    39d2:	5d                   	pop    %ebp
    39d3:	c3                   	ret    
    39d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    39d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    39df:	eb 87                	jmp    3968 <printint+0x28>
    39e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    39e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    39ef:	90                   	nop

000039f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    39f0:	55                   	push   %ebp
    39f1:	89 e5                	mov    %esp,%ebp
    39f3:	57                   	push   %edi
    39f4:	56                   	push   %esi
    39f5:	53                   	push   %ebx
    39f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    39f9:	8b 75 0c             	mov    0xc(%ebp),%esi
    39fc:	0f b6 1e             	movzbl (%esi),%ebx
    39ff:	84 db                	test   %bl,%bl
    3a01:	0f 84 b8 00 00 00    	je     3abf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
    3a07:	8d 45 10             	lea    0x10(%ebp),%eax
    3a0a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3a0d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3a10:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
    3a12:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3a15:	eb 37                	jmp    3a4e <printf+0x5e>
    3a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a1e:	66 90                	xchg   %ax,%ax
    3a20:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3a23:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    3a28:	83 f8 25             	cmp    $0x25,%eax
    3a2b:	74 17                	je     3a44 <printf+0x54>
  write(fd, &c, 1);
    3a2d:	83 ec 04             	sub    $0x4,%esp
    3a30:	88 5d e7             	mov    %bl,-0x19(%ebp)
    3a33:	6a 01                	push   $0x1
    3a35:	57                   	push   %edi
    3a36:	ff 75 08             	pushl  0x8(%ebp)
    3a39:	e8 35 fe ff ff       	call   3873 <write>
    3a3e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    3a41:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3a44:	0f b6 1e             	movzbl (%esi),%ebx
    3a47:	83 c6 01             	add    $0x1,%esi
    3a4a:	84 db                	test   %bl,%bl
    3a4c:	74 71                	je     3abf <printf+0xcf>
    c = fmt[i] & 0xff;
    3a4e:	0f be cb             	movsbl %bl,%ecx
    3a51:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3a54:	85 d2                	test   %edx,%edx
    3a56:	74 c8                	je     3a20 <printf+0x30>
      }
    } else if(state == '%'){
    3a58:	83 fa 25             	cmp    $0x25,%edx
    3a5b:	75 e7                	jne    3a44 <printf+0x54>
      if(c == 'd'){
    3a5d:	83 f8 64             	cmp    $0x64,%eax
    3a60:	0f 84 9a 00 00 00    	je     3b00 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3a66:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3a6c:	83 f9 70             	cmp    $0x70,%ecx
    3a6f:	74 5f                	je     3ad0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3a71:	83 f8 73             	cmp    $0x73,%eax
    3a74:	0f 84 d6 00 00 00    	je     3b50 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3a7a:	83 f8 63             	cmp    $0x63,%eax
    3a7d:	0f 84 8d 00 00 00    	je     3b10 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3a83:	83 f8 25             	cmp    $0x25,%eax
    3a86:	0f 84 b4 00 00 00    	je     3b40 <printf+0x150>
  write(fd, &c, 1);
    3a8c:	83 ec 04             	sub    $0x4,%esp
    3a8f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3a93:	6a 01                	push   $0x1
    3a95:	57                   	push   %edi
    3a96:	ff 75 08             	pushl  0x8(%ebp)
    3a99:	e8 d5 fd ff ff       	call   3873 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3a9e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3aa1:	83 c4 0c             	add    $0xc,%esp
    3aa4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
    3aa6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    3aa9:	57                   	push   %edi
    3aaa:	ff 75 08             	pushl  0x8(%ebp)
    3aad:	e8 c1 fd ff ff       	call   3873 <write>
  for(i = 0; fmt[i]; i++){
    3ab2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
    3ab6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3ab9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
    3abb:	84 db                	test   %bl,%bl
    3abd:	75 8f                	jne    3a4e <printf+0x5e>
    }
  }
}
    3abf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3ac2:	5b                   	pop    %ebx
    3ac3:	5e                   	pop    %esi
    3ac4:	5f                   	pop    %edi
    3ac5:	5d                   	pop    %ebp
    3ac6:	c3                   	ret    
    3ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3ace:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
    3ad0:	83 ec 0c             	sub    $0xc,%esp
    3ad3:	b9 10 00 00 00       	mov    $0x10,%ecx
    3ad8:	6a 00                	push   $0x0
    3ada:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    3add:	8b 45 08             	mov    0x8(%ebp),%eax
    3ae0:	8b 13                	mov    (%ebx),%edx
    3ae2:	e8 59 fe ff ff       	call   3940 <printint>
        ap++;
    3ae7:	89 d8                	mov    %ebx,%eax
    3ae9:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3aec:	31 d2                	xor    %edx,%edx
        ap++;
    3aee:	83 c0 04             	add    $0x4,%eax
    3af1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3af4:	e9 4b ff ff ff       	jmp    3a44 <printf+0x54>
    3af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
    3b00:	83 ec 0c             	sub    $0xc,%esp
    3b03:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b08:	6a 01                	push   $0x1
    3b0a:	eb ce                	jmp    3ada <printf+0xea>
    3b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    3b10:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    3b13:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b16:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
    3b18:	6a 01                	push   $0x1
        ap++;
    3b1a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
    3b1d:	57                   	push   %edi
    3b1e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
    3b21:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b24:	e8 4a fd ff ff       	call   3873 <write>
        ap++;
    3b29:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    3b2c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b2f:	31 d2                	xor    %edx,%edx
    3b31:	e9 0e ff ff ff       	jmp    3a44 <printf+0x54>
    3b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b3d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
    3b40:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
    3b43:	83 ec 04             	sub    $0x4,%esp
    3b46:	e9 59 ff ff ff       	jmp    3aa4 <printf+0xb4>
    3b4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3b4f:	90                   	nop
        s = (char*)*ap;
    3b50:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3b53:	8b 18                	mov    (%eax),%ebx
        ap++;
    3b55:	83 c0 04             	add    $0x4,%eax
    3b58:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3b5b:	85 db                	test   %ebx,%ebx
    3b5d:	74 17                	je     3b76 <printf+0x186>
        while(*s != 0){
    3b5f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    3b62:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    3b64:	84 c0                	test   %al,%al
    3b66:	0f 84 d8 fe ff ff    	je     3a44 <printf+0x54>
    3b6c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3b6f:	89 de                	mov    %ebx,%esi
    3b71:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3b74:	eb 1a                	jmp    3b90 <printf+0x1a0>
          s = "(null)";
    3b76:	bb ca 54 00 00       	mov    $0x54ca,%ebx
        while(*s != 0){
    3b7b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    3b7e:	b8 28 00 00 00       	mov    $0x28,%eax
    3b83:	89 de                	mov    %ebx,%esi
    3b85:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b8f:	90                   	nop
  write(fd, &c, 1);
    3b90:	83 ec 04             	sub    $0x4,%esp
          s++;
    3b93:	83 c6 01             	add    $0x1,%esi
    3b96:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b99:	6a 01                	push   $0x1
    3b9b:	57                   	push   %edi
    3b9c:	53                   	push   %ebx
    3b9d:	e8 d1 fc ff ff       	call   3873 <write>
        while(*s != 0){
    3ba2:	0f b6 06             	movzbl (%esi),%eax
    3ba5:	83 c4 10             	add    $0x10,%esp
    3ba8:	84 c0                	test   %al,%al
    3baa:	75 e4                	jne    3b90 <printf+0x1a0>
      state = 0;
    3bac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    3baf:	31 d2                	xor    %edx,%edx
    3bb1:	e9 8e fe ff ff       	jmp    3a44 <printf+0x54>
    3bb6:	66 90                	xchg   %ax,%ax
    3bb8:	66 90                	xchg   %ax,%ax
    3bba:	66 90                	xchg   %ax,%ax
    3bbc:	66 90                	xchg   %ax,%ax
    3bbe:	66 90                	xchg   %ax,%ax

00003bc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3bc0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bc1:	a1 60 a5 00 00       	mov    0xa560,%eax
{
    3bc6:	89 e5                	mov    %esp,%ebp
    3bc8:	57                   	push   %edi
    3bc9:	56                   	push   %esi
    3bca:	53                   	push   %ebx
    3bcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3bce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bd8:	89 c2                	mov    %eax,%edx
    3bda:	8b 00                	mov    (%eax),%eax
    3bdc:	39 ca                	cmp    %ecx,%edx
    3bde:	73 30                	jae    3c10 <free+0x50>
    3be0:	39 c1                	cmp    %eax,%ecx
    3be2:	72 04                	jb     3be8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3be4:	39 c2                	cmp    %eax,%edx
    3be6:	72 f0                	jb     3bd8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3be8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3beb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bee:	39 f8                	cmp    %edi,%eax
    3bf0:	74 30                	je     3c22 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3bf2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3bf5:	8b 42 04             	mov    0x4(%edx),%eax
    3bf8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3bfb:	39 f1                	cmp    %esi,%ecx
    3bfd:	74 3a                	je     3c39 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3bff:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    3c01:	5b                   	pop    %ebx
  freep = p;
    3c02:	89 15 60 a5 00 00    	mov    %edx,0xa560
}
    3c08:	5e                   	pop    %esi
    3c09:	5f                   	pop    %edi
    3c0a:	5d                   	pop    %ebp
    3c0b:	c3                   	ret    
    3c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c10:	39 c2                	cmp    %eax,%edx
    3c12:	72 c4                	jb     3bd8 <free+0x18>
    3c14:	39 c1                	cmp    %eax,%ecx
    3c16:	73 c0                	jae    3bd8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3c18:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3c1b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3c1e:	39 f8                	cmp    %edi,%eax
    3c20:	75 d0                	jne    3bf2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3c22:	03 70 04             	add    0x4(%eax),%esi
    3c25:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c28:	8b 02                	mov    (%edx),%eax
    3c2a:	8b 00                	mov    (%eax),%eax
    3c2c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c2f:	8b 42 04             	mov    0x4(%edx),%eax
    3c32:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3c35:	39 f1                	cmp    %esi,%ecx
    3c37:	75 c6                	jne    3bff <free+0x3f>
    p->s.size += bp->s.size;
    3c39:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    3c3c:	89 15 60 a5 00 00    	mov    %edx,0xa560
    p->s.size += bp->s.size;
    3c42:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3c45:	8b 43 f8             	mov    -0x8(%ebx),%eax
    3c48:	89 02                	mov    %eax,(%edx)
}
    3c4a:	5b                   	pop    %ebx
    3c4b:	5e                   	pop    %esi
    3c4c:	5f                   	pop    %edi
    3c4d:	5d                   	pop    %ebp
    3c4e:	c3                   	ret    
    3c4f:	90                   	nop

00003c50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3c50:	55                   	push   %ebp
    3c51:	89 e5                	mov    %esp,%ebp
    3c53:	57                   	push   %edi
    3c54:	56                   	push   %esi
    3c55:	53                   	push   %ebx
    3c56:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c5c:	8b 3d 60 a5 00 00    	mov    0xa560,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c62:	8d 70 07             	lea    0x7(%eax),%esi
    3c65:	c1 ee 03             	shr    $0x3,%esi
    3c68:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3c6b:	85 ff                	test   %edi,%edi
    3c6d:	0f 84 ad 00 00 00    	je     3d20 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3c73:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    3c75:	8b 48 04             	mov    0x4(%eax),%ecx
    3c78:	39 f1                	cmp    %esi,%ecx
    3c7a:	73 71                	jae    3ced <malloc+0x9d>
    3c7c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    3c82:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3c87:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3c8a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    3c91:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    3c94:	eb 1b                	jmp    3cb1 <malloc+0x61>
    3c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c9d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3ca0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    3ca2:	8b 4a 04             	mov    0x4(%edx),%ecx
    3ca5:	39 f1                	cmp    %esi,%ecx
    3ca7:	73 4f                	jae    3cf8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3ca9:	8b 3d 60 a5 00 00    	mov    0xa560,%edi
    3caf:	89 d0                	mov    %edx,%eax
    3cb1:	39 c7                	cmp    %eax,%edi
    3cb3:	75 eb                	jne    3ca0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    3cb5:	83 ec 0c             	sub    $0xc,%esp
    3cb8:	ff 75 e4             	pushl  -0x1c(%ebp)
    3cbb:	e8 1b fc ff ff       	call   38db <sbrk>
  if(p == (char*)-1)
    3cc0:	83 c4 10             	add    $0x10,%esp
    3cc3:	83 f8 ff             	cmp    $0xffffffff,%eax
    3cc6:	74 1b                	je     3ce3 <malloc+0x93>
  hp->s.size = nu;
    3cc8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3ccb:	83 ec 0c             	sub    $0xc,%esp
    3cce:	83 c0 08             	add    $0x8,%eax
    3cd1:	50                   	push   %eax
    3cd2:	e8 e9 fe ff ff       	call   3bc0 <free>
  return freep;
    3cd7:	a1 60 a5 00 00       	mov    0xa560,%eax
      if((p = morecore(nunits)) == 0)
    3cdc:	83 c4 10             	add    $0x10,%esp
    3cdf:	85 c0                	test   %eax,%eax
    3ce1:	75 bd                	jne    3ca0 <malloc+0x50>
        return 0;
  }
}
    3ce3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3ce6:	31 c0                	xor    %eax,%eax
}
    3ce8:	5b                   	pop    %ebx
    3ce9:	5e                   	pop    %esi
    3cea:	5f                   	pop    %edi
    3ceb:	5d                   	pop    %ebp
    3cec:	c3                   	ret    
    if(p->s.size >= nunits){
    3ced:	89 c2                	mov    %eax,%edx
    3cef:	89 f8                	mov    %edi,%eax
    3cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    3cf8:	39 ce                	cmp    %ecx,%esi
    3cfa:	74 54                	je     3d50 <malloc+0x100>
        p->s.size -= nunits;
    3cfc:	29 f1                	sub    %esi,%ecx
    3cfe:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    3d01:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    3d04:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    3d07:	a3 60 a5 00 00       	mov    %eax,0xa560
}
    3d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3d0f:	8d 42 08             	lea    0x8(%edx),%eax
}
    3d12:	5b                   	pop    %ebx
    3d13:	5e                   	pop    %esi
    3d14:	5f                   	pop    %edi
    3d15:	5d                   	pop    %ebp
    3d16:	c3                   	ret    
    3d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d1e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    3d20:	c7 05 60 a5 00 00 64 	movl   $0xa564,0xa560
    3d27:	a5 00 00 
    base.s.size = 0;
    3d2a:	bf 64 a5 00 00       	mov    $0xa564,%edi
    base.s.ptr = freep = prevp = &base;
    3d2f:	c7 05 64 a5 00 00 64 	movl   $0xa564,0xa564
    3d36:	a5 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d39:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    3d3b:	c7 05 68 a5 00 00 00 	movl   $0x0,0xa568
    3d42:	00 00 00 
    if(p->s.size >= nunits){
    3d45:	e9 32 ff ff ff       	jmp    3c7c <malloc+0x2c>
    3d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3d50:	8b 0a                	mov    (%edx),%ecx
    3d52:	89 08                	mov    %ecx,(%eax)
    3d54:	eb b1                	jmp    3d07 <malloc+0xb7>

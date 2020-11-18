
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 62 11 80       	mov    $0x801162d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 00 32 10 80       	mov    $0x80103200,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 76 10 80       	push   $0x80107640
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 c5 47 00 00       	call   80104820 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 76 10 80       	push   $0x80107647
80100097:	50                   	push   %eax
80100098:	e8 73 46 00 00       	call   80104710 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 57 47 00 00       	call   80104840 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 b9 48 00 00       	call   80104a20 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 de 45 00 00       	call   80104750 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 5f 22 00 00       	call   801023f0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 4e 76 10 80       	push   $0x8010764e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 2d 46 00 00       	call   801047f0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 17 22 00 00       	jmp    801023f0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 5f 76 10 80       	push   $0x8010765f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ec 45 00 00       	call   801047f0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 9c 45 00 00       	call   801047b0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 20 46 00 00       	call   80104840 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 af 47 00 00       	jmp    80104a20 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 66 76 10 80       	push   $0x80107666
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	pushl  0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 e7 16 00 00       	call   80101980 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 9b 45 00 00       	call   80104840 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 0e 3f 00 00       	call   801041e0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(proc->killed){
801002e2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002e8:	8b 48 24             	mov    0x24(%eax),%ecx
801002eb:	85 c9                	test   %ecx,%ecx
801002ed:	74 d1                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ef:	83 ec 0c             	sub    $0xc,%esp
801002f2:	68 20 ff 10 80       	push   $0x8010ff20
801002f7:	e8 24 47 00 00       	call   80104a20 <release>
        ilock(ip);
801002fc:	5a                   	pop    %edx
801002fd:	ff 75 08             	pushl  0x8(%ebp)
80100300:	e8 9b 15 00 00       	call   801018a0 <ilock>
        return -1;
80100305:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100308:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100310:	5b                   	pop    %ebx
80100311:	5e                   	pop    %esi
80100312:	5f                   	pop    %edi
80100313:	5d                   	pop    %ebp
80100314:	c3                   	ret    
80100315:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 cf 46 00 00       	call   80104a20 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	pushl  0x8(%ebp)
80100355:	e8 46 15 00 00       	call   801018a0 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100389:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  getcallerpcs(&s, pcs);
8010038f:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100392:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cons.locking = 0;
80100395:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
8010039c:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010039f:	0f b6 00             	movzbl (%eax),%eax
801003a2:	50                   	push   %eax
801003a3:	68 6d 76 10 80       	push   $0x8010766d
801003a8:	e8 d3 02 00 00       	call   80100680 <cprintf>
  cprintf(s);
801003ad:	58                   	pop    %eax
801003ae:	ff 75 08             	pushl  0x8(%ebp)
801003b1:	e8 ca 02 00 00       	call   80100680 <cprintf>
  cprintf("\n");
801003b6:	c7 04 24 66 7b 10 80 	movl   $0x80107b66,(%esp)
801003bd:	e8 be 02 00 00       	call   80100680 <cprintf>
  getcallerpcs(&s, pcs);
801003c2:	8d 45 08             	lea    0x8(%ebp),%eax
801003c5:	5a                   	pop    %edx
801003c6:	59                   	pop    %ecx
801003c7:	53                   	push   %ebx
801003c8:	50                   	push   %eax
801003c9:	e8 42 45 00 00       	call   80104910 <getcallerpcs>
  for(i=0; i<10; i++)
801003ce:	83 c4 10             	add    $0x10,%esp
801003d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003d8:	83 ec 08             	sub    $0x8,%esp
801003db:	ff 33                	pushl  (%ebx)
  for(i=0; i<10; i++)
801003dd:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003e0:	68 89 76 10 80       	push   $0x80107689
801003e5:	e8 96 02 00 00       	call   80100680 <cprintf>
  for(i=0; i<10; i++)
801003ea:	83 c4 10             	add    $0x10,%esp
801003ed:	39 f3                	cmp    %esi,%ebx
801003ef:	75 e7                	jne    801003d8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003f1:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f8:	00 00 00 
  for(;;)
801003fb:	eb fe                	jmp    801003fb <panic+0x7b>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <cgaputc>:
{
80100400:	55                   	push   %ebp
80100401:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100403:	b8 0e 00 00 00       	mov    $0xe,%eax
80100408:	89 e5                	mov    %esp,%ebp
8010040a:	57                   	push   %edi
8010040b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100410:	56                   	push   %esi
80100411:	89 fa                	mov    %edi,%edx
80100413:	53                   	push   %ebx
80100414:	83 ec 1c             	sub    $0x1c,%esp
80100417:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100418:	be d5 03 00 00       	mov    $0x3d5,%esi
8010041d:	89 f2                	mov    %esi,%edx
8010041f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100420:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100423:	89 fa                	mov    %edi,%edx
80100425:	c1 e0 08             	shl    $0x8,%eax
80100428:	89 c3                	mov    %eax,%ebx
8010042a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010042f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100430:	89 f2                	mov    %esi,%edx
80100432:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100433:	0f b6 c0             	movzbl %al,%eax
80100436:	09 d8                	or     %ebx,%eax
  if(c == '\n')
80100438:	83 f9 0a             	cmp    $0xa,%ecx
8010043b:	0f 84 97 00 00 00    	je     801004d8 <cgaputc+0xd8>
  else if(c == BACKSPACE){
80100441:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100447:	74 77                	je     801004c0 <cgaputc+0xc0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100449:	0f b6 c9             	movzbl %cl,%ecx
8010044c:	8d 58 01             	lea    0x1(%eax),%ebx
8010044f:	80 cd 07             	or     $0x7,%ch
80100452:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
80100459:	80 
  if(pos < 0 || pos > 25*80)
8010045a:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100460:	0f 8f cc 00 00 00    	jg     80100532 <cgaputc+0x132>
  if((pos/80) >= 24){  // Scroll up.
80100466:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010046c:	0f 8f 7e 00 00 00    	jg     801004f0 <cgaputc+0xf0>
  outb(CRTPORT+1, pos>>8);
80100472:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100475:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
80100477:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
8010047e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100481:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100486:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048b:	89 da                	mov    %ebx,%edx
8010048d:	ee                   	out    %al,(%dx)
8010048e:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100493:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80100497:	89 ca                	mov    %ecx,%edx
80100499:	ee                   	out    %al,(%dx)
8010049a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049f:	89 da                	mov    %ebx,%edx
801004a1:	ee                   	out    %al,(%dx)
801004a2:	89 f8                	mov    %edi,%eax
801004a4:	89 ca                	mov    %ecx,%edx
801004a6:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a7:	b8 20 07 00 00       	mov    $0x720,%eax
801004ac:	66 89 06             	mov    %ax,(%esi)
}
801004af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004b2:	5b                   	pop    %ebx
801004b3:	5e                   	pop    %esi
801004b4:	5f                   	pop    %edi
801004b5:	5d                   	pop    %ebp
801004b6:	c3                   	ret    
801004b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801004be:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004c0:	8d 58 ff             	lea    -0x1(%eax),%ebx
801004c3:	85 c0                	test   %eax,%eax
801004c5:	75 93                	jne    8010045a <cgaputc+0x5a>
801004c7:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004cb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004d0:	31 ff                	xor    %edi,%edi
801004d2:	eb ad                	jmp    80100481 <cgaputc+0x81>
801004d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004d8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004dd:	f7 e2                	mul    %edx
801004df:	c1 ea 06             	shr    $0x6,%edx
801004e2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004e5:	c1 e0 04             	shl    $0x4,%eax
801004e8:	8d 58 50             	lea    0x50(%eax),%ebx
801004eb:	e9 6a ff ff ff       	jmp    8010045a <cgaputc+0x5a>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f0:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004f3:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004f6:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fd:	68 60 0e 00 00       	push   $0xe60
80100502:	68 a0 80 0b 80       	push   $0x800b80a0
80100507:	68 00 80 0b 80       	push   $0x800b8000
8010050c:	e8 ff 45 00 00       	call   80104b10 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100511:	b8 80 07 00 00       	mov    $0x780,%eax
80100516:	83 c4 0c             	add    $0xc,%esp
80100519:	29 f8                	sub    %edi,%eax
8010051b:	01 c0                	add    %eax,%eax
8010051d:	50                   	push   %eax
8010051e:	6a 00                	push   $0x0
80100520:	56                   	push   %esi
80100521:	e8 4a 45 00 00       	call   80104a70 <memset>
  outb(CRTPORT+1, pos);
80100526:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010052a:	83 c4 10             	add    $0x10,%esp
8010052d:	e9 4f ff ff ff       	jmp    80100481 <cgaputc+0x81>
    panic("pos under/overflow");
80100532:	83 ec 0c             	sub    $0xc,%esp
80100535:	68 8d 76 10 80       	push   $0x8010768d
8010053a:	e8 41 fe ff ff       	call   80100380 <panic>
8010053f:	90                   	nop

80100540 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100540:	55                   	push   %ebp
80100541:	89 e5                	mov    %esp,%ebp
80100543:	57                   	push   %edi
80100544:	56                   	push   %esi
80100545:	53                   	push   %ebx
80100546:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100549:	ff 75 08             	pushl  0x8(%ebp)
{
8010054c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010054f:	e8 2c 14 00 00       	call   80101980 <iunlock>
  acquire(&cons.lock);
80100554:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
8010055b:	e8 e0 42 00 00       	call   80104840 <acquire>
  for(i = 0; i < n; i++)
80100560:	83 c4 10             	add    $0x10,%esp
80100563:	85 f6                	test   %esi,%esi
80100565:	7e 3a                	jle    801005a1 <consolewrite+0x61>
80100567:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010056a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
8010056d:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100573:	85 d2                	test   %edx,%edx
80100575:	74 09                	je     80100580 <consolewrite+0x40>
  asm volatile("cli");
80100577:	fa                   	cli    
    for(;;)
80100578:	eb fe                	jmp    80100578 <consolewrite+0x38>
8010057a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100580:	0f b6 03             	movzbl (%ebx),%eax
    uartputc(c);
80100583:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < n; i++)
80100586:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100589:	50                   	push   %eax
8010058a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010058d:	e8 fe 5b 00 00       	call   80106190 <uartputc>
  cgaputc(c);
80100592:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100595:	e8 66 fe ff ff       	call   80100400 <cgaputc>
  for(i = 0; i < n; i++)
8010059a:	83 c4 10             	add    $0x10,%esp
8010059d:	39 df                	cmp    %ebx,%edi
8010059f:	75 cc                	jne    8010056d <consolewrite+0x2d>
  release(&cons.lock);
801005a1:	83 ec 0c             	sub    $0xc,%esp
801005a4:	68 20 ff 10 80       	push   $0x8010ff20
801005a9:	e8 72 44 00 00       	call   80104a20 <release>
  ilock(ip);
801005ae:	58                   	pop    %eax
801005af:	ff 75 08             	pushl  0x8(%ebp)
801005b2:	e8 e9 12 00 00       	call   801018a0 <ilock>

  return n;
}
801005b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005ba:	89 f0                	mov    %esi,%eax
801005bc:	5b                   	pop    %ebx
801005bd:	5e                   	pop    %esi
801005be:	5f                   	pop    %edi
801005bf:	5d                   	pop    %ebp
801005c0:	c3                   	ret    
801005c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005cf:	90                   	nop

801005d0 <printint>:
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	83 ec 2c             	sub    $0x2c,%esp
801005d9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801005dc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
801005df:	85 c9                	test   %ecx,%ecx
801005e1:	74 04                	je     801005e7 <printint+0x17>
801005e3:	85 c0                	test   %eax,%eax
801005e5:	78 7e                	js     80100665 <printint+0x95>
    x = xx;
801005e7:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
801005ee:	89 c1                	mov    %eax,%ecx
  i = 0;
801005f0:	31 db                	xor    %ebx,%ebx
801005f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
801005f8:	89 c8                	mov    %ecx,%eax
801005fa:	31 d2                	xor    %edx,%edx
801005fc:	89 de                	mov    %ebx,%esi
801005fe:	89 cf                	mov    %ecx,%edi
80100600:	f7 75 d4             	divl   -0x2c(%ebp)
80100603:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100606:	0f b6 92 b8 76 10 80 	movzbl -0x7fef8948(%edx),%edx
  }while((x /= base) != 0);
8010060d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010060f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100613:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100616:	73 e0                	jae    801005f8 <printint+0x28>
  if(sign)
80100618:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010061b:	85 c9                	test   %ecx,%ecx
8010061d:	74 0c                	je     8010062b <printint+0x5b>
    buf[i++] = '-';
8010061f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100624:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100626:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010062b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
  if(panicked){
8010062f:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100634:	85 c0                	test   %eax,%eax
80100636:	74 08                	je     80100640 <printint+0x70>
80100638:	fa                   	cli    
    for(;;)
80100639:	eb fe                	jmp    80100639 <printint+0x69>
8010063b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010063f:	90                   	nop
    consputc(buf[i]);
80100640:	0f be f2             	movsbl %dl,%esi
    uartputc(c);
80100643:	83 ec 0c             	sub    $0xc,%esp
80100646:	56                   	push   %esi
80100647:	e8 44 5b 00 00       	call   80106190 <uartputc>
  cgaputc(c);
8010064c:	89 f0                	mov    %esi,%eax
8010064e:	e8 ad fd ff ff       	call   80100400 <cgaputc>
  while(--i >= 0)
80100653:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100656:	83 c4 10             	add    $0x10,%esp
80100659:	39 c3                	cmp    %eax,%ebx
8010065b:	74 0e                	je     8010066b <printint+0x9b>
    consputc(buf[i]);
8010065d:	0f b6 13             	movzbl (%ebx),%edx
80100660:	83 eb 01             	sub    $0x1,%ebx
80100663:	eb ca                	jmp    8010062f <printint+0x5f>
    x = -xx;
80100665:	f7 d8                	neg    %eax
80100667:	89 c1                	mov    %eax,%ecx
80100669:	eb 85                	jmp    801005f0 <printint+0x20>
}
8010066b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010066e:	5b                   	pop    %ebx
8010066f:	5e                   	pop    %esi
80100670:	5f                   	pop    %edi
80100671:	5d                   	pop    %ebp
80100672:	c3                   	ret    
80100673:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010067a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100680 <cprintf>:
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100689:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
8010068e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
80100691:	85 c0                	test   %eax,%eax
80100693:	0f 85 37 01 00 00    	jne    801007d0 <cprintf+0x150>
  if (fmt == 0)
80100699:	8b 75 08             	mov    0x8(%ebp),%esi
8010069c:	85 f6                	test   %esi,%esi
8010069e:	0f 84 3f 02 00 00    	je     801008e3 <cprintf+0x263>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006a4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006a7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006aa:	31 db                	xor    %ebx,%ebx
801006ac:	85 c0                	test   %eax,%eax
801006ae:	74 56                	je     80100706 <cprintf+0x86>
    if(c != '%'){
801006b0:	83 f8 25             	cmp    $0x25,%eax
801006b3:	0f 85 d7 00 00 00    	jne    80100790 <cprintf+0x110>
    c = fmt[++i] & 0xff;
801006b9:	83 c3 01             	add    $0x1,%ebx
801006bc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006c0:	85 d2                	test   %edx,%edx
801006c2:	74 42                	je     80100706 <cprintf+0x86>
    switch(c){
801006c4:	83 fa 70             	cmp    $0x70,%edx
801006c7:	0f 84 94 00 00 00    	je     80100761 <cprintf+0xe1>
801006cd:	7f 51                	jg     80100720 <cprintf+0xa0>
801006cf:	83 fa 25             	cmp    $0x25,%edx
801006d2:	0f 84 48 01 00 00    	je     80100820 <cprintf+0x1a0>
801006d8:	83 fa 64             	cmp    $0x64,%edx
801006db:	0f 85 04 01 00 00    	jne    801007e5 <cprintf+0x165>
      printint(*argp++, 10, 1);
801006e1:	8d 47 04             	lea    0x4(%edi),%eax
801006e4:	b9 01 00 00 00       	mov    $0x1,%ecx
801006e9:	ba 0a 00 00 00       	mov    $0xa,%edx
801006ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006f1:	8b 07                	mov    (%edi),%eax
801006f3:	e8 d8 fe ff ff       	call   801005d0 <printint>
801006f8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fb:	83 c3 01             	add    $0x1,%ebx
801006fe:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100702:	85 c0                	test   %eax,%eax
80100704:	75 aa                	jne    801006b0 <cprintf+0x30>
  if(locking)
80100706:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100709:	85 c0                	test   %eax,%eax
8010070b:	0f 85 b5 01 00 00    	jne    801008c6 <cprintf+0x246>
}
80100711:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100714:	5b                   	pop    %ebx
80100715:	5e                   	pop    %esi
80100716:	5f                   	pop    %edi
80100717:	5d                   	pop    %ebp
80100718:	c3                   	ret    
80100719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	75 33                	jne    80100758 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100725:	8d 47 04             	lea    0x4(%edi),%eax
80100728:	8b 3f                	mov    (%edi),%edi
8010072a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010072d:	85 ff                	test   %edi,%edi
8010072f:	0f 85 33 01 00 00    	jne    80100868 <cprintf+0x1e8>
        s = "(null)";
80100735:	bf a0 76 10 80       	mov    $0x801076a0,%edi
      for(; *s; s++)
8010073a:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010073d:	b8 28 00 00 00       	mov    $0x28,%eax
80100742:	89 fb                	mov    %edi,%ebx
  if(panicked){
80100744:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010074a:	85 d2                	test   %edx,%edx
8010074c:	0f 84 27 01 00 00    	je     80100879 <cprintf+0x1f9>
80100752:	fa                   	cli    
    for(;;)
80100753:	eb fe                	jmp    80100753 <cprintf+0xd3>
80100755:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100758:	83 fa 78             	cmp    $0x78,%edx
8010075b:	0f 85 84 00 00 00    	jne    801007e5 <cprintf+0x165>
      printint(*argp++, 16, 0);
80100761:	8d 47 04             	lea    0x4(%edi),%eax
80100764:	31 c9                	xor    %ecx,%ecx
80100766:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010076b:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010076e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100771:	8b 07                	mov    (%edi),%eax
80100773:	e8 58 fe ff ff       	call   801005d0 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100778:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
8010077c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010077f:	85 c0                	test   %eax,%eax
80100781:	0f 85 29 ff ff ff    	jne    801006b0 <cprintf+0x30>
80100787:	e9 7a ff ff ff       	jmp    80100706 <cprintf+0x86>
8010078c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100790:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100796:	85 c9                	test   %ecx,%ecx
80100798:	74 06                	je     801007a0 <cprintf+0x120>
8010079a:	fa                   	cli    
    for(;;)
8010079b:	eb fe                	jmp    8010079b <cprintf+0x11b>
8010079d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
801007a0:	83 ec 0c             	sub    $0xc,%esp
801007a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007a6:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
801007a9:	50                   	push   %eax
801007aa:	e8 e1 59 00 00       	call   80106190 <uartputc>
  cgaputc(c);
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	e8 49 fc ff ff       	call   80100400 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b7:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      continue;
801007bb:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007be:	85 c0                	test   %eax,%eax
801007c0:	0f 85 ea fe ff ff    	jne    801006b0 <cprintf+0x30>
801007c6:	e9 3b ff ff ff       	jmp    80100706 <cprintf+0x86>
801007cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007cf:	90                   	nop
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 20 ff 10 80       	push   $0x8010ff20
801007d8:	e8 63 40 00 00       	call   80104840 <acquire>
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	e9 b4 fe ff ff       	jmp    80100699 <cprintf+0x19>
  if(panicked){
801007e5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007eb:	85 c9                	test   %ecx,%ecx
801007ed:	75 71                	jne    80100860 <cprintf+0x1e0>
    uartputc(c);
801007ef:	83 ec 0c             	sub    $0xc,%esp
801007f2:	89 55 e0             	mov    %edx,-0x20(%ebp)
801007f5:	6a 25                	push   $0x25
801007f7:	e8 94 59 00 00       	call   80106190 <uartputc>
  cgaputc(c);
801007fc:	b8 25 00 00 00       	mov    $0x25,%eax
80100801:	e8 fa fb ff ff       	call   80100400 <cgaputc>
  if(panicked){
80100806:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010080c:	83 c4 10             	add    $0x10,%esp
8010080f:	85 d2                	test   %edx,%edx
80100811:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100814:	0f 84 8e 00 00 00    	je     801008a8 <cprintf+0x228>
8010081a:	fa                   	cli    
    for(;;)
8010081b:	eb fe                	jmp    8010081b <cprintf+0x19b>
8010081d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100820:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100825:	85 c0                	test   %eax,%eax
80100827:	74 07                	je     80100830 <cprintf+0x1b0>
80100829:	fa                   	cli    
    for(;;)
8010082a:	eb fe                	jmp    8010082a <cprintf+0x1aa>
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100830:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100833:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100836:	6a 25                	push   $0x25
80100838:	e8 53 59 00 00       	call   80106190 <uartputc>
  cgaputc(c);
8010083d:	b8 25 00 00 00       	mov    $0x25,%eax
80100842:	e8 b9 fb ff ff       	call   80100400 <cgaputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100847:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
}
8010084b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010084e:	85 c0                	test   %eax,%eax
80100850:	0f 85 5a fe ff ff    	jne    801006b0 <cprintf+0x30>
80100856:	e9 ab fe ff ff       	jmp    80100706 <cprintf+0x86>
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop
80100860:	fa                   	cli    
    for(;;)
80100861:	eb fe                	jmp    80100861 <cprintf+0x1e1>
80100863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100867:	90                   	nop
      for(; *s; s++)
80100868:	0f b6 07             	movzbl (%edi),%eax
8010086b:	84 c0                	test   %al,%al
8010086d:	74 6c                	je     801008db <cprintf+0x25b>
8010086f:	89 5d dc             	mov    %ebx,-0x24(%ebp)
80100872:	89 fb                	mov    %edi,%ebx
80100874:	e9 cb fe ff ff       	jmp    80100744 <cprintf+0xc4>
    uartputc(c);
80100879:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
8010087c:	0f be f8             	movsbl %al,%edi
      for(; *s; s++)
8010087f:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100882:	57                   	push   %edi
80100883:	e8 08 59 00 00       	call   80106190 <uartputc>
  cgaputc(c);
80100888:	89 f8                	mov    %edi,%eax
8010088a:	e8 71 fb ff ff       	call   80100400 <cgaputc>
      for(; *s; s++)
8010088f:	0f b6 03             	movzbl (%ebx),%eax
80100892:	83 c4 10             	add    $0x10,%esp
80100895:	84 c0                	test   %al,%al
80100897:	0f 85 a7 fe ff ff    	jne    80100744 <cprintf+0xc4>
      if((s = (char*)*argp++) == 0)
8010089d:	8b 5d dc             	mov    -0x24(%ebp),%ebx
801008a0:	8b 7d e0             	mov    -0x20(%ebp),%edi
801008a3:	e9 53 fe ff ff       	jmp    801006fb <cprintf+0x7b>
    uartputc(c);
801008a8:	83 ec 0c             	sub    $0xc,%esp
801008ab:	89 55 e0             	mov    %edx,-0x20(%ebp)
801008ae:	52                   	push   %edx
801008af:	e8 dc 58 00 00       	call   80106190 <uartputc>
  cgaputc(c);
801008b4:	8b 55 e0             	mov    -0x20(%ebp),%edx
801008b7:	89 d0                	mov    %edx,%eax
801008b9:	e8 42 fb ff ff       	call   80100400 <cgaputc>
}
801008be:	83 c4 10             	add    $0x10,%esp
801008c1:	e9 35 fe ff ff       	jmp    801006fb <cprintf+0x7b>
    release(&cons.lock);
801008c6:	83 ec 0c             	sub    $0xc,%esp
801008c9:	68 20 ff 10 80       	push   $0x8010ff20
801008ce:	e8 4d 41 00 00       	call   80104a20 <release>
801008d3:	83 c4 10             	add    $0x10,%esp
}
801008d6:	e9 36 fe ff ff       	jmp    80100711 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
801008db:	8b 7d e0             	mov    -0x20(%ebp),%edi
801008de:	e9 18 fe ff ff       	jmp    801006fb <cprintf+0x7b>
    panic("null fmt");
801008e3:	83 ec 0c             	sub    $0xc,%esp
801008e6:	68 a7 76 10 80       	push   $0x801076a7
801008eb:	e8 90 fa ff ff       	call   80100380 <panic>

801008f0 <consoleintr>:
{
801008f0:	55                   	push   %ebp
801008f1:	89 e5                	mov    %esp,%ebp
801008f3:	57                   	push   %edi
801008f4:	56                   	push   %esi
801008f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801008f6:	31 db                	xor    %ebx,%ebx
{
801008f8:	83 ec 28             	sub    $0x28,%esp
801008fb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008fe:	68 20 ff 10 80       	push   $0x8010ff20
80100903:	e8 38 3f 00 00       	call   80104840 <acquire>
  while((c = getc()) >= 0){
80100908:	83 c4 10             	add    $0x10,%esp
8010090b:	eb 1a                	jmp    80100927 <consoleintr+0x37>
8010090d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100910:	83 f8 08             	cmp    $0x8,%eax
80100913:	0f 84 17 01 00 00    	je     80100a30 <consoleintr+0x140>
80100919:	83 f8 10             	cmp    $0x10,%eax
8010091c:	0f 85 9a 01 00 00    	jne    80100abc <consoleintr+0x1cc>
80100922:	bb 01 00 00 00       	mov    $0x1,%ebx
  while((c = getc()) >= 0){
80100927:	ff d6                	call   *%esi
80100929:	85 c0                	test   %eax,%eax
8010092b:	0f 88 6f 01 00 00    	js     80100aa0 <consoleintr+0x1b0>
    switch(c){
80100931:	83 f8 15             	cmp    $0x15,%eax
80100934:	0f 84 b6 00 00 00    	je     801009f0 <consoleintr+0x100>
8010093a:	7e d4                	jle    80100910 <consoleintr+0x20>
8010093c:	83 f8 7f             	cmp    $0x7f,%eax
8010093f:	0f 84 eb 00 00 00    	je     80100a30 <consoleintr+0x140>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100945:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
8010094b:	89 d1                	mov    %edx,%ecx
8010094d:	2b 0d 00 ff 10 80    	sub    0x8010ff00,%ecx
80100953:	83 f9 7f             	cmp    $0x7f,%ecx
80100956:	77 cf                	ja     80100927 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
80100958:	89 d1                	mov    %edx,%ecx
8010095a:	83 c2 01             	add    $0x1,%edx
  if(panicked){
8010095d:	8b 3d 58 ff 10 80    	mov    0x8010ff58,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100963:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100969:	83 e1 7f             	and    $0x7f,%ecx
        c = (c == '\r') ? '\n' : c;
8010096c:	83 f8 0d             	cmp    $0xd,%eax
8010096f:	0f 84 9b 01 00 00    	je     80100b10 <consoleintr+0x220>
        input.buf[input.e++ % INPUT_BUF] = c;
80100975:	88 81 80 fe 10 80    	mov    %al,-0x7fef0180(%ecx)
  if(panicked){
8010097b:	85 ff                	test   %edi,%edi
8010097d:	0f 85 98 01 00 00    	jne    80100b1b <consoleintr+0x22b>
  if(c == BACKSPACE){
80100983:	3d 00 01 00 00       	cmp    $0x100,%eax
80100988:	0f 85 b3 01 00 00    	jne    80100b41 <consoleintr+0x251>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010098e:	83 ec 0c             	sub    $0xc,%esp
80100991:	6a 08                	push   $0x8
80100993:	e8 f8 57 00 00       	call   80106190 <uartputc>
80100998:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010099f:	e8 ec 57 00 00       	call   80106190 <uartputc>
801009a4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801009ab:	e8 e0 57 00 00       	call   80106190 <uartputc>
  cgaputc(c);
801009b0:	b8 00 01 00 00       	mov    $0x100,%eax
801009b5:	e8 46 fa ff ff       	call   80100400 <cgaputc>
801009ba:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009bd:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801009c2:	83 e8 80             	sub    $0xffffff80,%eax
801009c5:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
801009cb:	0f 85 56 ff ff ff    	jne    80100927 <consoleintr+0x37>
          wakeup(&input.r);
801009d1:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801009d4:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
801009d9:	68 00 ff 10 80       	push   $0x8010ff00
801009de:	e8 bd 38 00 00       	call   801042a0 <wakeup>
801009e3:	83 c4 10             	add    $0x10,%esp
801009e6:	e9 3c ff ff ff       	jmp    80100927 <consoleintr+0x37>
801009eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009ef:	90                   	nop
      while(input.e != input.w &&
801009f0:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009f5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009fb:	0f 84 26 ff ff ff    	je     80100927 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a01:	83 e8 01             	sub    $0x1,%eax
80100a04:	89 c2                	mov    %eax,%edx
80100a06:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a09:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100a10:	0f 84 11 ff ff ff    	je     80100927 <consoleintr+0x37>
  if(panicked){
80100a16:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
80100a1c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100a21:	85 d2                	test   %edx,%edx
80100a23:	74 33                	je     80100a58 <consoleintr+0x168>
80100a25:	fa                   	cli    
    for(;;)
80100a26:	eb fe                	jmp    80100a26 <consoleintr+0x136>
80100a28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a2f:	90                   	nop
      if(input.e != input.w){
80100a30:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a35:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100a3b:	0f 84 e6 fe ff ff    	je     80100927 <consoleintr+0x37>
        input.e--;
80100a41:	83 e8 01             	sub    $0x1,%eax
80100a44:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100a49:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100a4e:	85 c0                	test   %eax,%eax
80100a50:	74 7e                	je     80100ad0 <consoleintr+0x1e0>
80100a52:	fa                   	cli    
    for(;;)
80100a53:	eb fe                	jmp    80100a53 <consoleintr+0x163>
80100a55:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100a58:	83 ec 0c             	sub    $0xc,%esp
80100a5b:	6a 08                	push   $0x8
80100a5d:	e8 2e 57 00 00       	call   80106190 <uartputc>
80100a62:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a69:	e8 22 57 00 00       	call   80106190 <uartputc>
80100a6e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a75:	e8 16 57 00 00       	call   80106190 <uartputc>
  cgaputc(c);
80100a7a:	b8 00 01 00 00       	mov    $0x100,%eax
80100a7f:	e8 7c f9 ff ff       	call   80100400 <cgaputc>
      while(input.e != input.w &&
80100a84:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a89:	83 c4 10             	add    $0x10,%esp
80100a8c:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100a92:	0f 85 69 ff ff ff    	jne    80100a01 <consoleintr+0x111>
80100a98:	e9 8a fe ff ff       	jmp    80100927 <consoleintr+0x37>
80100a9d:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
80100aa0:	83 ec 0c             	sub    $0xc,%esp
80100aa3:	68 20 ff 10 80       	push   $0x8010ff20
80100aa8:	e8 73 3f 00 00       	call   80104a20 <release>
  if(doprocdump) {
80100aad:	83 c4 10             	add    $0x10,%esp
80100ab0:	85 db                	test   %ebx,%ebx
80100ab2:	75 50                	jne    80100b04 <consoleintr+0x214>
}
80100ab4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ab7:	5b                   	pop    %ebx
80100ab8:	5e                   	pop    %esi
80100ab9:	5f                   	pop    %edi
80100aba:	5d                   	pop    %ebp
80100abb:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100abc:	85 c0                	test   %eax,%eax
80100abe:	0f 84 63 fe ff ff    	je     80100927 <consoleintr+0x37>
80100ac4:	e9 7c fe ff ff       	jmp    80100945 <consoleintr+0x55>
80100ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100ad0:	83 ec 0c             	sub    $0xc,%esp
80100ad3:	6a 08                	push   $0x8
80100ad5:	e8 b6 56 00 00       	call   80106190 <uartputc>
80100ada:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100ae1:	e8 aa 56 00 00       	call   80106190 <uartputc>
80100ae6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100aed:	e8 9e 56 00 00       	call   80106190 <uartputc>
  cgaputc(c);
80100af2:	b8 00 01 00 00       	mov    $0x100,%eax
80100af7:	e8 04 f9 ff ff       	call   80100400 <cgaputc>
}
80100afc:	83 c4 10             	add    $0x10,%esp
80100aff:	e9 23 fe ff ff       	jmp    80100927 <consoleintr+0x37>
}
80100b04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b07:	5b                   	pop    %ebx
80100b08:	5e                   	pop    %esi
80100b09:	5f                   	pop    %edi
80100b0a:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100b0b:	e9 70 38 00 00       	jmp    80104380 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b10:	c6 81 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%ecx)
  if(panicked){
80100b17:	85 ff                	test   %edi,%edi
80100b19:	74 05                	je     80100b20 <consoleintr+0x230>
80100b1b:	fa                   	cli    
    for(;;)
80100b1c:	eb fe                	jmp    80100b1c <consoleintr+0x22c>
80100b1e:	66 90                	xchg   %ax,%ax
    uartputc(c);
80100b20:	83 ec 0c             	sub    $0xc,%esp
80100b23:	6a 0a                	push   $0xa
80100b25:	e8 66 56 00 00       	call   80106190 <uartputc>
  cgaputc(c);
80100b2a:	b8 0a 00 00 00       	mov    $0xa,%eax
80100b2f:	e8 cc f8 ff ff       	call   80100400 <cgaputc>
          input.w = input.e;
80100b34:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100b39:	83 c4 10             	add    $0x10,%esp
80100b3c:	e9 90 fe ff ff       	jmp    801009d1 <consoleintr+0xe1>
    uartputc(c);
80100b41:	83 ec 0c             	sub    $0xc,%esp
80100b44:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100b47:	50                   	push   %eax
80100b48:	e8 43 56 00 00       	call   80106190 <uartputc>
  cgaputc(c);
80100b4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100b50:	e8 ab f8 ff ff       	call   80100400 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100b58:	83 c4 10             	add    $0x10,%esp
80100b5b:	83 f8 0a             	cmp    $0xa,%eax
80100b5e:	74 09                	je     80100b69 <consoleintr+0x279>
80100b60:	83 f8 04             	cmp    $0x4,%eax
80100b63:	0f 85 54 fe ff ff    	jne    801009bd <consoleintr+0xcd>
          input.w = input.e;
80100b69:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100b6e:	e9 5e fe ff ff       	jmp    801009d1 <consoleintr+0xe1>
80100b73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100b80 <consoleinit>:

void
consoleinit(void)
{
80100b80:	55                   	push   %ebp
80100b81:	89 e5                	mov    %esp,%ebp
80100b83:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b86:	68 b0 76 10 80       	push   $0x801076b0
80100b8b:	68 20 ff 10 80       	push   $0x8010ff20
80100b90:	e8 8b 3c 00 00       	call   80104820 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
80100b95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100b9c:	c7 05 0c 09 11 80 40 	movl   $0x80100540,0x8011090c
80100ba3:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100ba6:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100bad:	02 10 80 
  cons.locking = 1;
80100bb0:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100bb7:	00 00 00 
  picenable(IRQ_KBD);
80100bba:	e8 31 2a 00 00       	call   801035f0 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100bbf:	58                   	pop    %eax
80100bc0:	5a                   	pop    %edx
80100bc1:	6a 00                	push   $0x0
80100bc3:	6a 01                	push   $0x1
80100bc5:	e8 e6 19 00 00       	call   801025b0 <ioapicenable>
}
80100bca:	83 c4 10             	add    $0x10,%esp
80100bcd:	c9                   	leave  
80100bce:	c3                   	ret    
80100bcf:	90                   	nop

80100bd0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bd0:	55                   	push   %ebp
80100bd1:	89 e5                	mov    %esp,%ebp
80100bd3:	57                   	push   %edi
80100bd4:	56                   	push   %esi
80100bd5:	53                   	push   %ebx
80100bd6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100bdc:	e8 1f 23 00 00       	call   80102f00 <begin_op>

  if((ip = namei(path)) == 0){
80100be1:	83 ec 0c             	sub    $0xc,%esp
80100be4:	ff 75 08             	pushl  0x8(%ebp)
80100be7:	e8 b4 15 00 00       	call   801021a0 <namei>
80100bec:	83 c4 10             	add    $0x10,%esp
80100bef:	85 c0                	test   %eax,%eax
80100bf1:	0f 84 0a 03 00 00    	je     80100f01 <exec+0x331>
    end_op();
    return -1;
  }
  ilock(ip);
80100bf7:	83 ec 0c             	sub    $0xc,%esp
80100bfa:	89 c3                	mov    %eax,%ebx
80100bfc:	50                   	push   %eax
80100bfd:	e8 9e 0c 00 00       	call   801018a0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100c02:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100c08:	6a 34                	push   $0x34
80100c0a:	6a 00                	push   $0x0
80100c0c:	50                   	push   %eax
80100c0d:	53                   	push   %ebx
80100c0e:	e8 7d 0f 00 00       	call   80101b90 <readi>
80100c13:	83 c4 20             	add    $0x20,%esp
80100c16:	83 f8 33             	cmp    $0x33,%eax
80100c19:	76 0c                	jbe    80100c27 <exec+0x57>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c1b:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100c22:	45 4c 46 
80100c25:	74 21                	je     80100c48 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100c27:	83 ec 0c             	sub    $0xc,%esp
80100c2a:	53                   	push   %ebx
80100c2b:	e8 e0 0e 00 00       	call   80101b10 <iunlockput>
    end_op();
80100c30:	e8 3b 23 00 00       	call   80102f70 <end_op>
80100c35:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100c38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c40:	5b                   	pop    %ebx
80100c41:	5e                   	pop    %esi
80100c42:	5f                   	pop    %edi
80100c43:	5d                   	pop    %ebp
80100c44:	c3                   	ret    
80100c45:	8d 76 00             	lea    0x0(%esi),%esi
  if((pgdir = setupkvm()) == 0)
80100c48:	e8 b3 62 00 00       	call   80106f00 <setupkvm>
80100c4d:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100c53:	85 c0                	test   %eax,%eax
80100c55:	74 d0                	je     80100c27 <exec+0x57>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c57:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c5e:	00 
80100c5f:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c65:	0f 84 a5 02 00 00    	je     80100f10 <exec+0x340>
  sz = 0;
80100c6b:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100c72:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c75:	31 ff                	xor    %edi,%edi
80100c77:	e9 8a 00 00 00       	jmp    80100d06 <exec+0x136>
80100c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100c80:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c87:	75 6c                	jne    80100cf5 <exec+0x125>
    if(ph.memsz < ph.filesz)
80100c89:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c8f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100c95:	0f 82 87 00 00 00    	jb     80100d22 <exec+0x152>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c9b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ca1:	72 7f                	jb     80100d22 <exec+0x152>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ca3:	83 ec 04             	sub    $0x4,%esp
80100ca6:	50                   	push   %eax
80100ca7:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100cad:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100cb3:	e8 f8 64 00 00       	call   801071b0 <allocuvm>
80100cb8:	83 c4 10             	add    $0x10,%esp
80100cbb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100cc1:	85 c0                	test   %eax,%eax
80100cc3:	74 5d                	je     80100d22 <exec+0x152>
    if(ph.vaddr % PGSIZE != 0)
80100cc5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ccb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100cd0:	75 50                	jne    80100d22 <exec+0x152>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100cd2:	83 ec 0c             	sub    $0xc,%esp
80100cd5:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100cdb:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100ce1:	53                   	push   %ebx
80100ce2:	50                   	push   %eax
80100ce3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ce9:	e8 d2 63 00 00       	call   801070c0 <loaduvm>
80100cee:	83 c4 20             	add    $0x20,%esp
80100cf1:	85 c0                	test   %eax,%eax
80100cf3:	78 2d                	js     80100d22 <exec+0x152>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cf5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100cfc:	83 c7 01             	add    $0x1,%edi
80100cff:	83 c6 20             	add    $0x20,%esi
80100d02:	39 f8                	cmp    %edi,%eax
80100d04:	7e 3a                	jle    80100d40 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100d06:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100d0c:	6a 20                	push   $0x20
80100d0e:	56                   	push   %esi
80100d0f:	50                   	push   %eax
80100d10:	53                   	push   %ebx
80100d11:	e8 7a 0e 00 00       	call   80101b90 <readi>
80100d16:	83 c4 10             	add    $0x10,%esp
80100d19:	83 f8 20             	cmp    $0x20,%eax
80100d1c:	0f 84 5e ff ff ff    	je     80100c80 <exec+0xb0>
    freevm(pgdir);
80100d22:	83 ec 0c             	sub    $0xc,%esp
80100d25:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100d2b:	e8 e0 65 00 00       	call   80107310 <freevm>
  if(ip){
80100d30:	83 c4 10             	add    $0x10,%esp
80100d33:	e9 ef fe ff ff       	jmp    80100c27 <exec+0x57>
80100d38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100d3f:	90                   	nop
  sz = PGROUNDUP(sz);
80100d40:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d46:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100d4c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d52:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100d58:	83 ec 0c             	sub    $0xc,%esp
80100d5b:	53                   	push   %ebx
80100d5c:	e8 af 0d 00 00       	call   80101b10 <iunlockput>
  end_op();
80100d61:	e8 0a 22 00 00       	call   80102f70 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d66:	83 c4 0c             	add    $0xc,%esp
80100d69:	56                   	push   %esi
80100d6a:	57                   	push   %edi
80100d6b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100d71:	57                   	push   %edi
80100d72:	e8 39 64 00 00       	call   801071b0 <allocuvm>
80100d77:	83 c4 10             	add    $0x10,%esp
80100d7a:	89 c6                	mov    %eax,%esi
80100d7c:	85 c0                	test   %eax,%eax
80100d7e:	0f 84 94 00 00 00    	je     80100e18 <exec+0x248>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d84:	83 ec 08             	sub    $0x8,%esp
80100d87:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100d8d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d8f:	50                   	push   %eax
80100d90:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100d91:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d93:	e8 f8 65 00 00       	call   80107390 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100d98:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d9b:	83 c4 10             	add    $0x10,%esp
80100d9e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100da4:	8b 00                	mov    (%eax),%eax
80100da6:	85 c0                	test   %eax,%eax
80100da8:	0f 84 8b 00 00 00    	je     80100e39 <exec+0x269>
80100dae:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100db4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100dba:	eb 23                	jmp    80100ddf <exec+0x20f>
80100dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100dc0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100dc3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100dca:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100dcd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100dd3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100dd6:	85 c0                	test   %eax,%eax
80100dd8:	74 59                	je     80100e33 <exec+0x263>
    if(argc >= MAXARG)
80100dda:	83 ff 20             	cmp    $0x20,%edi
80100ddd:	74 39                	je     80100e18 <exec+0x248>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ddf:	83 ec 0c             	sub    $0xc,%esp
80100de2:	50                   	push   %eax
80100de3:	e8 88 3e 00 00       	call   80104c70 <strlen>
80100de8:	f7 d0                	not    %eax
80100dea:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dec:	58                   	pop    %eax
80100ded:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100df0:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100df3:	ff 34 b8             	pushl  (%eax,%edi,4)
80100df6:	e8 75 3e 00 00       	call   80104c70 <strlen>
80100dfb:	83 c0 01             	add    $0x1,%eax
80100dfe:	50                   	push   %eax
80100dff:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e02:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e05:	53                   	push   %ebx
80100e06:	56                   	push   %esi
80100e07:	e8 44 67 00 00       	call   80107550 <copyout>
80100e0c:	83 c4 20             	add    $0x20,%esp
80100e0f:	85 c0                	test   %eax,%eax
80100e11:	79 ad                	jns    80100dc0 <exec+0x1f0>
80100e13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e17:	90                   	nop
    freevm(pgdir);
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100e21:	e8 ea 64 00 00       	call   80107310 <freevm>
80100e26:	83 c4 10             	add    $0x10,%esp
  return -1;
80100e29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100e2e:	e9 0a fe ff ff       	jmp    80100c3d <exec+0x6d>
80100e33:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e39:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e40:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100e42:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100e49:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e4d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100e4f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100e52:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100e58:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e5a:	50                   	push   %eax
80100e5b:	52                   	push   %edx
80100e5c:	53                   	push   %ebx
80100e5d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100e63:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e6a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e6d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e73:	e8 d8 66 00 00       	call   80107550 <copyout>
80100e78:	83 c4 10             	add    $0x10,%esp
80100e7b:	85 c0                	test   %eax,%eax
80100e7d:	78 99                	js     80100e18 <exec+0x248>
  for(last=s=path; *s; s++)
80100e7f:	8b 45 08             	mov    0x8(%ebp),%eax
80100e82:	8b 55 08             	mov    0x8(%ebp),%edx
80100e85:	0f b6 00             	movzbl (%eax),%eax
80100e88:	84 c0                	test   %al,%al
80100e8a:	74 13                	je     80100e9f <exec+0x2cf>
80100e8c:	89 d1                	mov    %edx,%ecx
80100e8e:	66 90                	xchg   %ax,%ax
      last = s+1;
80100e90:	83 c1 01             	add    $0x1,%ecx
80100e93:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100e95:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100e98:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100e9b:	84 c0                	test   %al,%al
80100e9d:	75 f1                	jne    80100e90 <exec+0x2c0>
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e9f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea5:	83 ec 04             	sub    $0x4,%esp
80100ea8:	6a 10                	push   $0x10
80100eaa:	83 c0 6c             	add    $0x6c,%eax
80100ead:	52                   	push   %edx
80100eae:	50                   	push   %eax
80100eaf:	e8 7c 3d 00 00       	call   80104c30 <safestrcpy>
  oldpgdir = proc->pgdir;
80100eb4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100eba:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = proc->pgdir;
80100ec0:	8b 78 04             	mov    0x4(%eax),%edi
  proc->sz = sz;
80100ec3:	89 30                	mov    %esi,(%eax)
  proc->pgdir = pgdir;
80100ec5:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->tf->eip = elf.entry;  // main
80100ec8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ece:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100ed4:	8b 50 18             	mov    0x18(%eax),%edx
80100ed7:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100eda:	8b 50 18             	mov    0x18(%eax),%edx
80100edd:	89 5a 44             	mov    %ebx,0x44(%edx)
  proc->priority = 3;
80100ee0:	c7 40 7c 03 00 00 00 	movl   $0x3,0x7c(%eax)
  switchuvm(proc);
80100ee7:	89 04 24             	mov    %eax,(%esp)
80100eea:	e8 b1 60 00 00       	call   80106fa0 <switchuvm>
  freevm(oldpgdir);
80100eef:	89 3c 24             	mov    %edi,(%esp)
80100ef2:	e8 19 64 00 00       	call   80107310 <freevm>
  return 0;
80100ef7:	83 c4 10             	add    $0x10,%esp
80100efa:	31 c0                	xor    %eax,%eax
80100efc:	e9 3c fd ff ff       	jmp    80100c3d <exec+0x6d>
    end_op();
80100f01:	e8 6a 20 00 00       	call   80102f70 <end_op>
    return -1;
80100f06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f0b:	e9 2d fd ff ff       	jmp    80100c3d <exec+0x6d>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f10:	31 ff                	xor    %edi,%edi
80100f12:	be 00 20 00 00       	mov    $0x2000,%esi
80100f17:	e9 3c fe ff ff       	jmp    80100d58 <exec+0x188>
80100f1c:	66 90                	xchg   %ax,%ax
80100f1e:	66 90                	xchg   %ax,%ax

80100f20 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f26:	68 c9 76 10 80       	push   $0x801076c9
80100f2b:	68 60 ff 10 80       	push   $0x8010ff60
80100f30:	e8 eb 38 00 00       	call   80104820 <initlock>
}
80100f35:	83 c4 10             	add    $0x10,%esp
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f44:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100f49:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f4c:	68 60 ff 10 80       	push   $0x8010ff60
80100f51:	e8 ea 38 00 00       	call   80104840 <acquire>
80100f56:	83 c4 10             	add    $0x10,%esp
80100f59:	eb 10                	jmp    80100f6b <filealloc+0x2b>
80100f5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f5f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f60:	83 c3 18             	add    $0x18,%ebx
80100f63:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100f69:	74 25                	je     80100f90 <filealloc+0x50>
    if(f->ref == 0){
80100f6b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f6e:	85 c0                	test   %eax,%eax
80100f70:	75 ee                	jne    80100f60 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f72:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f75:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f7c:	68 60 ff 10 80       	push   $0x8010ff60
80100f81:	e8 9a 3a 00 00       	call   80104a20 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f86:	89 d8                	mov    %ebx,%eax
      return f;
80100f88:	83 c4 10             	add    $0x10,%esp
}
80100f8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f8e:	c9                   	leave  
80100f8f:	c3                   	ret    
  release(&ftable.lock);
80100f90:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f93:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f95:	68 60 ff 10 80       	push   $0x8010ff60
80100f9a:	e8 81 3a 00 00       	call   80104a20 <release>
}
80100f9f:	89 d8                	mov    %ebx,%eax
  return 0;
80100fa1:	83 c4 10             	add    $0x10,%esp
}
80100fa4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fa7:	c9                   	leave  
80100fa8:	c3                   	ret    
80100fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100fb0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fb0:	55                   	push   %ebp
80100fb1:	89 e5                	mov    %esp,%ebp
80100fb3:	53                   	push   %ebx
80100fb4:	83 ec 10             	sub    $0x10,%esp
80100fb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100fba:	68 60 ff 10 80       	push   $0x8010ff60
80100fbf:	e8 7c 38 00 00       	call   80104840 <acquire>
  if(f->ref < 1)
80100fc4:	8b 43 04             	mov    0x4(%ebx),%eax
80100fc7:	83 c4 10             	add    $0x10,%esp
80100fca:	85 c0                	test   %eax,%eax
80100fcc:	7e 1a                	jle    80100fe8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100fce:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100fd1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100fd4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100fd7:	68 60 ff 10 80       	push   $0x8010ff60
80100fdc:	e8 3f 3a 00 00       	call   80104a20 <release>
  return f;
}
80100fe1:	89 d8                	mov    %ebx,%eax
80100fe3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fe6:	c9                   	leave  
80100fe7:	c3                   	ret    
    panic("filedup");
80100fe8:	83 ec 0c             	sub    $0xc,%esp
80100feb:	68 d0 76 10 80       	push   $0x801076d0
80100ff0:	e8 8b f3 ff ff       	call   80100380 <panic>
80100ff5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101000 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 28             	sub    $0x28,%esp
80101009:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010100c:	68 60 ff 10 80       	push   $0x8010ff60
80101011:	e8 2a 38 00 00       	call   80104840 <acquire>
  if(f->ref < 1)
80101016:	8b 53 04             	mov    0x4(%ebx),%edx
80101019:	83 c4 10             	add    $0x10,%esp
8010101c:	85 d2                	test   %edx,%edx
8010101e:	0f 8e a5 00 00 00    	jle    801010c9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101024:	83 ea 01             	sub    $0x1,%edx
80101027:	89 53 04             	mov    %edx,0x4(%ebx)
8010102a:	75 44                	jne    80101070 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010102c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101030:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101033:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101035:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010103b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010103e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101041:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101044:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
80101049:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
8010104c:	e8 cf 39 00 00       	call   80104a20 <release>

  if(ff.type == FD_PIPE)
80101051:	83 c4 10             	add    $0x10,%esp
80101054:	83 ff 01             	cmp    $0x1,%edi
80101057:	74 57                	je     801010b0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101059:	83 ff 02             	cmp    $0x2,%edi
8010105c:	74 2a                	je     80101088 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010105e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101061:	5b                   	pop    %ebx
80101062:	5e                   	pop    %esi
80101063:	5f                   	pop    %edi
80101064:	5d                   	pop    %ebp
80101065:	c3                   	ret    
80101066:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010106d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101070:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80101077:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010107a:	5b                   	pop    %ebx
8010107b:	5e                   	pop    %esi
8010107c:	5f                   	pop    %edi
8010107d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010107e:	e9 9d 39 00 00       	jmp    80104a20 <release>
80101083:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101087:	90                   	nop
    begin_op();
80101088:	e8 73 1e 00 00       	call   80102f00 <begin_op>
    iput(ff.ip);
8010108d:	83 ec 0c             	sub    $0xc,%esp
80101090:	ff 75 e0             	pushl  -0x20(%ebp)
80101093:	e8 38 09 00 00       	call   801019d0 <iput>
    end_op();
80101098:	83 c4 10             	add    $0x10,%esp
}
8010109b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010109e:	5b                   	pop    %ebx
8010109f:	5e                   	pop    %esi
801010a0:	5f                   	pop    %edi
801010a1:	5d                   	pop    %ebp
    end_op();
801010a2:	e9 c9 1e 00 00       	jmp    80102f70 <end_op>
801010a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ae:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801010b0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010b4:	83 ec 08             	sub    $0x8,%esp
801010b7:	53                   	push   %ebx
801010b8:	56                   	push   %esi
801010b9:	e8 02 27 00 00       	call   801037c0 <pipeclose>
801010be:	83 c4 10             	add    $0x10,%esp
}
801010c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c4:	5b                   	pop    %ebx
801010c5:	5e                   	pop    %esi
801010c6:	5f                   	pop    %edi
801010c7:	5d                   	pop    %ebp
801010c8:	c3                   	ret    
    panic("fileclose");
801010c9:	83 ec 0c             	sub    $0xc,%esp
801010cc:	68 d8 76 10 80       	push   $0x801076d8
801010d1:	e8 aa f2 ff ff       	call   80100380 <panic>
801010d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010dd:	8d 76 00             	lea    0x0(%esi),%esi

801010e0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	53                   	push   %ebx
801010e4:	83 ec 04             	sub    $0x4,%esp
801010e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801010ea:	83 3b 02             	cmpl   $0x2,(%ebx)
801010ed:	75 31                	jne    80101120 <filestat+0x40>
    ilock(f->ip);
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	ff 73 10             	pushl  0x10(%ebx)
801010f5:	e8 a6 07 00 00       	call   801018a0 <ilock>
    stati(f->ip, st);
801010fa:	58                   	pop    %eax
801010fb:	5a                   	pop    %edx
801010fc:	ff 75 0c             	pushl  0xc(%ebp)
801010ff:	ff 73 10             	pushl  0x10(%ebx)
80101102:	e8 59 0a 00 00       	call   80101b60 <stati>
    iunlock(f->ip);
80101107:	59                   	pop    %ecx
80101108:	ff 73 10             	pushl  0x10(%ebx)
8010110b:	e8 70 08 00 00       	call   80101980 <iunlock>
    return 0;
  }
  return -1;
}
80101110:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101113:	83 c4 10             	add    $0x10,%esp
80101116:	31 c0                	xor    %eax,%eax
}
80101118:	c9                   	leave  
80101119:	c3                   	ret    
8010111a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101120:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101123:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101128:	c9                   	leave  
80101129:	c3                   	ret    
8010112a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101130 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	57                   	push   %edi
80101134:	56                   	push   %esi
80101135:	53                   	push   %ebx
80101136:	83 ec 0c             	sub    $0xc,%esp
80101139:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010113c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010113f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101142:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101146:	74 60                	je     801011a8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101148:	8b 03                	mov    (%ebx),%eax
8010114a:	83 f8 01             	cmp    $0x1,%eax
8010114d:	74 41                	je     80101190 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010114f:	83 f8 02             	cmp    $0x2,%eax
80101152:	75 5b                	jne    801011af <fileread+0x7f>
    ilock(f->ip);
80101154:	83 ec 0c             	sub    $0xc,%esp
80101157:	ff 73 10             	pushl  0x10(%ebx)
8010115a:	e8 41 07 00 00       	call   801018a0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010115f:	57                   	push   %edi
80101160:	ff 73 14             	pushl  0x14(%ebx)
80101163:	56                   	push   %esi
80101164:	ff 73 10             	pushl  0x10(%ebx)
80101167:	e8 24 0a 00 00       	call   80101b90 <readi>
8010116c:	83 c4 20             	add    $0x20,%esp
8010116f:	89 c6                	mov    %eax,%esi
80101171:	85 c0                	test   %eax,%eax
80101173:	7e 03                	jle    80101178 <fileread+0x48>
      f->off += r;
80101175:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101178:	83 ec 0c             	sub    $0xc,%esp
8010117b:	ff 73 10             	pushl  0x10(%ebx)
8010117e:	e8 fd 07 00 00       	call   80101980 <iunlock>
    return r;
80101183:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101189:	89 f0                	mov    %esi,%eax
8010118b:	5b                   	pop    %ebx
8010118c:	5e                   	pop    %esi
8010118d:	5f                   	pop    %edi
8010118e:	5d                   	pop    %ebp
8010118f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101190:	8b 43 0c             	mov    0xc(%ebx),%eax
80101193:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101196:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101199:	5b                   	pop    %ebx
8010119a:	5e                   	pop    %esi
8010119b:	5f                   	pop    %edi
8010119c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010119d:	e9 be 27 00 00       	jmp    80103960 <piperead>
801011a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801011a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801011ad:	eb d7                	jmp    80101186 <fileread+0x56>
  panic("fileread");
801011af:	83 ec 0c             	sub    $0xc,%esp
801011b2:	68 e2 76 10 80       	push   $0x801076e2
801011b7:	e8 c4 f1 ff ff       	call   80100380 <panic>
801011bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011c0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011c0:	55                   	push   %ebp
801011c1:	89 e5                	mov    %esp,%ebp
801011c3:	57                   	push   %edi
801011c4:	56                   	push   %esi
801011c5:	53                   	push   %ebx
801011c6:	83 ec 1c             	sub    $0x1c,%esp
801011c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801011cc:	8b 75 08             	mov    0x8(%ebp),%esi
801011cf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801011d2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801011d5:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
801011d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801011dc:	0f 84 bd 00 00 00    	je     8010129f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801011e2:	8b 06                	mov    (%esi),%eax
801011e4:	83 f8 01             	cmp    $0x1,%eax
801011e7:	0f 84 bf 00 00 00    	je     801012ac <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801011ed:	83 f8 02             	cmp    $0x2,%eax
801011f0:	0f 85 c8 00 00 00    	jne    801012be <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801011f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801011f9:	31 ff                	xor    %edi,%edi
    while(i < n){
801011fb:	85 c0                	test   %eax,%eax
801011fd:	7f 30                	jg     8010122f <filewrite+0x6f>
801011ff:	e9 94 00 00 00       	jmp    80101298 <filewrite+0xd8>
80101204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101208:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010120b:	83 ec 0c             	sub    $0xc,%esp
8010120e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101211:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101214:	e8 67 07 00 00       	call   80101980 <iunlock>
      end_op();
80101219:	e8 52 1d 00 00       	call   80102f70 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010121e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101221:	83 c4 10             	add    $0x10,%esp
80101224:	39 c3                	cmp    %eax,%ebx
80101226:	75 60                	jne    80101288 <filewrite+0xc8>
        panic("short filewrite");
      i += r;
80101228:	01 df                	add    %ebx,%edi
    while(i < n){
8010122a:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
8010122d:	7e 69                	jle    80101298 <filewrite+0xd8>
      int n1 = n - i;
8010122f:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101232:	b8 00 1a 00 00       	mov    $0x1a00,%eax
80101237:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101239:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
8010123f:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101242:	e8 b9 1c 00 00       	call   80102f00 <begin_op>
      ilock(f->ip);
80101247:	83 ec 0c             	sub    $0xc,%esp
8010124a:	ff 76 10             	pushl  0x10(%esi)
8010124d:	e8 4e 06 00 00       	call   801018a0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101252:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101255:	53                   	push   %ebx
80101256:	ff 76 14             	pushl  0x14(%esi)
80101259:	01 f8                	add    %edi,%eax
8010125b:	50                   	push   %eax
8010125c:	ff 76 10             	pushl  0x10(%esi)
8010125f:	e8 2c 0a 00 00       	call   80101c90 <writei>
80101264:	83 c4 20             	add    $0x20,%esp
80101267:	85 c0                	test   %eax,%eax
80101269:	7f 9d                	jg     80101208 <filewrite+0x48>
      iunlock(f->ip);
8010126b:	83 ec 0c             	sub    $0xc,%esp
8010126e:	ff 76 10             	pushl  0x10(%esi)
80101271:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101274:	e8 07 07 00 00       	call   80101980 <iunlock>
      end_op();
80101279:	e8 f2 1c 00 00       	call   80102f70 <end_op>
      if(r < 0)
8010127e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101281:	83 c4 10             	add    $0x10,%esp
80101284:	85 c0                	test   %eax,%eax
80101286:	75 17                	jne    8010129f <filewrite+0xdf>
        panic("short filewrite");
80101288:	83 ec 0c             	sub    $0xc,%esp
8010128b:	68 eb 76 10 80       	push   $0x801076eb
80101290:	e8 eb f0 ff ff       	call   80100380 <panic>
80101295:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101298:	89 f8                	mov    %edi,%eax
8010129a:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
8010129d:	74 05                	je     801012a4 <filewrite+0xe4>
8010129f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801012a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012a7:	5b                   	pop    %ebx
801012a8:	5e                   	pop    %esi
801012a9:	5f                   	pop    %edi
801012aa:	5d                   	pop    %ebp
801012ab:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801012ac:	8b 46 0c             	mov    0xc(%esi),%eax
801012af:	89 45 08             	mov    %eax,0x8(%ebp)
}
801012b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012b5:	5b                   	pop    %ebx
801012b6:	5e                   	pop    %esi
801012b7:	5f                   	pop    %edi
801012b8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801012b9:	e9 a2 25 00 00       	jmp    80103860 <pipewrite>
  panic("filewrite");
801012be:	83 ec 0c             	sub    $0xc,%esp
801012c1:	68 f1 76 10 80       	push   $0x801076f1
801012c6:	e8 b5 f0 ff ff       	call   80100380 <panic>
801012cb:	66 90                	xchg   %ax,%ax
801012cd:	66 90                	xchg   %ax,%ax
801012cf:	90                   	nop

801012d0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	57                   	push   %edi
801012d4:	56                   	push   %esi
801012d5:	53                   	push   %ebx
801012d6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801012d9:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
801012df:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012e2:	85 c9                	test   %ecx,%ecx
801012e4:	0f 84 87 00 00 00    	je     80101371 <balloc+0xa1>
801012ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801012f1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801012f4:	83 ec 08             	sub    $0x8,%esp
801012f7:	89 f0                	mov    %esi,%eax
801012f9:	c1 f8 0c             	sar    $0xc,%eax
801012fc:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101302:	50                   	push   %eax
80101303:	ff 75 d8             	pushl  -0x28(%ebp)
80101306:	e8 c5 ed ff ff       	call   801000d0 <bread>
8010130b:	83 c4 10             	add    $0x10,%esp
8010130e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101311:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101316:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101319:	31 c0                	xor    %eax,%eax
8010131b:	eb 2f                	jmp    8010134c <balloc+0x7c>
8010131d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101320:	89 c1                	mov    %eax,%ecx
80101322:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101327:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010132a:	83 e1 07             	and    $0x7,%ecx
8010132d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010132f:	89 c1                	mov    %eax,%ecx
80101331:	c1 f9 03             	sar    $0x3,%ecx
80101334:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101339:	89 fa                	mov    %edi,%edx
8010133b:	85 df                	test   %ebx,%edi
8010133d:	74 41                	je     80101380 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010133f:	83 c0 01             	add    $0x1,%eax
80101342:	83 c6 01             	add    $0x1,%esi
80101345:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010134a:	74 05                	je     80101351 <balloc+0x81>
8010134c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010134f:	77 cf                	ja     80101320 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101351:	83 ec 0c             	sub    $0xc,%esp
80101354:	ff 75 e4             	pushl  -0x1c(%ebp)
80101357:	e8 94 ee ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010135c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101363:	83 c4 10             	add    $0x10,%esp
80101366:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101369:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
8010136f:	77 80                	ja     801012f1 <balloc+0x21>
  }
  panic("balloc: out of blocks");
80101371:	83 ec 0c             	sub    $0xc,%esp
80101374:	68 fb 76 10 80       	push   $0x801076fb
80101379:	e8 02 f0 ff ff       	call   80100380 <panic>
8010137e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101380:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101383:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101386:	09 da                	or     %ebx,%edx
80101388:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010138c:	57                   	push   %edi
8010138d:	e8 4e 1d 00 00       	call   801030e0 <log_write>
        brelse(bp);
80101392:	89 3c 24             	mov    %edi,(%esp)
80101395:	e8 56 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010139a:	58                   	pop    %eax
8010139b:	5a                   	pop    %edx
8010139c:	56                   	push   %esi
8010139d:	ff 75 d8             	pushl  -0x28(%ebp)
801013a0:	e8 2b ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801013a5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801013a8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013aa:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ad:	68 00 02 00 00       	push   $0x200
801013b2:	6a 00                	push   $0x0
801013b4:	50                   	push   %eax
801013b5:	e8 b6 36 00 00       	call   80104a70 <memset>
  log_write(bp);
801013ba:	89 1c 24             	mov    %ebx,(%esp)
801013bd:	e8 1e 1d 00 00       	call   801030e0 <log_write>
  brelse(bp);
801013c2:	89 1c 24             	mov    %ebx,(%esp)
801013c5:	e8 26 ee ff ff       	call   801001f0 <brelse>
}
801013ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013cd:	89 f0                	mov    %esi,%eax
801013cf:	5b                   	pop    %ebx
801013d0:	5e                   	pop    %esi
801013d1:	5f                   	pop    %edi
801013d2:	5d                   	pop    %ebp
801013d3:	c3                   	ret    
801013d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801013df:	90                   	nop

801013e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	57                   	push   %edi
801013e4:	89 c7                	mov    %eax,%edi
801013e6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013e7:	31 f6                	xor    %esi,%esi
{
801013e9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ea:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
801013ef:	83 ec 28             	sub    $0x28,%esp
801013f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013f5:	68 60 09 11 80       	push   $0x80110960
801013fa:	e8 41 34 00 00       	call   80104840 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101402:	83 c4 10             	add    $0x10,%esp
80101405:	eb 1b                	jmp    80101422 <iget+0x42>
80101407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010140e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101410:	39 3b                	cmp    %edi,(%ebx)
80101412:	74 6c                	je     80101480 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101414:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010141a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101420:	73 26                	jae    80101448 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101422:	8b 43 08             	mov    0x8(%ebx),%eax
80101425:	85 c0                	test   %eax,%eax
80101427:	7f e7                	jg     80101410 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101429:	85 f6                	test   %esi,%esi
8010142b:	75 e7                	jne    80101414 <iget+0x34>
8010142d:	89 d9                	mov    %ebx,%ecx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010142f:	81 c3 90 00 00 00    	add    $0x90,%ebx
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101435:	85 c0                	test   %eax,%eax
80101437:	75 6e                	jne    801014a7 <iget+0xc7>
80101439:	89 ce                	mov    %ecx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010143b:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101441:	72 df                	jb     80101422 <iget+0x42>
80101443:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101447:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101448:	85 f6                	test   %esi,%esi
8010144a:	74 73                	je     801014bf <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
8010144c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010144f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101451:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101454:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
8010145b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101462:	68 60 09 11 80       	push   $0x80110960
80101467:	e8 b4 35 00 00       	call   80104a20 <release>

  return ip;
8010146c:	83 c4 10             	add    $0x10,%esp
}
8010146f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101472:	89 f0                	mov    %esi,%eax
80101474:	5b                   	pop    %ebx
80101475:	5e                   	pop    %esi
80101476:	5f                   	pop    %edi
80101477:	5d                   	pop    %ebp
80101478:	c3                   	ret    
80101479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101480:	39 53 04             	cmp    %edx,0x4(%ebx)
80101483:	75 8f                	jne    80101414 <iget+0x34>
      release(&icache.lock);
80101485:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101488:	83 c0 01             	add    $0x1,%eax
      return ip;
8010148b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010148d:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
80101492:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101495:	e8 86 35 00 00       	call   80104a20 <release>
      return ip;
8010149a:	83 c4 10             	add    $0x10,%esp
}
8010149d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a0:	89 f0                	mov    %esi,%eax
801014a2:	5b                   	pop    %ebx
801014a3:	5e                   	pop    %esi
801014a4:	5f                   	pop    %edi
801014a5:	5d                   	pop    %ebp
801014a6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014a7:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801014ad:	73 10                	jae    801014bf <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014af:	8b 43 08             	mov    0x8(%ebx),%eax
801014b2:	85 c0                	test   %eax,%eax
801014b4:	0f 8f 56 ff ff ff    	jg     80101410 <iget+0x30>
801014ba:	e9 6e ff ff ff       	jmp    8010142d <iget+0x4d>
    panic("iget: no inodes");
801014bf:	83 ec 0c             	sub    $0xc,%esp
801014c2:	68 11 77 10 80       	push   $0x80107711
801014c7:	e8 b4 ee ff ff       	call   80100380 <panic>
801014cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014d0:	55                   	push   %ebp
801014d1:	89 e5                	mov    %esp,%ebp
801014d3:	57                   	push   %edi
801014d4:	56                   	push   %esi
801014d5:	89 c6                	mov    %eax,%esi
801014d7:	53                   	push   %ebx
801014d8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014db:	83 fa 0b             	cmp    $0xb,%edx
801014de:	0f 86 8c 00 00 00    	jbe    80101570 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801014e4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801014e7:	83 fb 7f             	cmp    $0x7f,%ebx
801014ea:	0f 87 a2 00 00 00    	ja     80101592 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801014f0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
      ip->addrs[bn] = addr = balloc(ip->dev);
801014f6:	8b 16                	mov    (%esi),%edx
    if((addr = ip->addrs[NDIRECT]) == 0)
801014f8:	85 c0                	test   %eax,%eax
801014fa:	74 5c                	je     80101558 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014fc:	83 ec 08             	sub    $0x8,%esp
801014ff:	50                   	push   %eax
80101500:	52                   	push   %edx
80101501:	e8 ca eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101506:	83 c4 10             	add    $0x10,%esp
80101509:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010150d:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010150f:	8b 3b                	mov    (%ebx),%edi
80101511:	85 ff                	test   %edi,%edi
80101513:	74 1b                	je     80101530 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101515:	83 ec 0c             	sub    $0xc,%esp
80101518:	52                   	push   %edx
80101519:	e8 d2 ec ff ff       	call   801001f0 <brelse>
8010151e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101521:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101524:	89 f8                	mov    %edi,%eax
80101526:	5b                   	pop    %ebx
80101527:	5e                   	pop    %esi
80101528:	5f                   	pop    %edi
80101529:	5d                   	pop    %ebp
8010152a:	c3                   	ret    
8010152b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010152f:	90                   	nop
80101530:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101533:	8b 06                	mov    (%esi),%eax
80101535:	e8 96 fd ff ff       	call   801012d0 <balloc>
      log_write(bp);
8010153a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010153d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101540:	89 03                	mov    %eax,(%ebx)
80101542:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101544:	52                   	push   %edx
80101545:	e8 96 1b 00 00       	call   801030e0 <log_write>
8010154a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010154d:	83 c4 10             	add    $0x10,%esp
80101550:	eb c3                	jmp    80101515 <bmap+0x45>
80101552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101558:	89 d0                	mov    %edx,%eax
8010155a:	e8 71 fd ff ff       	call   801012d0 <balloc>
    bp = bread(ip->dev, addr);
8010155f:	8b 16                	mov    (%esi),%edx
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101561:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101567:	eb 93                	jmp    801014fc <bmap+0x2c>
80101569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101570:	8d 5a 14             	lea    0x14(%edx),%ebx
80101573:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101577:	85 ff                	test   %edi,%edi
80101579:	75 a6                	jne    80101521 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010157b:	8b 00                	mov    (%eax),%eax
8010157d:	e8 4e fd ff ff       	call   801012d0 <balloc>
80101582:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101586:	89 c7                	mov    %eax,%edi
}
80101588:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010158b:	5b                   	pop    %ebx
8010158c:	89 f8                	mov    %edi,%eax
8010158e:	5e                   	pop    %esi
8010158f:	5f                   	pop    %edi
80101590:	5d                   	pop    %ebp
80101591:	c3                   	ret    
  panic("bmap: out of range");
80101592:	83 ec 0c             	sub    $0xc,%esp
80101595:	68 21 77 10 80       	push   $0x80107721
8010159a:	e8 e1 ed ff ff       	call   80100380 <panic>
8010159f:	90                   	nop

801015a0 <bfree>:
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	57                   	push   %edi
801015a4:	56                   	push   %esi
801015a5:	89 c6                	mov    %eax,%esi
801015a7:	53                   	push   %ebx
801015a8:	89 d3                	mov    %edx,%ebx
801015aa:	83 ec 14             	sub    $0x14,%esp
  bp = bread(dev, 1);
801015ad:	6a 01                	push   $0x1
801015af:	50                   	push   %eax
801015b0:	e8 1b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015b5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015b8:	89 c7                	mov    %eax,%edi
  memmove(sb, bp->data, sizeof(*sb));
801015ba:	83 c0 5c             	add    $0x5c,%eax
801015bd:	6a 1c                	push   $0x1c
801015bf:	50                   	push   %eax
801015c0:	68 b4 25 11 80       	push   $0x801125b4
801015c5:	e8 46 35 00 00       	call   80104b10 <memmove>
  brelse(bp);
801015ca:	89 3c 24             	mov    %edi,(%esp)
801015cd:	e8 1e ec ff ff       	call   801001f0 <brelse>
  bp = bread(dev, BBLOCK(b, sb));
801015d2:	58                   	pop    %eax
801015d3:	89 d8                	mov    %ebx,%eax
801015d5:	5a                   	pop    %edx
801015d6:	c1 e8 0c             	shr    $0xc,%eax
801015d9:	03 05 cc 25 11 80    	add    0x801125cc,%eax
801015df:	50                   	push   %eax
801015e0:	56                   	push   %esi
801015e1:	e8 ea ea ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801015e6:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801015e8:	c1 fb 03             	sar    $0x3,%ebx
801015eb:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801015ee:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801015f0:	83 e1 07             	and    $0x7,%ecx
801015f3:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801015f8:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801015fe:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101600:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101605:	85 c1                	test   %eax,%ecx
80101607:	74 24                	je     8010162d <bfree+0x8d>
  bp->data[bi/8] &= ~m;
80101609:	f7 d0                	not    %eax
  log_write(bp);
8010160b:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
8010160e:	21 c8                	and    %ecx,%eax
80101610:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101614:	56                   	push   %esi
80101615:	e8 c6 1a 00 00       	call   801030e0 <log_write>
  brelse(bp);
8010161a:	89 34 24             	mov    %esi,(%esp)
8010161d:	e8 ce eb ff ff       	call   801001f0 <brelse>
}
80101622:	83 c4 10             	add    $0x10,%esp
80101625:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101628:	5b                   	pop    %ebx
80101629:	5e                   	pop    %esi
8010162a:	5f                   	pop    %edi
8010162b:	5d                   	pop    %ebp
8010162c:	c3                   	ret    
    panic("freeing free block");
8010162d:	83 ec 0c             	sub    $0xc,%esp
80101630:	68 34 77 10 80       	push   $0x80107734
80101635:	e8 46 ed ff ff       	call   80100380 <panic>
8010163a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101640 <readsb>:
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	56                   	push   %esi
80101644:	53                   	push   %ebx
80101645:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101648:	83 ec 08             	sub    $0x8,%esp
8010164b:	6a 01                	push   $0x1
8010164d:	ff 75 08             	pushl  0x8(%ebp)
80101650:	e8 7b ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101655:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101658:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010165a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010165d:	6a 1c                	push   $0x1c
8010165f:	50                   	push   %eax
80101660:	56                   	push   %esi
80101661:	e8 aa 34 00 00       	call   80104b10 <memmove>
  brelse(bp);
80101666:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101669:	83 c4 10             	add    $0x10,%esp
}
8010166c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010166f:	5b                   	pop    %ebx
80101670:	5e                   	pop    %esi
80101671:	5d                   	pop    %ebp
  brelse(bp);
80101672:	e9 79 eb ff ff       	jmp    801001f0 <brelse>
80101677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167e:	66 90                	xchg   %ax,%ax

80101680 <iinit>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	53                   	push   %ebx
80101684:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101689:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010168c:	68 47 77 10 80       	push   $0x80107747
80101691:	68 60 09 11 80       	push   $0x80110960
80101696:	e8 85 31 00 00       	call   80104820 <initlock>
  for(i = 0; i < NINODE; i++) {
8010169b:	83 c4 10             	add    $0x10,%esp
8010169e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801016a0:	83 ec 08             	sub    $0x8,%esp
801016a3:	68 4e 77 10 80       	push   $0x8010774e
801016a8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801016a9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801016af:	e8 5c 30 00 00       	call   80104710 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801016b4:	83 c4 10             	add    $0x10,%esp
801016b7:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
801016bd:	75 e1                	jne    801016a0 <iinit+0x20>
  bp = bread(dev, 1);
801016bf:	83 ec 08             	sub    $0x8,%esp
801016c2:	6a 01                	push   $0x1
801016c4:	ff 75 08             	pushl  0x8(%ebp)
801016c7:	e8 04 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801016cc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801016cf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016d1:	8d 40 5c             	lea    0x5c(%eax),%eax
801016d4:	6a 1c                	push   $0x1c
801016d6:	50                   	push   %eax
801016d7:	68 b4 25 11 80       	push   $0x801125b4
801016dc:	e8 2f 34 00 00       	call   80104b10 <memmove>
  brelse(bp);
801016e1:	89 1c 24             	mov    %ebx,(%esp)
801016e4:	e8 07 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016e9:	ff 35 cc 25 11 80    	pushl  0x801125cc
801016ef:	ff 35 c8 25 11 80    	pushl  0x801125c8
801016f5:	ff 35 c4 25 11 80    	pushl  0x801125c4
801016fb:	ff 35 c0 25 11 80    	pushl  0x801125c0
80101701:	ff 35 bc 25 11 80    	pushl  0x801125bc
80101707:	ff 35 b8 25 11 80    	pushl  0x801125b8
8010170d:	ff 35 b4 25 11 80    	pushl  0x801125b4
80101713:	68 a4 77 10 80       	push   $0x801077a4
80101718:	e8 63 ef ff ff       	call   80100680 <cprintf>
}
8010171d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101720:	83 c4 30             	add    $0x30,%esp
80101723:	c9                   	leave  
80101724:	c3                   	ret    
80101725:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010172c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101730 <ialloc>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	57                   	push   %edi
80101734:	56                   	push   %esi
80101735:	53                   	push   %ebx
80101736:	83 ec 1c             	sub    $0x1c,%esp
80101739:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010173c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101743:	8b 75 08             	mov    0x8(%ebp),%esi
80101746:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101749:	0f 86 91 00 00 00    	jbe    801017e0 <ialloc+0xb0>
8010174f:	bf 01 00 00 00       	mov    $0x1,%edi
80101754:	eb 21                	jmp    80101777 <ialloc+0x47>
80101756:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010175d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101760:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101763:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101766:	53                   	push   %ebx
80101767:	e8 84 ea ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010176c:	83 c4 10             	add    $0x10,%esp
8010176f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101775:	73 69                	jae    801017e0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101777:	89 f8                	mov    %edi,%eax
80101779:	83 ec 08             	sub    $0x8,%esp
8010177c:	c1 e8 03             	shr    $0x3,%eax
8010177f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101785:	50                   	push   %eax
80101786:	56                   	push   %esi
80101787:	e8 44 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010178c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010178f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101791:	89 f8                	mov    %edi,%eax
80101793:	83 e0 07             	and    $0x7,%eax
80101796:	c1 e0 06             	shl    $0x6,%eax
80101799:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010179d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801017a1:	75 bd                	jne    80101760 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801017a3:	83 ec 04             	sub    $0x4,%esp
801017a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801017a9:	6a 40                	push   $0x40
801017ab:	6a 00                	push   $0x0
801017ad:	51                   	push   %ecx
801017ae:	e8 bd 32 00 00       	call   80104a70 <memset>
      dip->type = type;
801017b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801017b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017ba:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017bd:	89 1c 24             	mov    %ebx,(%esp)
801017c0:	e8 1b 19 00 00       	call   801030e0 <log_write>
      brelse(bp);
801017c5:	89 1c 24             	mov    %ebx,(%esp)
801017c8:	e8 23 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801017cd:	83 c4 10             	add    $0x10,%esp
}
801017d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801017d3:	89 fa                	mov    %edi,%edx
}
801017d5:	5b                   	pop    %ebx
      return iget(dev, inum);
801017d6:	89 f0                	mov    %esi,%eax
}
801017d8:	5e                   	pop    %esi
801017d9:	5f                   	pop    %edi
801017da:	5d                   	pop    %ebp
      return iget(dev, inum);
801017db:	e9 00 fc ff ff       	jmp    801013e0 <iget>
  panic("ialloc: no inodes");
801017e0:	83 ec 0c             	sub    $0xc,%esp
801017e3:	68 54 77 10 80       	push   $0x80107754
801017e8:	e8 93 eb ff ff       	call   80100380 <panic>
801017ed:	8d 76 00             	lea    0x0(%esi),%esi

801017f0 <iupdate>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	56                   	push   %esi
801017f4:	53                   	push   %ebx
801017f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017f8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017fb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017fe:	83 ec 08             	sub    $0x8,%esp
80101801:	c1 e8 03             	shr    $0x3,%eax
80101804:	03 05 c8 25 11 80    	add    0x801125c8,%eax
8010180a:	50                   	push   %eax
8010180b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010180e:	e8 bd e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101813:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101817:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010181a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010181c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010181f:	83 e0 07             	and    $0x7,%eax
80101822:	c1 e0 06             	shl    $0x6,%eax
80101825:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101829:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010182c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101830:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101833:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101837:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010183b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010183f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101843:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101847:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010184a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010184d:	6a 34                	push   $0x34
8010184f:	53                   	push   %ebx
80101850:	50                   	push   %eax
80101851:	e8 ba 32 00 00       	call   80104b10 <memmove>
  log_write(bp);
80101856:	89 34 24             	mov    %esi,(%esp)
80101859:	e8 82 18 00 00       	call   801030e0 <log_write>
  brelse(bp);
8010185e:	89 75 08             	mov    %esi,0x8(%ebp)
80101861:	83 c4 10             	add    $0x10,%esp
}
80101864:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101867:	5b                   	pop    %ebx
80101868:	5e                   	pop    %esi
80101869:	5d                   	pop    %ebp
  brelse(bp);
8010186a:	e9 81 e9 ff ff       	jmp    801001f0 <brelse>
8010186f:	90                   	nop

80101870 <idup>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	53                   	push   %ebx
80101874:	83 ec 10             	sub    $0x10,%esp
80101877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010187a:	68 60 09 11 80       	push   $0x80110960
8010187f:	e8 bc 2f 00 00       	call   80104840 <acquire>
  ip->ref++;
80101884:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101888:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010188f:	e8 8c 31 00 00       	call   80104a20 <release>
}
80101894:	89 d8                	mov    %ebx,%eax
80101896:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101899:	c9                   	leave  
8010189a:	c3                   	ret    
8010189b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010189f:	90                   	nop

801018a0 <ilock>:
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	56                   	push   %esi
801018a4:	53                   	push   %ebx
801018a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801018a8:	85 db                	test   %ebx,%ebx
801018aa:	0f 84 b4 00 00 00    	je     80101964 <ilock+0xc4>
801018b0:	8b 43 08             	mov    0x8(%ebx),%eax
801018b3:	85 c0                	test   %eax,%eax
801018b5:	0f 8e a9 00 00 00    	jle    80101964 <ilock+0xc4>
  acquiresleep(&ip->lock);
801018bb:	83 ec 0c             	sub    $0xc,%esp
801018be:	8d 43 0c             	lea    0xc(%ebx),%eax
801018c1:	50                   	push   %eax
801018c2:	e8 89 2e 00 00       	call   80104750 <acquiresleep>
  if(!(ip->flags & I_VALID)){
801018c7:	83 c4 10             	add    $0x10,%esp
801018ca:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
801018ce:	74 10                	je     801018e0 <ilock+0x40>
}
801018d0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018d3:	5b                   	pop    %ebx
801018d4:	5e                   	pop    %esi
801018d5:	5d                   	pop    %ebp
801018d6:	c3                   	ret    
801018d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018de:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018e0:	8b 43 04             	mov    0x4(%ebx),%eax
801018e3:	83 ec 08             	sub    $0x8,%esp
801018e6:	c1 e8 03             	shr    $0x3,%eax
801018e9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801018ef:	50                   	push   %eax
801018f0:	ff 33                	pushl  (%ebx)
801018f2:	e8 d9 e7 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018f7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018fa:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018fc:	8b 43 04             	mov    0x4(%ebx),%eax
801018ff:	83 e0 07             	and    $0x7,%eax
80101902:	c1 e0 06             	shl    $0x6,%eax
80101905:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101909:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010190c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010190f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101913:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101917:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010191b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010191f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101923:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101927:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010192b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010192e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101931:	6a 34                	push   $0x34
80101933:	50                   	push   %eax
80101934:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101937:	50                   	push   %eax
80101938:	e8 d3 31 00 00       	call   80104b10 <memmove>
    brelse(bp);
8010193d:	89 34 24             	mov    %esi,(%esp)
80101940:	e8 ab e8 ff ff       	call   801001f0 <brelse>
    ip->flags |= I_VALID;
80101945:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
80101949:	83 c4 10             	add    $0x10,%esp
8010194c:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101951:	0f 85 79 ff ff ff    	jne    801018d0 <ilock+0x30>
      panic("ilock: no type");
80101957:	83 ec 0c             	sub    $0xc,%esp
8010195a:	68 6c 77 10 80       	push   $0x8010776c
8010195f:	e8 1c ea ff ff       	call   80100380 <panic>
    panic("ilock");
80101964:	83 ec 0c             	sub    $0xc,%esp
80101967:	68 66 77 10 80       	push   $0x80107766
8010196c:	e8 0f ea ff ff       	call   80100380 <panic>
80101971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010197f:	90                   	nop

80101980 <iunlock>:
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	56                   	push   %esi
80101984:	53                   	push   %ebx
80101985:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101988:	85 db                	test   %ebx,%ebx
8010198a:	74 28                	je     801019b4 <iunlock+0x34>
8010198c:	83 ec 0c             	sub    $0xc,%esp
8010198f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101992:	56                   	push   %esi
80101993:	e8 58 2e 00 00       	call   801047f0 <holdingsleep>
80101998:	83 c4 10             	add    $0x10,%esp
8010199b:	85 c0                	test   %eax,%eax
8010199d:	74 15                	je     801019b4 <iunlock+0x34>
8010199f:	8b 43 08             	mov    0x8(%ebx),%eax
801019a2:	85 c0                	test   %eax,%eax
801019a4:	7e 0e                	jle    801019b4 <iunlock+0x34>
  releasesleep(&ip->lock);
801019a6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801019a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019ac:	5b                   	pop    %ebx
801019ad:	5e                   	pop    %esi
801019ae:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801019af:	e9 fc 2d 00 00       	jmp    801047b0 <releasesleep>
    panic("iunlock");
801019b4:	83 ec 0c             	sub    $0xc,%esp
801019b7:	68 7b 77 10 80       	push   $0x8010777b
801019bc:	e8 bf e9 ff ff       	call   80100380 <panic>
801019c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019cf:	90                   	nop

801019d0 <iput>:
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	57                   	push   %edi
801019d4:	56                   	push   %esi
801019d5:	53                   	push   %ebx
801019d6:	83 ec 28             	sub    $0x28,%esp
801019d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
801019dc:	68 60 09 11 80       	push   $0x80110960
801019e1:	e8 5a 2e 00 00       	call   80104840 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801019e6:	8b 46 08             	mov    0x8(%esi),%eax
801019e9:	83 c4 10             	add    $0x10,%esp
801019ec:	83 f8 01             	cmp    $0x1,%eax
801019ef:	74 1f                	je     80101a10 <iput+0x40>
  ip->ref--;
801019f1:	83 e8 01             	sub    $0x1,%eax
801019f4:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801019f7:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801019fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a01:	5b                   	pop    %ebx
80101a02:	5e                   	pop    %esi
80101a03:	5f                   	pop    %edi
80101a04:	5d                   	pop    %ebp
  release(&icache.lock);
80101a05:	e9 16 30 00 00       	jmp    80104a20 <release>
80101a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101a10:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
80101a14:	74 db                	je     801019f1 <iput+0x21>
80101a16:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101a1b:	75 d4                	jne    801019f1 <iput+0x21>
    release(&icache.lock);
80101a1d:	83 ec 0c             	sub    $0xc,%esp
80101a20:	8d 5e 5c             	lea    0x5c(%esi),%ebx
80101a23:	8d be 8c 00 00 00    	lea    0x8c(%esi),%edi
80101a29:	68 60 09 11 80       	push   $0x80110960
80101a2e:	e8 ed 2f 00 00       	call   80104a20 <release>
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a33:	83 c4 10             	add    $0x10,%esp
80101a36:	eb 0f                	jmp    80101a47 <iput+0x77>
80101a38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a3f:	90                   	nop
80101a40:	83 c3 04             	add    $0x4,%ebx
80101a43:	39 fb                	cmp    %edi,%ebx
80101a45:	74 19                	je     80101a60 <iput+0x90>
    if(ip->addrs[i]){
80101a47:	8b 13                	mov    (%ebx),%edx
80101a49:	85 d2                	test   %edx,%edx
80101a4b:	74 f3                	je     80101a40 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
80101a4d:	8b 06                	mov    (%esi),%eax
80101a4f:	e8 4c fb ff ff       	call   801015a0 <bfree>
      ip->addrs[i] = 0;
80101a54:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80101a5a:	eb e4                	jmp    80101a40 <iput+0x70>
80101a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a60:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101a66:	85 c0                	test   %eax,%eax
80101a68:	75 3c                	jne    80101aa6 <iput+0xd6>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a6a:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101a6d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101a74:	56                   	push   %esi
80101a75:	e8 76 fd ff ff       	call   801017f0 <iupdate>
    ip->type = 0;
80101a7a:	31 c0                	xor    %eax,%eax
80101a7c:	66 89 46 50          	mov    %ax,0x50(%esi)
    iupdate(ip);
80101a80:	89 34 24             	mov    %esi,(%esp)
80101a83:	e8 68 fd ff ff       	call   801017f0 <iupdate>
    acquire(&icache.lock);
80101a88:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101a8f:	e8 ac 2d 00 00       	call   80104840 <acquire>
    ip->flags = 0;
80101a94:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  ip->ref--;
80101a9b:	8b 46 08             	mov    0x8(%esi),%eax
80101a9e:	83 c4 10             	add    $0x10,%esp
80101aa1:	e9 4b ff ff ff       	jmp    801019f1 <iput+0x21>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101aa6:	83 ec 08             	sub    $0x8,%esp
80101aa9:	50                   	push   %eax
80101aaa:	ff 36                	pushl  (%esi)
80101aac:	e8 1f e6 ff ff       	call   801000d0 <bread>
80101ab1:	83 c4 10             	add    $0x10,%esp
80101ab4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101ab7:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101aba:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
80101ac0:	eb 0d                	jmp    80101acf <iput+0xff>
80101ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ac8:	83 c3 04             	add    $0x4,%ebx
80101acb:	39 df                	cmp    %ebx,%edi
80101acd:	74 0f                	je     80101ade <iput+0x10e>
      if(a[j])
80101acf:	8b 13                	mov    (%ebx),%edx
80101ad1:	85 d2                	test   %edx,%edx
80101ad3:	74 f3                	je     80101ac8 <iput+0xf8>
        bfree(ip->dev, a[j]);
80101ad5:	8b 06                	mov    (%esi),%eax
80101ad7:	e8 c4 fa ff ff       	call   801015a0 <bfree>
80101adc:	eb ea                	jmp    80101ac8 <iput+0xf8>
    brelse(bp);
80101ade:	83 ec 0c             	sub    $0xc,%esp
80101ae1:	ff 75 e4             	pushl  -0x1c(%ebp)
80101ae4:	e8 07 e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ae9:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101aef:	8b 06                	mov    (%esi),%eax
80101af1:	e8 aa fa ff ff       	call   801015a0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101af6:	83 c4 10             	add    $0x10,%esp
80101af9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101b00:	00 00 00 
80101b03:	e9 62 ff ff ff       	jmp    80101a6a <iput+0x9a>
80101b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b0f:	90                   	nop

80101b10 <iunlockput>:
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	56                   	push   %esi
80101b14:	53                   	push   %ebx
80101b15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b18:	85 db                	test   %ebx,%ebx
80101b1a:	74 34                	je     80101b50 <iunlockput+0x40>
80101b1c:	83 ec 0c             	sub    $0xc,%esp
80101b1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b22:	56                   	push   %esi
80101b23:	e8 c8 2c 00 00       	call   801047f0 <holdingsleep>
80101b28:	83 c4 10             	add    $0x10,%esp
80101b2b:	85 c0                	test   %eax,%eax
80101b2d:	74 21                	je     80101b50 <iunlockput+0x40>
80101b2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b32:	85 c0                	test   %eax,%eax
80101b34:	7e 1a                	jle    80101b50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101b36:	83 ec 0c             	sub    $0xc,%esp
80101b39:	56                   	push   %esi
80101b3a:	e8 71 2c 00 00       	call   801047b0 <releasesleep>
  iput(ip);
80101b3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b42:	83 c4 10             	add    $0x10,%esp
}
80101b45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b48:	5b                   	pop    %ebx
80101b49:	5e                   	pop    %esi
80101b4a:	5d                   	pop    %ebp
  iput(ip);
80101b4b:	e9 80 fe ff ff       	jmp    801019d0 <iput>
    panic("iunlock");
80101b50:	83 ec 0c             	sub    $0xc,%esp
80101b53:	68 7b 77 10 80       	push   $0x8010777b
80101b58:	e8 23 e8 ff ff       	call   80100380 <panic>
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi

80101b60 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101b60:	55                   	push   %ebp
80101b61:	89 e5                	mov    %esp,%ebp
80101b63:	8b 55 08             	mov    0x8(%ebp),%edx
80101b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b69:	8b 0a                	mov    (%edx),%ecx
80101b6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b83:	8b 52 58             	mov    0x58(%edx),%edx
80101b86:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b89:	5d                   	pop    %ebp
80101b8a:	c3                   	ret    
80101b8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b8f:	90                   	nop

80101b90 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101b9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9f:	8b 75 10             	mov    0x10(%ebp),%esi
80101ba2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101ba5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ba8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bb0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101bb3:	0f 84 a7 00 00 00    	je     80101c60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101bb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bbc:	8b 40 58             	mov    0x58(%eax),%eax
80101bbf:	39 c6                	cmp    %eax,%esi
80101bc1:	0f 87 ba 00 00 00    	ja     80101c81 <readi+0xf1>
80101bc7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bca:	31 c9                	xor    %ecx,%ecx
80101bcc:	89 da                	mov    %ebx,%edx
80101bce:	01 f2                	add    %esi,%edx
80101bd0:	0f 92 c1             	setb   %cl
80101bd3:	89 cf                	mov    %ecx,%edi
80101bd5:	0f 82 a6 00 00 00    	jb     80101c81 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101bdb:	89 c1                	mov    %eax,%ecx
80101bdd:	29 f1                	sub    %esi,%ecx
80101bdf:	39 d0                	cmp    %edx,%eax
80101be1:	0f 43 cb             	cmovae %ebx,%ecx
80101be4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101be7:	85 c9                	test   %ecx,%ecx
80101be9:	74 67                	je     80101c52 <readi+0xc2>
80101beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bf0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101bf3:	89 f2                	mov    %esi,%edx
80101bf5:	c1 ea 09             	shr    $0x9,%edx
80101bf8:	89 d8                	mov    %ebx,%eax
80101bfa:	e8 d1 f8 ff ff       	call   801014d0 <bmap>
80101bff:	83 ec 08             	sub    $0x8,%esp
80101c02:	50                   	push   %eax
80101c03:	ff 33                	pushl  (%ebx)
80101c05:	e8 c6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c0d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c12:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c15:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c17:	89 f0                	mov    %esi,%eax
80101c19:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c1e:	29 fb                	sub    %edi,%ebx
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
80101c20:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101c23:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c25:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c29:	39 d9                	cmp    %ebx,%ecx
80101c2b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c2e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c2f:	01 df                	add    %ebx,%edi
80101c31:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101c33:	50                   	push   %eax
80101c34:	ff 75 e0             	pushl  -0x20(%ebp)
80101c37:	e8 d4 2e 00 00       	call   80104b10 <memmove>
    brelse(bp);
80101c3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c3f:	89 14 24             	mov    %edx,(%esp)
80101c42:	e8 a9 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c4a:	83 c4 10             	add    $0x10,%esp
80101c4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101c50:	77 9e                	ja     80101bf0 <readi+0x60>
  }
  return n;
80101c52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101c55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c58:	5b                   	pop    %ebx
80101c59:	5e                   	pop    %esi
80101c5a:	5f                   	pop    %edi
80101c5b:	5d                   	pop    %ebp
80101c5c:	c3                   	ret    
80101c5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c64:	66 83 f8 09          	cmp    $0x9,%ax
80101c68:	77 17                	ja     80101c81 <readi+0xf1>
80101c6a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101c71:	85 c0                	test   %eax,%eax
80101c73:	74 0c                	je     80101c81 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101c75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7b:	5b                   	pop    %ebx
80101c7c:	5e                   	pop    %esi
80101c7d:	5f                   	pop    %edi
80101c7e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c7f:	ff e0                	jmp    *%eax
      return -1;
80101c81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c86:	eb cd                	jmp    80101c55 <readi+0xc5>
80101c88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c8f:	90                   	nop

80101c90 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c90:	55                   	push   %ebp
80101c91:	89 e5                	mov    %esp,%ebp
80101c93:	57                   	push   %edi
80101c94:	56                   	push   %esi
80101c95:	53                   	push   %ebx
80101c96:	83 ec 1c             	sub    $0x1c,%esp
80101c99:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c9f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ca2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ca7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101caa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101cad:	8b 75 10             	mov    0x10(%ebp),%esi
80101cb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101cb3:	0f 84 b7 00 00 00    	je     80101d70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101cb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101cbf:	0f 87 e7 00 00 00    	ja     80101dac <writei+0x11c>
80101cc5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101cc8:	31 d2                	xor    %edx,%edx
80101cca:	89 f8                	mov    %edi,%eax
80101ccc:	01 f0                	add    %esi,%eax
80101cce:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101cd1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101cd6:	0f 87 d0 00 00 00    	ja     80101dac <writei+0x11c>
80101cdc:	85 d2                	test   %edx,%edx
80101cde:	0f 85 c8 00 00 00    	jne    80101dac <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ce4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ceb:	85 ff                	test   %edi,%edi
80101ced:	74 72                	je     80101d61 <writei+0xd1>
80101cef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cf0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101cf3:	89 f2                	mov    %esi,%edx
80101cf5:	c1 ea 09             	shr    $0x9,%edx
80101cf8:	89 f8                	mov    %edi,%eax
80101cfa:	e8 d1 f7 ff ff       	call   801014d0 <bmap>
80101cff:	83 ec 08             	sub    $0x8,%esp
80101d02:	50                   	push   %eax
80101d03:	ff 37                	pushl  (%edi)
80101d05:	e8 c6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d0a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101d0f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d12:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d15:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d17:	89 f0                	mov    %esi,%eax
80101d19:	83 c4 0c             	add    $0xc,%esp
80101d1c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d21:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d23:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d27:	39 d9                	cmp    %ebx,%ecx
80101d29:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d2c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d2d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101d2f:	ff 75 dc             	pushl  -0x24(%ebp)
80101d32:	50                   	push   %eax
80101d33:	e8 d8 2d 00 00       	call   80104b10 <memmove>
    log_write(bp);
80101d38:	89 3c 24             	mov    %edi,(%esp)
80101d3b:	e8 a0 13 00 00       	call   801030e0 <log_write>
    brelse(bp);
80101d40:	89 3c 24             	mov    %edi,(%esp)
80101d43:	e8 a8 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d48:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d4b:	83 c4 10             	add    $0x10,%esp
80101d4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d51:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d54:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101d57:	77 97                	ja     80101cf0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101d59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d5c:	3b 70 58             	cmp    0x58(%eax),%esi
80101d5f:	77 37                	ja     80101d98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d61:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d67:	5b                   	pop    %ebx
80101d68:	5e                   	pop    %esi
80101d69:	5f                   	pop    %edi
80101d6a:	5d                   	pop    %ebp
80101d6b:	c3                   	ret    
80101d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d74:	66 83 f8 09          	cmp    $0x9,%ax
80101d78:	77 32                	ja     80101dac <writei+0x11c>
80101d7a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101d81:	85 c0                	test   %eax,%eax
80101d83:	74 27                	je     80101dac <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101d85:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101d88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d8b:	5b                   	pop    %ebx
80101d8c:	5e                   	pop    %esi
80101d8d:	5f                   	pop    %edi
80101d8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d8f:	ff e0                	jmp    *%eax
80101d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101d98:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101d9b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d9e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101da1:	50                   	push   %eax
80101da2:	e8 49 fa ff ff       	call   801017f0 <iupdate>
80101da7:	83 c4 10             	add    $0x10,%esp
80101daa:	eb b5                	jmp    80101d61 <writei+0xd1>
      return -1;
80101dac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101db1:	eb b1                	jmp    80101d64 <writei+0xd4>
80101db3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101dc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101dc0:	55                   	push   %ebp
80101dc1:	89 e5                	mov    %esp,%ebp
80101dc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101dc6:	6a 0e                	push   $0xe
80101dc8:	ff 75 0c             	pushl  0xc(%ebp)
80101dcb:	ff 75 08             	pushl  0x8(%ebp)
80101dce:	e8 ad 2d 00 00       	call   80104b80 <strncmp>
}
80101dd3:	c9                   	leave  
80101dd4:	c3                   	ret    
80101dd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101de0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101de0:	55                   	push   %ebp
80101de1:	89 e5                	mov    %esp,%ebp
80101de3:	57                   	push   %edi
80101de4:	56                   	push   %esi
80101de5:	53                   	push   %ebx
80101de6:	83 ec 1c             	sub    $0x1c,%esp
80101de9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101dec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101df1:	0f 85 85 00 00 00    	jne    80101e7c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101df7:	8b 53 58             	mov    0x58(%ebx),%edx
80101dfa:	31 ff                	xor    %edi,%edi
80101dfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dff:	85 d2                	test   %edx,%edx
80101e01:	74 3e                	je     80101e41 <dirlookup+0x61>
80101e03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e07:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e08:	6a 10                	push   $0x10
80101e0a:	57                   	push   %edi
80101e0b:	56                   	push   %esi
80101e0c:	53                   	push   %ebx
80101e0d:	e8 7e fd ff ff       	call   80101b90 <readi>
80101e12:	83 c4 10             	add    $0x10,%esp
80101e15:	83 f8 10             	cmp    $0x10,%eax
80101e18:	75 55                	jne    80101e6f <dirlookup+0x8f>
      panic("dirlink read");
    if(de.inum == 0)
80101e1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e1f:	74 18                	je     80101e39 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101e21:	83 ec 04             	sub    $0x4,%esp
80101e24:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e27:	6a 0e                	push   $0xe
80101e29:	50                   	push   %eax
80101e2a:	ff 75 0c             	pushl  0xc(%ebp)
80101e2d:	e8 4e 2d 00 00       	call   80104b80 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e32:	83 c4 10             	add    $0x10,%esp
80101e35:	85 c0                	test   %eax,%eax
80101e37:	74 17                	je     80101e50 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e39:	83 c7 10             	add    $0x10,%edi
80101e3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e3f:	72 c7                	jb     80101e08 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101e44:	31 c0                	xor    %eax,%eax
}
80101e46:	5b                   	pop    %ebx
80101e47:	5e                   	pop    %esi
80101e48:	5f                   	pop    %edi
80101e49:	5d                   	pop    %ebp
80101e4a:	c3                   	ret    
80101e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e4f:	90                   	nop
      if(poff)
80101e50:	8b 45 10             	mov    0x10(%ebp),%eax
80101e53:	85 c0                	test   %eax,%eax
80101e55:	74 05                	je     80101e5c <dirlookup+0x7c>
        *poff = off;
80101e57:	8b 45 10             	mov    0x10(%ebp),%eax
80101e5a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e60:	8b 03                	mov    (%ebx),%eax
80101e62:	e8 79 f5 ff ff       	call   801013e0 <iget>
}
80101e67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e6a:	5b                   	pop    %ebx
80101e6b:	5e                   	pop    %esi
80101e6c:	5f                   	pop    %edi
80101e6d:	5d                   	pop    %ebp
80101e6e:	c3                   	ret    
      panic("dirlink read");
80101e6f:	83 ec 0c             	sub    $0xc,%esp
80101e72:	68 95 77 10 80       	push   $0x80107795
80101e77:	e8 04 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101e7c:	83 ec 0c             	sub    $0xc,%esp
80101e7f:	68 83 77 10 80       	push   $0x80107783
80101e84:	e8 f7 e4 ff ff       	call   80100380 <panic>
80101e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e90:	55                   	push   %ebp
80101e91:	89 e5                	mov    %esp,%ebp
80101e93:	57                   	push   %edi
80101e94:	56                   	push   %esi
80101e95:	53                   	push   %ebx
80101e96:	89 c3                	mov    %eax,%ebx
80101e98:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e9b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e9e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ea1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101ea4:	0f 84 64 01 00 00    	je     8010200e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101eaa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&icache.lock);
80101eb0:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(proc->cwd);
80101eb3:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101eb6:	68 60 09 11 80       	push   $0x80110960
80101ebb:	e8 80 29 00 00       	call   80104840 <acquire>
  ip->ref++;
80101ec0:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ec4:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101ecb:	e8 50 2b 00 00       	call   80104a20 <release>
80101ed0:	83 c4 10             	add    $0x10,%esp
80101ed3:	eb 06                	jmp    80101edb <namex+0x4b>
80101ed5:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80101ed8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101edb:	0f b6 03             	movzbl (%ebx),%eax
80101ede:	3c 2f                	cmp    $0x2f,%al
80101ee0:	74 f6                	je     80101ed8 <namex+0x48>
  if(*path == 0)
80101ee2:	84 c0                	test   %al,%al
80101ee4:	0f 84 06 01 00 00    	je     80101ff0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101eea:	0f b6 03             	movzbl (%ebx),%eax
80101eed:	84 c0                	test   %al,%al
80101eef:	0f 84 10 01 00 00    	je     80102005 <namex+0x175>
80101ef5:	89 df                	mov    %ebx,%edi
80101ef7:	3c 2f                	cmp    $0x2f,%al
80101ef9:	0f 84 06 01 00 00    	je     80102005 <namex+0x175>
80101eff:	90                   	nop
80101f00:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101f04:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101f07:	3c 2f                	cmp    $0x2f,%al
80101f09:	74 04                	je     80101f0f <namex+0x7f>
80101f0b:	84 c0                	test   %al,%al
80101f0d:	75 f1                	jne    80101f00 <namex+0x70>
  len = path - s;
80101f0f:	89 f8                	mov    %edi,%eax
80101f11:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101f13:	83 f8 0d             	cmp    $0xd,%eax
80101f16:	0f 8e ac 00 00 00    	jle    80101fc8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101f1c:	83 ec 04             	sub    $0x4,%esp
80101f1f:	6a 0e                	push   $0xe
80101f21:	53                   	push   %ebx
    path++;
80101f22:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101f24:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f27:	e8 e4 2b 00 00       	call   80104b10 <memmove>
80101f2c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f2f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f32:	75 0c                	jne    80101f40 <namex+0xb0>
80101f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f38:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f3e:	74 f8                	je     80101f38 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f40:	83 ec 0c             	sub    $0xc,%esp
80101f43:	56                   	push   %esi
80101f44:	e8 57 f9 ff ff       	call   801018a0 <ilock>
    if(ip->type != T_DIR){
80101f49:	83 c4 10             	add    $0x10,%esp
80101f4c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f51:	0f 85 cd 00 00 00    	jne    80102024 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f5a:	85 c0                	test   %eax,%eax
80101f5c:	74 09                	je     80101f67 <namex+0xd7>
80101f5e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f61:	0f 84 22 01 00 00    	je     80102089 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f67:	83 ec 04             	sub    $0x4,%esp
80101f6a:	6a 00                	push   $0x0
80101f6c:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f6f:	56                   	push   %esi
80101f70:	e8 6b fe ff ff       	call   80101de0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f75:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101f78:	83 c4 10             	add    $0x10,%esp
80101f7b:	89 c7                	mov    %eax,%edi
80101f7d:	85 c0                	test   %eax,%eax
80101f7f:	0f 84 e1 00 00 00    	je     80102066 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f85:	83 ec 0c             	sub    $0xc,%esp
80101f88:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101f8b:	52                   	push   %edx
80101f8c:	e8 5f 28 00 00       	call   801047f0 <holdingsleep>
80101f91:	83 c4 10             	add    $0x10,%esp
80101f94:	85 c0                	test   %eax,%eax
80101f96:	0f 84 30 01 00 00    	je     801020cc <namex+0x23c>
80101f9c:	8b 56 08             	mov    0x8(%esi),%edx
80101f9f:	85 d2                	test   %edx,%edx
80101fa1:	0f 8e 25 01 00 00    	jle    801020cc <namex+0x23c>
  releasesleep(&ip->lock);
80101fa7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101faa:	83 ec 0c             	sub    $0xc,%esp
80101fad:	52                   	push   %edx
80101fae:	e8 fd 27 00 00       	call   801047b0 <releasesleep>
  iput(ip);
80101fb3:	89 34 24             	mov    %esi,(%esp)
80101fb6:	89 fe                	mov    %edi,%esi
80101fb8:	e8 13 fa ff ff       	call   801019d0 <iput>
80101fbd:	83 c4 10             	add    $0x10,%esp
80101fc0:	e9 16 ff ff ff       	jmp    80101edb <namex+0x4b>
80101fc5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101fc8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101fcb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101fce:	83 ec 04             	sub    $0x4,%esp
80101fd1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101fd4:	50                   	push   %eax
80101fd5:	53                   	push   %ebx
    name[len] = 0;
80101fd6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101fd8:	ff 75 e4             	pushl  -0x1c(%ebp)
80101fdb:	e8 30 2b 00 00       	call   80104b10 <memmove>
    name[len] = 0;
80101fe0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101fe3:	83 c4 10             	add    $0x10,%esp
80101fe6:	c6 02 00             	movb   $0x0,(%edx)
80101fe9:	e9 41 ff ff ff       	jmp    80101f2f <namex+0x9f>
80101fee:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ff0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ff3:	85 c0                	test   %eax,%eax
80101ff5:	0f 85 be 00 00 00    	jne    801020b9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80101ffb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ffe:	89 f0                	mov    %esi,%eax
80102000:	5b                   	pop    %ebx
80102001:	5e                   	pop    %esi
80102002:	5f                   	pop    %edi
80102003:	5d                   	pop    %ebp
80102004:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102005:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102008:	89 df                	mov    %ebx,%edi
8010200a:	31 c0                	xor    %eax,%eax
8010200c:	eb c0                	jmp    80101fce <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
8010200e:	ba 01 00 00 00       	mov    $0x1,%edx
80102013:	b8 01 00 00 00       	mov    $0x1,%eax
80102018:	e8 c3 f3 ff ff       	call   801013e0 <iget>
8010201d:	89 c6                	mov    %eax,%esi
8010201f:	e9 b7 fe ff ff       	jmp    80101edb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102024:	83 ec 0c             	sub    $0xc,%esp
80102027:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010202a:	53                   	push   %ebx
8010202b:	e8 c0 27 00 00       	call   801047f0 <holdingsleep>
80102030:	83 c4 10             	add    $0x10,%esp
80102033:	85 c0                	test   %eax,%eax
80102035:	0f 84 91 00 00 00    	je     801020cc <namex+0x23c>
8010203b:	8b 46 08             	mov    0x8(%esi),%eax
8010203e:	85 c0                	test   %eax,%eax
80102040:	0f 8e 86 00 00 00    	jle    801020cc <namex+0x23c>
  releasesleep(&ip->lock);
80102046:	83 ec 0c             	sub    $0xc,%esp
80102049:	53                   	push   %ebx
8010204a:	e8 61 27 00 00       	call   801047b0 <releasesleep>
  iput(ip);
8010204f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102052:	31 f6                	xor    %esi,%esi
  iput(ip);
80102054:	e8 77 f9 ff ff       	call   801019d0 <iput>
      return 0;
80102059:	83 c4 10             	add    $0x10,%esp
}
8010205c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010205f:	89 f0                	mov    %esi,%eax
80102061:	5b                   	pop    %ebx
80102062:	5e                   	pop    %esi
80102063:	5f                   	pop    %edi
80102064:	5d                   	pop    %ebp
80102065:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102066:	83 ec 0c             	sub    $0xc,%esp
80102069:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010206c:	52                   	push   %edx
8010206d:	e8 7e 27 00 00       	call   801047f0 <holdingsleep>
80102072:	83 c4 10             	add    $0x10,%esp
80102075:	85 c0                	test   %eax,%eax
80102077:	74 53                	je     801020cc <namex+0x23c>
80102079:	8b 4e 08             	mov    0x8(%esi),%ecx
8010207c:	85 c9                	test   %ecx,%ecx
8010207e:	7e 4c                	jle    801020cc <namex+0x23c>
  releasesleep(&ip->lock);
80102080:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102083:	83 ec 0c             	sub    $0xc,%esp
80102086:	52                   	push   %edx
80102087:	eb c1                	jmp    8010204a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102089:	83 ec 0c             	sub    $0xc,%esp
8010208c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010208f:	53                   	push   %ebx
80102090:	e8 5b 27 00 00       	call   801047f0 <holdingsleep>
80102095:	83 c4 10             	add    $0x10,%esp
80102098:	85 c0                	test   %eax,%eax
8010209a:	74 30                	je     801020cc <namex+0x23c>
8010209c:	8b 7e 08             	mov    0x8(%esi),%edi
8010209f:	85 ff                	test   %edi,%edi
801020a1:	7e 29                	jle    801020cc <namex+0x23c>
  releasesleep(&ip->lock);
801020a3:	83 ec 0c             	sub    $0xc,%esp
801020a6:	53                   	push   %ebx
801020a7:	e8 04 27 00 00       	call   801047b0 <releasesleep>
}
801020ac:	83 c4 10             	add    $0x10,%esp
}
801020af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b2:	89 f0                	mov    %esi,%eax
801020b4:	5b                   	pop    %ebx
801020b5:	5e                   	pop    %esi
801020b6:	5f                   	pop    %edi
801020b7:	5d                   	pop    %ebp
801020b8:	c3                   	ret    
    iput(ip);
801020b9:	83 ec 0c             	sub    $0xc,%esp
801020bc:	56                   	push   %esi
    return 0;
801020bd:	31 f6                	xor    %esi,%esi
    iput(ip);
801020bf:	e8 0c f9 ff ff       	call   801019d0 <iput>
    return 0;
801020c4:	83 c4 10             	add    $0x10,%esp
801020c7:	e9 2f ff ff ff       	jmp    80101ffb <namex+0x16b>
    panic("iunlock");
801020cc:	83 ec 0c             	sub    $0xc,%esp
801020cf:	68 7b 77 10 80       	push   $0x8010777b
801020d4:	e8 a7 e2 ff ff       	call   80100380 <panic>
801020d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020e0 <dirlink>:
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	57                   	push   %edi
801020e4:	56                   	push   %esi
801020e5:	53                   	push   %ebx
801020e6:	83 ec 20             	sub    $0x20,%esp
801020e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801020ec:	6a 00                	push   $0x0
801020ee:	ff 75 0c             	pushl  0xc(%ebp)
801020f1:	53                   	push   %ebx
801020f2:	e8 e9 fc ff ff       	call   80101de0 <dirlookup>
801020f7:	83 c4 10             	add    $0x10,%esp
801020fa:	85 c0                	test   %eax,%eax
801020fc:	75 67                	jne    80102165 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020fe:	8b 7b 58             	mov    0x58(%ebx),%edi
80102101:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102104:	85 ff                	test   %edi,%edi
80102106:	74 29                	je     80102131 <dirlink+0x51>
80102108:	31 ff                	xor    %edi,%edi
8010210a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010210d:	eb 09                	jmp    80102118 <dirlink+0x38>
8010210f:	90                   	nop
80102110:	83 c7 10             	add    $0x10,%edi
80102113:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102116:	73 19                	jae    80102131 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102118:	6a 10                	push   $0x10
8010211a:	57                   	push   %edi
8010211b:	56                   	push   %esi
8010211c:	53                   	push   %ebx
8010211d:	e8 6e fa ff ff       	call   80101b90 <readi>
80102122:	83 c4 10             	add    $0x10,%esp
80102125:	83 f8 10             	cmp    $0x10,%eax
80102128:	75 4e                	jne    80102178 <dirlink+0x98>
    if(de.inum == 0)
8010212a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010212f:	75 df                	jne    80102110 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102131:	83 ec 04             	sub    $0x4,%esp
80102134:	8d 45 da             	lea    -0x26(%ebp),%eax
80102137:	6a 0e                	push   $0xe
80102139:	ff 75 0c             	pushl  0xc(%ebp)
8010213c:	50                   	push   %eax
8010213d:	e8 8e 2a 00 00       	call   80104bd0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102142:	6a 10                	push   $0x10
  de.inum = inum;
80102144:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102147:	57                   	push   %edi
80102148:	56                   	push   %esi
80102149:	53                   	push   %ebx
  de.inum = inum;
8010214a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010214e:	e8 3d fb ff ff       	call   80101c90 <writei>
80102153:	83 c4 20             	add    $0x20,%esp
80102156:	83 f8 10             	cmp    $0x10,%eax
80102159:	75 2a                	jne    80102185 <dirlink+0xa5>
  return 0;
8010215b:	31 c0                	xor    %eax,%eax
}
8010215d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102160:	5b                   	pop    %ebx
80102161:	5e                   	pop    %esi
80102162:	5f                   	pop    %edi
80102163:	5d                   	pop    %ebp
80102164:	c3                   	ret    
    iput(ip);
80102165:	83 ec 0c             	sub    $0xc,%esp
80102168:	50                   	push   %eax
80102169:	e8 62 f8 ff ff       	call   801019d0 <iput>
    return -1;
8010216e:	83 c4 10             	add    $0x10,%esp
80102171:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102176:	eb e5                	jmp    8010215d <dirlink+0x7d>
      panic("dirlink read");
80102178:	83 ec 0c             	sub    $0xc,%esp
8010217b:	68 95 77 10 80       	push   $0x80107795
80102180:	e8 fb e1 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102185:	83 ec 0c             	sub    $0xc,%esp
80102188:	68 fe 7d 10 80       	push   $0x80107dfe
8010218d:	e8 ee e1 ff ff       	call   80100380 <panic>
80102192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021a0 <namei>:

struct inode*
namei(char *path)
{
801021a0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801021a1:	31 d2                	xor    %edx,%edx
{
801021a3:	89 e5                	mov    %esp,%ebp
801021a5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801021a8:	8b 45 08             	mov    0x8(%ebp),%eax
801021ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801021ae:	e8 dd fc ff ff       	call   80101e90 <namex>
}
801021b3:	c9                   	leave  
801021b4:	c3                   	ret    
801021b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801021c0:	55                   	push   %ebp
  return namex(path, 1, name);
801021c1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801021c6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801021c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801021cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801021ce:	5d                   	pop    %ebp
  return namex(path, 1, name);
801021cf:	e9 bc fc ff ff       	jmp    80101e90 <namex>
801021d4:	66 90                	xchg   %ax,%ax
801021d6:	66 90                	xchg   %ax,%ax
801021d8:	66 90                	xchg   %ax,%ax
801021da:	66 90                	xchg   %ax,%ax
801021dc:	66 90                	xchg   %ax,%ax
801021de:	66 90                	xchg   %ax,%ax

801021e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801021e0:	55                   	push   %ebp
801021e1:	89 e5                	mov    %esp,%ebp
801021e3:	57                   	push   %edi
801021e4:	56                   	push   %esi
801021e5:	53                   	push   %ebx
801021e6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801021e9:	85 c0                	test   %eax,%eax
801021eb:	0f 84 b4 00 00 00    	je     801022a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801021f1:	8b 70 08             	mov    0x8(%eax),%esi
801021f4:	89 c3                	mov    %eax,%ebx
801021f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801021fc:	0f 87 96 00 00 00    	ja     80102298 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102202:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010220e:	66 90                	xchg   %ax,%ax
80102210:	89 ca                	mov    %ecx,%edx
80102212:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102213:	83 e0 c0             	and    $0xffffffc0,%eax
80102216:	3c 40                	cmp    $0x40,%al
80102218:	75 f6                	jne    80102210 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010221a:	31 ff                	xor    %edi,%edi
8010221c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102221:	89 f8                	mov    %edi,%eax
80102223:	ee                   	out    %al,(%dx)
80102224:	b8 01 00 00 00       	mov    $0x1,%eax
80102229:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010222e:	ee                   	out    %al,(%dx)
8010222f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102234:	89 f0                	mov    %esi,%eax
80102236:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102237:	89 f0                	mov    %esi,%eax
80102239:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010223e:	c1 f8 08             	sar    $0x8,%eax
80102241:	ee                   	out    %al,(%dx)
80102242:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102247:	89 f8                	mov    %edi,%eax
80102249:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010224a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010224e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102253:	c1 e0 04             	shl    $0x4,%eax
80102256:	83 e0 10             	and    $0x10,%eax
80102259:	83 c8 e0             	or     $0xffffffe0,%eax
8010225c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010225d:	f6 03 04             	testb  $0x4,(%ebx)
80102260:	75 16                	jne    80102278 <idestart+0x98>
80102262:	b8 20 00 00 00       	mov    $0x20,%eax
80102267:	89 ca                	mov    %ecx,%edx
80102269:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010226a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010226d:	5b                   	pop    %ebx
8010226e:	5e                   	pop    %esi
8010226f:	5f                   	pop    %edi
80102270:	5d                   	pop    %ebp
80102271:	c3                   	ret    
80102272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102278:	b8 30 00 00 00       	mov    $0x30,%eax
8010227d:	89 ca                	mov    %ecx,%edx
8010227f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102280:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102285:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102288:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010228d:	fc                   	cld    
8010228e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102290:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102293:	5b                   	pop    %ebx
80102294:	5e                   	pop    %esi
80102295:	5f                   	pop    %edi
80102296:	5d                   	pop    %ebp
80102297:	c3                   	ret    
    panic("incorrect blockno");
80102298:	83 ec 0c             	sub    $0xc,%esp
8010229b:	68 00 78 10 80       	push   $0x80107800
801022a0:	e8 db e0 ff ff       	call   80100380 <panic>
    panic("idestart");
801022a5:	83 ec 0c             	sub    $0xc,%esp
801022a8:	68 f7 77 10 80       	push   $0x801077f7
801022ad:	e8 ce e0 ff ff       	call   80100380 <panic>
801022b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801022c0 <ideinit>:
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801022c6:	68 12 78 10 80       	push   $0x80107812
801022cb:	68 00 26 11 80       	push   $0x80112600
801022d0:	e8 4b 25 00 00       	call   80104820 <initlock>
  picenable(IRQ_IDE);
801022d5:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
801022dc:	e8 0f 13 00 00       	call   801035f0 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
801022e1:	58                   	pop    %eax
801022e2:	a1 84 27 11 80       	mov    0x80112784,%eax
801022e7:	5a                   	pop    %edx
801022e8:	83 e8 01             	sub    $0x1,%eax
801022eb:	50                   	push   %eax
801022ec:	6a 0e                	push   $0xe
801022ee:	e8 bd 02 00 00       	call   801025b0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022f3:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022f6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022ff:	90                   	nop
80102300:	ec                   	in     (%dx),%al
80102301:	83 e0 c0             	and    $0xffffffc0,%eax
80102304:	3c 40                	cmp    $0x40,%al
80102306:	75 f8                	jne    80102300 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102308:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010230d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102312:	ee                   	out    %al,(%dx)
80102313:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102318:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010231d:	eb 06                	jmp    80102325 <ideinit+0x65>
8010231f:	90                   	nop
  for(i=0; i<1000; i++){
80102320:	83 e9 01             	sub    $0x1,%ecx
80102323:	74 0f                	je     80102334 <ideinit+0x74>
80102325:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102326:	84 c0                	test   %al,%al
80102328:	74 f6                	je     80102320 <ideinit+0x60>
      havedisk1 = 1;
8010232a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102331:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102334:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102339:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010233e:	ee                   	out    %al,(%dx)
}
8010233f:	c9                   	leave  
80102340:	c3                   	ret    
80102341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102348:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010234f:	90                   	nop

80102350 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102350:	55                   	push   %ebp
80102351:	89 e5                	mov    %esp,%ebp
80102353:	57                   	push   %edi
80102354:	56                   	push   %esi
80102355:	53                   	push   %ebx
80102356:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102359:	68 00 26 11 80       	push   $0x80112600
8010235e:	e8 dd 24 00 00       	call   80104840 <acquire>
  if((b = idequeue) == 0){
80102363:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102369:	83 c4 10             	add    $0x10,%esp
8010236c:	85 db                	test   %ebx,%ebx
8010236e:	74 63                	je     801023d3 <ideintr+0x83>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
80102370:	8b 43 58             	mov    0x58(%ebx),%eax
80102373:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102378:	8b 33                	mov    (%ebx),%esi
8010237a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102380:	75 2f                	jne    801023b1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102382:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010238e:	66 90                	xchg   %ax,%ax
80102390:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102391:	89 c1                	mov    %eax,%ecx
80102393:	83 e1 c0             	and    $0xffffffc0,%ecx
80102396:	80 f9 40             	cmp    $0x40,%cl
80102399:	75 f5                	jne    80102390 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010239b:	a8 21                	test   $0x21,%al
8010239d:	75 12                	jne    801023b1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010239f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801023a2:	b9 80 00 00 00       	mov    $0x80,%ecx
801023a7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023ac:	fc                   	cld    
801023ad:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801023af:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801023b1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801023b4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801023b7:	83 ce 02             	or     $0x2,%esi
801023ba:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801023bc:	53                   	push   %ebx
801023bd:	e8 de 1e 00 00       	call   801042a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801023c2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801023c7:	83 c4 10             	add    $0x10,%esp
801023ca:	85 c0                	test   %eax,%eax
801023cc:	74 05                	je     801023d3 <ideintr+0x83>
    idestart(idequeue);
801023ce:	e8 0d fe ff ff       	call   801021e0 <idestart>
    release(&idelock);
801023d3:	83 ec 0c             	sub    $0xc,%esp
801023d6:	68 00 26 11 80       	push   $0x80112600
801023db:	e8 40 26 00 00       	call   80104a20 <release>

  release(&idelock);
}
801023e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023e3:	5b                   	pop    %ebx
801023e4:	5e                   	pop    %esi
801023e5:	5f                   	pop    %edi
801023e6:	5d                   	pop    %ebp
801023e7:	c3                   	ret    
801023e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ef:	90                   	nop

801023f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	53                   	push   %ebx
801023f4:	83 ec 10             	sub    $0x10,%esp
801023f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801023fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801023fd:	50                   	push   %eax
801023fe:	e8 ed 23 00 00       	call   801047f0 <holdingsleep>
80102403:	83 c4 10             	add    $0x10,%esp
80102406:	85 c0                	test   %eax,%eax
80102408:	0f 84 c3 00 00 00    	je     801024d1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010240e:	8b 03                	mov    (%ebx),%eax
80102410:	83 e0 06             	and    $0x6,%eax
80102413:	83 f8 02             	cmp    $0x2,%eax
80102416:	0f 84 a8 00 00 00    	je     801024c4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010241c:	8b 53 04             	mov    0x4(%ebx),%edx
8010241f:	85 d2                	test   %edx,%edx
80102421:	74 0d                	je     80102430 <iderw+0x40>
80102423:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102428:	85 c0                	test   %eax,%eax
8010242a:	0f 84 87 00 00 00    	je     801024b7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102430:	83 ec 0c             	sub    $0xc,%esp
80102433:	68 00 26 11 80       	push   $0x80112600
80102438:	e8 03 24 00 00       	call   80104840 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010243d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102442:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102449:	83 c4 10             	add    $0x10,%esp
8010244c:	85 c0                	test   %eax,%eax
8010244e:	74 60                	je     801024b0 <iderw+0xc0>
80102450:	89 c2                	mov    %eax,%edx
80102452:	8b 40 58             	mov    0x58(%eax),%eax
80102455:	85 c0                	test   %eax,%eax
80102457:	75 f7                	jne    80102450 <iderw+0x60>
80102459:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010245c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010245e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102464:	74 3a                	je     801024a0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102466:	8b 03                	mov    (%ebx),%eax
80102468:	83 e0 06             	and    $0x6,%eax
8010246b:	83 f8 02             	cmp    $0x2,%eax
8010246e:	74 1b                	je     8010248b <iderw+0x9b>
    sleep(b, &idelock);
80102470:	83 ec 08             	sub    $0x8,%esp
80102473:	68 00 26 11 80       	push   $0x80112600
80102478:	53                   	push   %ebx
80102479:	e8 62 1d 00 00       	call   801041e0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010247e:	8b 03                	mov    (%ebx),%eax
80102480:	83 c4 10             	add    $0x10,%esp
80102483:	83 e0 06             	and    $0x6,%eax
80102486:	83 f8 02             	cmp    $0x2,%eax
80102489:	75 e5                	jne    80102470 <iderw+0x80>
  }

  release(&idelock);
8010248b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102492:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102495:	c9                   	leave  
  release(&idelock);
80102496:	e9 85 25 00 00       	jmp    80104a20 <release>
8010249b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010249f:	90                   	nop
    idestart(b);
801024a0:	89 d8                	mov    %ebx,%eax
801024a2:	e8 39 fd ff ff       	call   801021e0 <idestart>
801024a7:	eb bd                	jmp    80102466 <iderw+0x76>
801024a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024b0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801024b5:	eb a5                	jmp    8010245c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801024b7:	83 ec 0c             	sub    $0xc,%esp
801024ba:	68 41 78 10 80       	push   $0x80107841
801024bf:	e8 bc de ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801024c4:	83 ec 0c             	sub    $0xc,%esp
801024c7:	68 2c 78 10 80       	push   $0x8010782c
801024cc:	e8 af de ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801024d1:	83 ec 0c             	sub    $0xc,%esp
801024d4:	68 16 78 10 80       	push   $0x80107816
801024d9:	e8 a2 de ff ff       	call   80100380 <panic>
801024de:	66 90                	xchg   %ax,%ax

801024e0 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
801024e0:	a1 88 27 11 80       	mov    0x80112788,%eax
801024e5:	85 c0                	test   %eax,%eax
801024e7:	0f 84 b3 00 00 00    	je     801025a0 <ioapicinit+0xc0>
{
801024ed:	55                   	push   %ebp
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801024ee:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801024f5:	00 c0 fe 
{
801024f8:	89 e5                	mov    %esp,%ebp
801024fa:	56                   	push   %esi
801024fb:	53                   	push   %ebx
  ioapic->reg = reg;
801024fc:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102503:	00 00 00 
  return ioapic->data;
80102506:	8b 15 34 26 11 80    	mov    0x80112634,%edx
8010250c:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
8010250f:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102515:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010251b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102522:	c1 ee 10             	shr    $0x10,%esi
80102525:	89 f0                	mov    %esi,%eax
80102527:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010252a:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
8010252d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102530:	39 c2                	cmp    %eax,%edx
80102532:	75 4c                	jne    80102580 <ioapicinit+0xa0>
80102534:	83 c6 21             	add    $0x21,%esi
{
80102537:	ba 10 00 00 00       	mov    $0x10,%edx
8010253c:	b8 20 00 00 00       	mov    $0x20,%eax
80102541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102548:	89 11                	mov    %edx,(%ecx)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010254a:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
8010254c:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
80102552:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102555:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
8010255b:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
8010255e:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102561:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102564:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102566:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010256c:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
80102573:	39 f0                	cmp    %esi,%eax
80102575:	75 d1                	jne    80102548 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102577:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010257a:	5b                   	pop    %ebx
8010257b:	5e                   	pop    %esi
8010257c:	5d                   	pop    %ebp
8010257d:	c3                   	ret    
8010257e:	66 90                	xchg   %ax,%ax
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102580:	83 ec 0c             	sub    $0xc,%esp
80102583:	68 60 78 10 80       	push   $0x80107860
80102588:	e8 f3 e0 ff ff       	call   80100680 <cprintf>
  ioapic->reg = reg;
8010258d:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102593:	83 c4 10             	add    $0x10,%esp
80102596:	eb 9c                	jmp    80102534 <ioapicinit+0x54>
80102598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010259f:	90                   	nop
801025a0:	c3                   	ret    
801025a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025af:	90                   	nop

801025b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801025b0:	55                   	push   %ebp
  if(!ismp)
801025b1:	8b 15 88 27 11 80    	mov    0x80112788,%edx
{
801025b7:	89 e5                	mov    %esp,%ebp
801025b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
801025bc:	85 d2                	test   %edx,%edx
801025be:	74 2b                	je     801025eb <ioapicenable+0x3b>
  ioapic->reg = reg;
801025c0:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801025c6:	8d 50 20             	lea    0x20(%eax),%edx
801025c9:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801025cd:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025cf:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025d5:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801025d8:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025db:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801025de:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801025e0:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801025e5:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801025e8:	89 50 10             	mov    %edx,0x10(%eax)
}
801025eb:	5d                   	pop    %ebp
801025ec:	c3                   	ret    
801025ed:	66 90                	xchg   %ax,%ax
801025ef:	90                   	nop

801025f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	53                   	push   %ebx
801025f4:	83 ec 04             	sub    $0x4,%esp
801025f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801025fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102600:	75 76                	jne    80102678 <kfree+0x88>
80102602:	81 fb d0 62 11 80    	cmp    $0x801162d0,%ebx
80102608:	72 6e                	jb     80102678 <kfree+0x88>
8010260a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102610:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102615:	77 61                	ja     80102678 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102617:	83 ec 04             	sub    $0x4,%esp
8010261a:	68 00 10 00 00       	push   $0x1000
8010261f:	6a 01                	push   $0x1
80102621:	53                   	push   %ebx
80102622:	e8 49 24 00 00       	call   80104a70 <memset>

  if(kmem.use_lock)
80102627:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010262d:	83 c4 10             	add    $0x10,%esp
80102630:	85 d2                	test   %edx,%edx
80102632:	75 1c                	jne    80102650 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102634:	a1 78 26 11 80       	mov    0x80112678,%eax
80102639:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010263b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102640:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102646:	85 c0                	test   %eax,%eax
80102648:	75 1e                	jne    80102668 <kfree+0x78>
    release(&kmem.lock);
}
8010264a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010264d:	c9                   	leave  
8010264e:	c3                   	ret    
8010264f:	90                   	nop
    acquire(&kmem.lock);
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	68 40 26 11 80       	push   $0x80112640
80102658:	e8 e3 21 00 00       	call   80104840 <acquire>
8010265d:	83 c4 10             	add    $0x10,%esp
80102660:	eb d2                	jmp    80102634 <kfree+0x44>
80102662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102668:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010266f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102672:	c9                   	leave  
    release(&kmem.lock);
80102673:	e9 a8 23 00 00       	jmp    80104a20 <release>
    panic("kfree");
80102678:	83 ec 0c             	sub    $0xc,%esp
8010267b:	68 92 78 10 80       	push   $0x80107892
80102680:	e8 fb dc ff ff       	call   80100380 <panic>
80102685:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010268c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102690 <freerange>:
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102694:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102697:	8b 75 0c             	mov    0xc(%ebp),%esi
8010269a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010269b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026ad:	39 de                	cmp    %ebx,%esi
801026af:	72 23                	jb     801026d4 <freerange+0x44>
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801026b8:	83 ec 0c             	sub    $0xc,%esp
801026bb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026c7:	50                   	push   %eax
801026c8:	e8 23 ff ff ff       	call   801025f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026cd:	83 c4 10             	add    $0x10,%esp
801026d0:	39 f3                	cmp    %esi,%ebx
801026d2:	76 e4                	jbe    801026b8 <freerange+0x28>
}
801026d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026d7:	5b                   	pop    %ebx
801026d8:	5e                   	pop    %esi
801026d9:	5d                   	pop    %ebp
801026da:	c3                   	ret    
801026db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026df:	90                   	nop

801026e0 <kinit2>:
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801026e4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801026e7:	8b 75 0c             	mov    0xc(%ebp),%esi
801026ea:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801026eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026fd:	39 de                	cmp    %ebx,%esi
801026ff:	72 23                	jb     80102724 <kinit2+0x44>
80102701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102708:	83 ec 0c             	sub    $0xc,%esp
8010270b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102711:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102717:	50                   	push   %eax
80102718:	e8 d3 fe ff ff       	call   801025f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010271d:	83 c4 10             	add    $0x10,%esp
80102720:	39 de                	cmp    %ebx,%esi
80102722:	73 e4                	jae    80102708 <kinit2+0x28>
  kmem.use_lock = 1;
80102724:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010272b:	00 00 00 
}
8010272e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102731:	5b                   	pop    %ebx
80102732:	5e                   	pop    %esi
80102733:	5d                   	pop    %ebp
80102734:	c3                   	ret    
80102735:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010273c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102740 <kinit1>:
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
80102743:	56                   	push   %esi
80102744:	53                   	push   %ebx
80102745:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102748:	83 ec 08             	sub    $0x8,%esp
8010274b:	68 98 78 10 80       	push   $0x80107898
80102750:	68 40 26 11 80       	push   $0x80112640
80102755:	e8 c6 20 00 00       	call   80104820 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010275a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010275d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102760:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102767:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010276a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102770:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102776:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010277c:	39 de                	cmp    %ebx,%esi
8010277e:	72 1c                	jb     8010279c <kinit1+0x5c>
    kfree(p);
80102780:	83 ec 0c             	sub    $0xc,%esp
80102783:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102789:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010278f:	50                   	push   %eax
80102790:	e8 5b fe ff ff       	call   801025f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102795:	83 c4 10             	add    $0x10,%esp
80102798:	39 de                	cmp    %ebx,%esi
8010279a:	73 e4                	jae    80102780 <kinit1+0x40>
}
8010279c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010279f:	5b                   	pop    %ebx
801027a0:	5e                   	pop    %esi
801027a1:	5d                   	pop    %ebp
801027a2:	c3                   	ret    
801027a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801027b0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801027b0:	a1 74 26 11 80       	mov    0x80112674,%eax
801027b5:	85 c0                	test   %eax,%eax
801027b7:	75 1f                	jne    801027d8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801027b9:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801027be:	85 c0                	test   %eax,%eax
801027c0:	74 0e                	je     801027d0 <kalloc+0x20>
    kmem.freelist = r->next;
801027c2:	8b 10                	mov    (%eax),%edx
801027c4:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801027ca:	c3                   	ret    
801027cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027cf:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801027d0:	c3                   	ret    
801027d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801027d8:	55                   	push   %ebp
801027d9:	89 e5                	mov    %esp,%ebp
801027db:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801027de:	68 40 26 11 80       	push   $0x80112640
801027e3:	e8 58 20 00 00       	call   80104840 <acquire>
  r = kmem.freelist;
801027e8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801027ed:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801027f3:	83 c4 10             	add    $0x10,%esp
801027f6:	85 c0                	test   %eax,%eax
801027f8:	74 08                	je     80102802 <kalloc+0x52>
    kmem.freelist = r->next;
801027fa:	8b 08                	mov    (%eax),%ecx
801027fc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102802:	85 d2                	test   %edx,%edx
80102804:	74 16                	je     8010281c <kalloc+0x6c>
    release(&kmem.lock);
80102806:	83 ec 0c             	sub    $0xc,%esp
80102809:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010280c:	68 40 26 11 80       	push   $0x80112640
80102811:	e8 0a 22 00 00       	call   80104a20 <release>
  return (char*)r;
80102816:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102819:	83 c4 10             	add    $0x10,%esp
}
8010281c:	c9                   	leave  
8010281d:	c3                   	ret    
8010281e:	66 90                	xchg   %ax,%ax

80102820 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102820:	ba 64 00 00 00       	mov    $0x64,%edx
80102825:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102826:	a8 01                	test   $0x1,%al
80102828:	0f 84 ca 00 00 00    	je     801028f8 <kbdgetc+0xd8>
{
8010282e:	55                   	push   %ebp
8010282f:	ba 60 00 00 00       	mov    $0x60,%edx
80102834:	89 e5                	mov    %esp,%ebp
80102836:	53                   	push   %ebx
80102837:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102838:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
8010283e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102841:	3c e0                	cmp    $0xe0,%al
80102843:	74 5b                	je     801028a0 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102845:	89 da                	mov    %ebx,%edx
80102847:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010284a:	84 c0                	test   %al,%al
8010284c:	78 62                	js     801028b0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010284e:	85 d2                	test   %edx,%edx
80102850:	74 09                	je     8010285b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102852:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102855:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102858:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010285b:	0f b6 91 c0 79 10 80 	movzbl -0x7fef8640(%ecx),%edx
  shift ^= togglecode[data];
80102862:	0f b6 81 c0 78 10 80 	movzbl -0x7fef8740(%ecx),%eax
  shift |= shiftcode[data];
80102869:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010286b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010286d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010286f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102875:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102878:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010287b:	8b 04 85 a0 78 10 80 	mov    -0x7fef8760(,%eax,4),%eax
80102882:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102886:	74 0b                	je     80102893 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102888:	8d 50 9f             	lea    -0x61(%eax),%edx
8010288b:	83 fa 19             	cmp    $0x19,%edx
8010288e:	77 50                	ja     801028e0 <kbdgetc+0xc0>
      c += 'A' - 'a';
80102890:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102893:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102896:	c9                   	leave  
80102897:	c3                   	ret    
80102898:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010289f:	90                   	nop
    shift |= E0ESC;
801028a0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801028a3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801028a5:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
801028ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028ae:	c9                   	leave  
801028af:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
801028b0:	83 e0 7f             	and    $0x7f,%eax
801028b3:	85 d2                	test   %edx,%edx
801028b5:	0f 44 c8             	cmove  %eax,%ecx
    return 0;
801028b8:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801028ba:	0f b6 91 c0 79 10 80 	movzbl -0x7fef8640(%ecx),%edx
801028c1:	83 ca 40             	or     $0x40,%edx
801028c4:	0f b6 d2             	movzbl %dl,%edx
801028c7:	f7 d2                	not    %edx
801028c9:	21 da                	and    %ebx,%edx
}
801028cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
801028ce:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
}
801028d4:	c9                   	leave  
801028d5:	c3                   	ret    
801028d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028dd:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801028e0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801028e3:	8d 50 20             	lea    0x20(%eax),%edx
}
801028e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028e9:	c9                   	leave  
      c += 'a' - 'A';
801028ea:	83 f9 1a             	cmp    $0x1a,%ecx
801028ed:	0f 42 c2             	cmovb  %edx,%eax
}
801028f0:	c3                   	ret    
801028f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801028f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801028fd:	c3                   	ret    
801028fe:	66 90                	xchg   %ax,%ax

80102900 <kbdintr>:

void
kbdintr(void)
{
80102900:	55                   	push   %ebp
80102901:	89 e5                	mov    %esp,%ebp
80102903:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102906:	68 20 28 10 80       	push   $0x80102820
8010290b:	e8 e0 df ff ff       	call   801008f0 <consoleintr>
}
80102910:	83 c4 10             	add    $0x10,%esp
80102913:	c9                   	leave  
80102914:	c3                   	ret    
80102915:	66 90                	xchg   %ax,%ax
80102917:	66 90                	xchg   %ax,%ax
80102919:	66 90                	xchg   %ax,%ax
8010291b:	66 90                	xchg   %ax,%ax
8010291d:	66 90                	xchg   %ax,%ax
8010291f:	90                   	nop

80102920 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102920:	a1 80 26 11 80       	mov    0x80112680,%eax
80102925:	85 c0                	test   %eax,%eax
80102927:	0f 84 cb 00 00 00    	je     801029f8 <lapicinit+0xd8>
  lapic[index] = value;
8010292d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102934:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102937:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010293a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102941:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102944:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102947:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010294e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102951:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102954:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010295b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010295e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102961:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102968:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010296b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010296e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102975:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102978:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010297b:	8b 50 30             	mov    0x30(%eax),%edx
8010297e:	c1 ea 10             	shr    $0x10,%edx
80102981:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102987:	75 77                	jne    80102a00 <lapicinit+0xe0>
  lapic[index] = value;
80102989:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102990:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102993:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102996:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010299d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029a3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801029aa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029ad:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029b0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029b7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029ba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029bd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801029c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029ca:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801029d1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801029d4:	8b 50 20             	mov    0x20(%eax),%edx
801029d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029de:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801029e0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801029e6:	80 e6 10             	and    $0x10,%dh
801029e9:	75 f5                	jne    801029e0 <lapicinit+0xc0>
  lapic[index] = value;
801029eb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801029f2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029f5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801029f8:	c3                   	ret    
801029f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102a00:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a07:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a0a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102a0d:	e9 77 ff ff ff       	jmp    80102989 <lapicinit+0x69>
80102a12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102a20 <cpunum>:

int
cpunum(void)
{
80102a20:	55                   	push   %ebp
80102a21:	89 e5                	mov    %esp,%ebp
80102a23:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102a26:	9c                   	pushf  
80102a27:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102a28:	f6 c4 02             	test   $0x2,%ah
80102a2b:	74 12                	je     80102a3f <cpunum+0x1f>
    static int n;
    if(n++ == 0)
80102a2d:	a1 84 26 11 80       	mov    0x80112684,%eax
80102a32:	8d 50 01             	lea    0x1(%eax),%edx
80102a35:	89 15 84 26 11 80    	mov    %edx,0x80112684
80102a3b:	85 c0                	test   %eax,%eax
80102a3d:	74 49                	je     80102a88 <cpunum+0x68>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
80102a3f:	a1 80 26 11 80       	mov    0x80112680,%eax
80102a44:	85 c0                	test   %eax,%eax
80102a46:	74 38                	je     80102a80 <cpunum+0x60>
    return 0;

  apicid = lapic[ID] >> 24;
80102a48:	8b 40 20             	mov    0x20(%eax),%eax
  for (i = 0; i < ncpu; ++i) {
80102a4b:	8b 15 84 27 11 80    	mov    0x80112784,%edx
  apicid = lapic[ID] >> 24;
80102a51:	c1 e8 18             	shr    $0x18,%eax
  for (i = 0; i < ncpu; ++i) {
80102a54:	85 d2                	test   %edx,%edx
80102a56:	7e 1b                	jle    80102a73 <cpunum+0x53>
    if (cpus[i].apicid == apicid)
80102a58:	0f b6 0d a0 27 11 80 	movzbl 0x801127a0,%ecx
80102a5f:	39 c8                	cmp    %ecx,%eax
80102a61:	74 1d                	je     80102a80 <cpunum+0x60>
  for (i = 0; i < ncpu; ++i) {
80102a63:	83 fa 01             	cmp    $0x1,%edx
80102a66:	74 0b                	je     80102a73 <cpunum+0x53>
    if (cpus[i].apicid == apicid)
80102a68:	0f b6 15 5c 28 11 80 	movzbl 0x8011285c,%edx
80102a6f:	39 c2                	cmp    %eax,%edx
80102a71:	74 2a                	je     80102a9d <cpunum+0x7d>
      return i;
  }
  panic("unknown apicid\n");
80102a73:	83 ec 0c             	sub    $0xc,%esp
80102a76:	68 ec 7a 10 80       	push   $0x80107aec
80102a7b:	e8 00 d9 ff ff       	call   80100380 <panic>
}
80102a80:	c9                   	leave  
    return 0;
80102a81:	31 c0                	xor    %eax,%eax
}
80102a83:	c3                   	ret    
80102a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("cpu called from %x with interrupts enabled\n",
80102a88:	83 ec 08             	sub    $0x8,%esp
80102a8b:	ff 75 04             	pushl  0x4(%ebp)
80102a8e:	68 c0 7a 10 80       	push   $0x80107ac0
80102a93:	e8 e8 db ff ff       	call   80100680 <cprintf>
80102a98:	83 c4 10             	add    $0x10,%esp
80102a9b:	eb a2                	jmp    80102a3f <cpunum+0x1f>
}
80102a9d:	c9                   	leave  
  for (i = 0; i < ncpu; ++i) {
80102a9e:	b8 01 00 00 00       	mov    $0x1,%eax
}
80102aa3:	c3                   	ret    
80102aa4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102aaf:	90                   	nop

80102ab0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102ab0:	a1 80 26 11 80       	mov    0x80112680,%eax
80102ab5:	85 c0                	test   %eax,%eax
80102ab7:	74 0d                	je     80102ac6 <lapiceoi+0x16>
  lapic[index] = value;
80102ab9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ac0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ac3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102ac6:	c3                   	ret    
80102ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ace:	66 90                	xchg   %ax,%ax

80102ad0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102ad0:	c3                   	ret    
80102ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ad8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102adf:	90                   	nop

80102ae0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ae0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae1:	b8 0f 00 00 00       	mov    $0xf,%eax
80102ae6:	ba 70 00 00 00       	mov    $0x70,%edx
80102aeb:	89 e5                	mov    %esp,%ebp
80102aed:	53                   	push   %ebx
80102aee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102af1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102af4:	ee                   	out    %al,(%dx)
80102af5:	b8 0a 00 00 00       	mov    $0xa,%eax
80102afa:	ba 71 00 00 00       	mov    $0x71,%edx
80102aff:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b00:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102b02:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102b05:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b0b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b0d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102b10:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102b12:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b15:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b18:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b1e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102b23:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b29:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b2c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b33:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b36:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b39:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b40:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b43:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b46:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b4c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b4f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b55:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b58:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b5e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b61:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b67:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102b6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b6d:	c9                   	leave  
80102b6e:	c3                   	ret    
80102b6f:	90                   	nop

80102b70 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102b70:	55                   	push   %ebp
80102b71:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b76:	ba 70 00 00 00       	mov    $0x70,%edx
80102b7b:	89 e5                	mov    %esp,%ebp
80102b7d:	57                   	push   %edi
80102b7e:	56                   	push   %esi
80102b7f:	53                   	push   %ebx
80102b80:	83 ec 4c             	sub    $0x4c,%esp
80102b83:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b84:	ba 71 00 00 00       	mov    $0x71,%edx
80102b89:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102b8a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b8d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102b92:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102b95:	8d 76 00             	lea    0x0(%esi),%esi
80102b98:	31 c0                	xor    %eax,%eax
80102b9a:	89 da                	mov    %ebx,%edx
80102b9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b9d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102ba2:	89 ca                	mov    %ecx,%edx
80102ba4:	ec                   	in     (%dx),%al
80102ba5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ba8:	89 da                	mov    %ebx,%edx
80102baa:	b8 02 00 00 00       	mov    $0x2,%eax
80102baf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bb0:	89 ca                	mov    %ecx,%edx
80102bb2:	ec                   	in     (%dx),%al
80102bb3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bb6:	89 da                	mov    %ebx,%edx
80102bb8:	b8 04 00 00 00       	mov    $0x4,%eax
80102bbd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bbe:	89 ca                	mov    %ecx,%edx
80102bc0:	ec                   	in     (%dx),%al
80102bc1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc4:	89 da                	mov    %ebx,%edx
80102bc6:	b8 07 00 00 00       	mov    $0x7,%eax
80102bcb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bcc:	89 ca                	mov    %ecx,%edx
80102bce:	ec                   	in     (%dx),%al
80102bcf:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd2:	89 da                	mov    %ebx,%edx
80102bd4:	b8 08 00 00 00       	mov    $0x8,%eax
80102bd9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bda:	89 ca                	mov    %ecx,%edx
80102bdc:	ec                   	in     (%dx),%al
80102bdd:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bdf:	89 da                	mov    %ebx,%edx
80102be1:	b8 09 00 00 00       	mov    $0x9,%eax
80102be6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102be7:	89 ca                	mov    %ecx,%edx
80102be9:	ec                   	in     (%dx),%al
80102bea:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bec:	89 da                	mov    %ebx,%edx
80102bee:	b8 0a 00 00 00       	mov    $0xa,%eax
80102bf3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf4:	89 ca                	mov    %ecx,%edx
80102bf6:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102bf7:	84 c0                	test   %al,%al
80102bf9:	78 9d                	js     80102b98 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102bfb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102bff:	89 fa                	mov    %edi,%edx
80102c01:	0f b6 fa             	movzbl %dl,%edi
80102c04:	89 f2                	mov    %esi,%edx
80102c06:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c09:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102c0d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c10:	89 da                	mov    %ebx,%edx
80102c12:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102c15:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102c18:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102c1c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102c1f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102c22:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102c26:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102c29:	31 c0                	xor    %eax,%eax
80102c2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c2c:	89 ca                	mov    %ecx,%edx
80102c2e:	ec                   	in     (%dx),%al
80102c2f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c32:	89 da                	mov    %ebx,%edx
80102c34:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102c37:	b8 02 00 00 00       	mov    $0x2,%eax
80102c3c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c3d:	89 ca                	mov    %ecx,%edx
80102c3f:	ec                   	in     (%dx),%al
80102c40:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c43:	89 da                	mov    %ebx,%edx
80102c45:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c48:	b8 04 00 00 00       	mov    $0x4,%eax
80102c4d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4e:	89 ca                	mov    %ecx,%edx
80102c50:	ec                   	in     (%dx),%al
80102c51:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c54:	89 da                	mov    %ebx,%edx
80102c56:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c59:	b8 07 00 00 00       	mov    $0x7,%eax
80102c5e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5f:	89 ca                	mov    %ecx,%edx
80102c61:	ec                   	in     (%dx),%al
80102c62:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c65:	89 da                	mov    %ebx,%edx
80102c67:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c6a:	b8 08 00 00 00       	mov    $0x8,%eax
80102c6f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c70:	89 ca                	mov    %ecx,%edx
80102c72:	ec                   	in     (%dx),%al
80102c73:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c76:	89 da                	mov    %ebx,%edx
80102c78:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c7b:	b8 09 00 00 00       	mov    $0x9,%eax
80102c80:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c81:	89 ca                	mov    %ecx,%edx
80102c83:	ec                   	in     (%dx),%al
80102c84:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c87:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102c8a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102c8d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102c90:	6a 18                	push   $0x18
80102c92:	50                   	push   %eax
80102c93:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102c96:	50                   	push   %eax
80102c97:	e8 24 1e 00 00       	call   80104ac0 <memcmp>
80102c9c:	83 c4 10             	add    $0x10,%esp
80102c9f:	85 c0                	test   %eax,%eax
80102ca1:	0f 85 f1 fe ff ff    	jne    80102b98 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ca7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102cab:	75 78                	jne    80102d25 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102cad:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cb0:	89 c2                	mov    %eax,%edx
80102cb2:	83 e0 0f             	and    $0xf,%eax
80102cb5:	c1 ea 04             	shr    $0x4,%edx
80102cb8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cbb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cbe:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102cc1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102cc4:	89 c2                	mov    %eax,%edx
80102cc6:	83 e0 0f             	and    $0xf,%eax
80102cc9:	c1 ea 04             	shr    $0x4,%edx
80102ccc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ccf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cd2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102cd5:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102cd8:	89 c2                	mov    %eax,%edx
80102cda:	83 e0 0f             	and    $0xf,%eax
80102cdd:	c1 ea 04             	shr    $0x4,%edx
80102ce0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ce3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ce6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102ce9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102cec:	89 c2                	mov    %eax,%edx
80102cee:	83 e0 0f             	and    $0xf,%eax
80102cf1:	c1 ea 04             	shr    $0x4,%edx
80102cf4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cf7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cfa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102cfd:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d00:	89 c2                	mov    %eax,%edx
80102d02:	83 e0 0f             	and    $0xf,%eax
80102d05:	c1 ea 04             	shr    $0x4,%edx
80102d08:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d0b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d0e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d11:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d14:	89 c2                	mov    %eax,%edx
80102d16:	83 e0 0f             	and    $0xf,%eax
80102d19:	c1 ea 04             	shr    $0x4,%edx
80102d1c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d1f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d22:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102d25:	8b 75 08             	mov    0x8(%ebp),%esi
80102d28:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d2b:	89 06                	mov    %eax,(%esi)
80102d2d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d30:	89 46 04             	mov    %eax,0x4(%esi)
80102d33:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d36:	89 46 08             	mov    %eax,0x8(%esi)
80102d39:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d3c:	89 46 0c             	mov    %eax,0xc(%esi)
80102d3f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d42:	89 46 10             	mov    %eax,0x10(%esi)
80102d45:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d48:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102d4b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102d52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d55:	5b                   	pop    %ebx
80102d56:	5e                   	pop    %esi
80102d57:	5f                   	pop    %edi
80102d58:	5d                   	pop    %ebp
80102d59:	c3                   	ret    
80102d5a:	66 90                	xchg   %ax,%ax
80102d5c:	66 90                	xchg   %ax,%ax
80102d5e:	66 90                	xchg   %ax,%ax

80102d60 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d60:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102d66:	85 c9                	test   %ecx,%ecx
80102d68:	0f 8e 8a 00 00 00    	jle    80102df8 <install_trans+0x98>
{
80102d6e:	55                   	push   %ebp
80102d6f:	89 e5                	mov    %esp,%ebp
80102d71:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102d72:	31 ff                	xor    %edi,%edi
{
80102d74:	56                   	push   %esi
80102d75:	53                   	push   %ebx
80102d76:	83 ec 0c             	sub    $0xc,%esp
80102d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102d80:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d85:	83 ec 08             	sub    $0x8,%esp
80102d88:	01 f8                	add    %edi,%eax
80102d8a:	83 c0 01             	add    $0x1,%eax
80102d8d:	50                   	push   %eax
80102d8e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102d94:	e8 37 d3 ff ff       	call   801000d0 <bread>
80102d99:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102d9b:	58                   	pop    %eax
80102d9c:	5a                   	pop    %edx
80102d9d:	ff 34 bd ec 26 11 80 	pushl  -0x7feed914(,%edi,4)
80102da4:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102daa:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dad:	e8 1e d3 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102db2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102db5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102db7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102dba:	68 00 02 00 00       	push   $0x200
80102dbf:	50                   	push   %eax
80102dc0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102dc3:	50                   	push   %eax
80102dc4:	e8 47 1d 00 00       	call   80104b10 <memmove>
    bwrite(dbuf);  // write dst to disk
80102dc9:	89 1c 24             	mov    %ebx,(%esp)
80102dcc:	e8 df d3 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102dd1:	89 34 24             	mov    %esi,(%esp)
80102dd4:	e8 17 d4 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102dd9:	89 1c 24             	mov    %ebx,(%esp)
80102ddc:	e8 0f d4 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102de1:	83 c4 10             	add    $0x10,%esp
80102de4:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102dea:	7f 94                	jg     80102d80 <install_trans+0x20>
  }
}
80102dec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102def:	5b                   	pop    %ebx
80102df0:	5e                   	pop    %esi
80102df1:	5f                   	pop    %edi
80102df2:	5d                   	pop    %ebp
80102df3:	c3                   	ret    
80102df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102df8:	c3                   	ret    
80102df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e00 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	53                   	push   %ebx
80102e04:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e07:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102e0d:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102e13:	e8 b8 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102e18:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102e1e:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e21:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102e23:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102e26:	85 c9                	test   %ecx,%ecx
80102e28:	7e 18                	jle    80102e42 <write_head+0x42>
80102e2a:	31 c0                	xor    %eax,%eax
80102e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102e30:	8b 14 85 ec 26 11 80 	mov    -0x7feed914(,%eax,4),%edx
80102e37:	89 54 83 60          	mov    %edx,0x60(%ebx,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80102e3b:	83 c0 01             	add    $0x1,%eax
80102e3e:	39 c1                	cmp    %eax,%ecx
80102e40:	75 ee                	jne    80102e30 <write_head+0x30>
  }
  bwrite(buf);
80102e42:	83 ec 0c             	sub    $0xc,%esp
80102e45:	53                   	push   %ebx
80102e46:	e8 65 d3 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102e4b:	89 1c 24             	mov    %ebx,(%esp)
80102e4e:	e8 9d d3 ff ff       	call   801001f0 <brelse>
}
80102e53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e56:	83 c4 10             	add    $0x10,%esp
80102e59:	c9                   	leave  
80102e5a:	c3                   	ret    
80102e5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e5f:	90                   	nop

80102e60 <initlog>:
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 2c             	sub    $0x2c,%esp
80102e67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e6a:	68 fc 7a 10 80       	push   $0x80107afc
80102e6f:	68 a0 26 11 80       	push   $0x801126a0
80102e74:	e8 a7 19 00 00       	call   80104820 <initlock>
  readsb(dev, &sb);
80102e79:	58                   	pop    %eax
80102e7a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e7d:	5a                   	pop    %edx
80102e7e:	50                   	push   %eax
80102e7f:	53                   	push   %ebx
80102e80:	e8 bb e7 ff ff       	call   80101640 <readsb>
  log.start = sb.logstart;
80102e85:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102e88:	59                   	pop    %ecx
  log.dev = dev;
80102e89:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102e8f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102e92:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102e97:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102e9d:	5a                   	pop    %edx
80102e9e:	50                   	push   %eax
80102e9f:	53                   	push   %ebx
80102ea0:	e8 2b d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102ea5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102ea8:	8b 58 5c             	mov    0x5c(%eax),%ebx
  struct buf *buf = bread(log.dev, log.start);
80102eab:	89 c1                	mov    %eax,%ecx
  log.lh.n = lh->n;
80102ead:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102eb3:	85 db                	test   %ebx,%ebx
80102eb5:	7e 1b                	jle    80102ed2 <initlog+0x72>
80102eb7:	31 c0                	xor    %eax,%eax
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102ec0:	8b 54 81 60          	mov    0x60(%ecx,%eax,4),%edx
80102ec4:	89 14 85 ec 26 11 80 	mov    %edx,-0x7feed914(,%eax,4)
  for (i = 0; i < log.lh.n; i++) {
80102ecb:	83 c0 01             	add    $0x1,%eax
80102ece:	39 c3                	cmp    %eax,%ebx
80102ed0:	75 ee                	jne    80102ec0 <initlog+0x60>
  brelse(buf);
80102ed2:	83 ec 0c             	sub    $0xc,%esp
80102ed5:	51                   	push   %ecx
80102ed6:	e8 15 d3 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102edb:	e8 80 fe ff ff       	call   80102d60 <install_trans>
  log.lh.n = 0;
80102ee0:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102ee7:	00 00 00 
  write_head(); // clear the log
80102eea:	e8 11 ff ff ff       	call   80102e00 <write_head>
}
80102eef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ef2:	83 c4 10             	add    $0x10,%esp
80102ef5:	c9                   	leave  
80102ef6:	c3                   	ret    
80102ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102efe:	66 90                	xchg   %ax,%ax

80102f00 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f06:	68 a0 26 11 80       	push   $0x801126a0
80102f0b:	e8 30 19 00 00       	call   80104840 <acquire>
80102f10:	83 c4 10             	add    $0x10,%esp
80102f13:	eb 18                	jmp    80102f2d <begin_op+0x2d>
80102f15:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f18:	83 ec 08             	sub    $0x8,%esp
80102f1b:	68 a0 26 11 80       	push   $0x801126a0
80102f20:	68 a0 26 11 80       	push   $0x801126a0
80102f25:	e8 b6 12 00 00       	call   801041e0 <sleep>
80102f2a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102f2d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102f32:	85 c0                	test   %eax,%eax
80102f34:	75 e2                	jne    80102f18 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102f36:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f3b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f41:	83 c0 01             	add    $0x1,%eax
80102f44:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f47:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f4a:	83 fa 1e             	cmp    $0x1e,%edx
80102f4d:	7f c9                	jg     80102f18 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f4f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f52:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102f57:	68 a0 26 11 80       	push   $0x801126a0
80102f5c:	e8 bf 1a 00 00       	call   80104a20 <release>
      break;
    }
  }
}
80102f61:	83 c4 10             	add    $0x10,%esp
80102f64:	c9                   	leave  
80102f65:	c3                   	ret    
80102f66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f6d:	8d 76 00             	lea    0x0(%esi),%esi

80102f70 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f70:	55                   	push   %ebp
80102f71:	89 e5                	mov    %esp,%ebp
80102f73:	57                   	push   %edi
80102f74:	56                   	push   %esi
80102f75:	53                   	push   %ebx
80102f76:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f79:	68 a0 26 11 80       	push   $0x801126a0
80102f7e:	e8 bd 18 00 00       	call   80104840 <acquire>
  log.outstanding -= 1;
80102f83:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102f88:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102f8e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102f91:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102f94:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102f9a:	85 f6                	test   %esi,%esi
80102f9c:	0f 85 22 01 00 00    	jne    801030c4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102fa2:	85 db                	test   %ebx,%ebx
80102fa4:	0f 85 f6 00 00 00    	jne    801030a0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102faa:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102fb1:	00 00 00 
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102fb4:	83 ec 0c             	sub    $0xc,%esp
80102fb7:	68 a0 26 11 80       	push   $0x801126a0
80102fbc:	e8 5f 1a 00 00       	call   80104a20 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102fc1:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102fc7:	83 c4 10             	add    $0x10,%esp
80102fca:	85 c9                	test   %ecx,%ecx
80102fcc:	7f 42                	jg     80103010 <end_op+0xa0>
    acquire(&log.lock);
80102fce:	83 ec 0c             	sub    $0xc,%esp
80102fd1:	68 a0 26 11 80       	push   $0x801126a0
80102fd6:	e8 65 18 00 00       	call   80104840 <acquire>
    wakeup(&log);
80102fdb:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102fe2:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102fe9:	00 00 00 
    wakeup(&log);
80102fec:	e8 af 12 00 00       	call   801042a0 <wakeup>
    release(&log.lock);
80102ff1:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ff8:	e8 23 1a 00 00       	call   80104a20 <release>
80102ffd:	83 c4 10             	add    $0x10,%esp
}
80103000:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103003:	5b                   	pop    %ebx
80103004:	5e                   	pop    %esi
80103005:	5f                   	pop    %edi
80103006:	5d                   	pop    %ebp
80103007:	c3                   	ret    
80103008:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010300f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103010:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80103015:	83 ec 08             	sub    $0x8,%esp
80103018:	01 d8                	add    %ebx,%eax
8010301a:	83 c0 01             	add    $0x1,%eax
8010301d:	50                   	push   %eax
8010301e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80103024:	e8 a7 d0 ff ff       	call   801000d0 <bread>
80103029:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010302b:	58                   	pop    %eax
8010302c:	5a                   	pop    %edx
8010302d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80103034:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010303a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010303d:	e8 8e d0 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103042:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103045:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103047:	8d 40 5c             	lea    0x5c(%eax),%eax
8010304a:	68 00 02 00 00       	push   $0x200
8010304f:	50                   	push   %eax
80103050:	8d 46 5c             	lea    0x5c(%esi),%eax
80103053:	50                   	push   %eax
80103054:	e8 b7 1a 00 00       	call   80104b10 <memmove>
    bwrite(to);  // write the log
80103059:	89 34 24             	mov    %esi,(%esp)
8010305c:	e8 4f d1 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103061:	89 3c 24             	mov    %edi,(%esp)
80103064:	e8 87 d1 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103069:	89 34 24             	mov    %esi,(%esp)
8010306c:	e8 7f d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103071:	83 c4 10             	add    $0x10,%esp
80103074:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
8010307a:	7c 94                	jl     80103010 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010307c:	e8 7f fd ff ff       	call   80102e00 <write_head>
    install_trans(); // Now install writes to home locations
80103081:	e8 da fc ff ff       	call   80102d60 <install_trans>
    log.lh.n = 0;
80103086:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
8010308d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103090:	e8 6b fd ff ff       	call   80102e00 <write_head>
80103095:	e9 34 ff ff ff       	jmp    80102fce <end_op+0x5e>
8010309a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801030a0:	83 ec 0c             	sub    $0xc,%esp
801030a3:	68 a0 26 11 80       	push   $0x801126a0
801030a8:	e8 f3 11 00 00       	call   801042a0 <wakeup>
  release(&log.lock);
801030ad:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
801030b4:	e8 67 19 00 00       	call   80104a20 <release>
801030b9:	83 c4 10             	add    $0x10,%esp
}
801030bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030bf:	5b                   	pop    %ebx
801030c0:	5e                   	pop    %esi
801030c1:	5f                   	pop    %edi
801030c2:	5d                   	pop    %ebp
801030c3:	c3                   	ret    
    panic("log.committing");
801030c4:	83 ec 0c             	sub    $0xc,%esp
801030c7:	68 00 7b 10 80       	push   $0x80107b00
801030cc:	e8 af d2 ff ff       	call   80100380 <panic>
801030d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030df:	90                   	nop

801030e0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
801030e3:	53                   	push   %ebx
801030e4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030e7:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
801030ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801030f0:	83 fa 1d             	cmp    $0x1d,%edx
801030f3:	0f 8f 85 00 00 00    	jg     8010317e <log_write+0x9e>
801030f9:	a1 d8 26 11 80       	mov    0x801126d8,%eax
801030fe:	83 e8 01             	sub    $0x1,%eax
80103101:	39 c2                	cmp    %eax,%edx
80103103:	7d 79                	jge    8010317e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103105:	a1 dc 26 11 80       	mov    0x801126dc,%eax
8010310a:	85 c0                	test   %eax,%eax
8010310c:	7e 7d                	jle    8010318b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010310e:	83 ec 0c             	sub    $0xc,%esp
80103111:	68 a0 26 11 80       	push   $0x801126a0
80103116:	e8 25 17 00 00       	call   80104840 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010311b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103121:	83 c4 10             	add    $0x10,%esp
80103124:	85 d2                	test   %edx,%edx
80103126:	7e 4a                	jle    80103172 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103128:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010312b:	31 c0                	xor    %eax,%eax
8010312d:	eb 08                	jmp    80103137 <log_write+0x57>
8010312f:	90                   	nop
80103130:	83 c0 01             	add    $0x1,%eax
80103133:	39 c2                	cmp    %eax,%edx
80103135:	74 29                	je     80103160 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103137:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
8010313e:	75 f0                	jne    80103130 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103140:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103147:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010314a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010314d:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103154:	c9                   	leave  
  release(&log.lock);
80103155:	e9 c6 18 00 00       	jmp    80104a20 <release>
8010315a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103160:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80103167:	83 c2 01             	add    $0x1,%edx
8010316a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80103170:	eb d5                	jmp    80103147 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103172:	8b 43 08             	mov    0x8(%ebx),%eax
80103175:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
8010317a:	75 cb                	jne    80103147 <log_write+0x67>
8010317c:	eb e9                	jmp    80103167 <log_write+0x87>
    panic("too big a transaction");
8010317e:	83 ec 0c             	sub    $0xc,%esp
80103181:	68 0f 7b 10 80       	push   $0x80107b0f
80103186:	e8 f5 d1 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010318b:	83 ec 0c             	sub    $0xc,%esp
8010318e:	68 25 7b 10 80       	push   $0x80107b25
80103193:	e8 e8 d1 ff ff       	call   80100380 <panic>
80103198:	66 90                	xchg   %ax,%ax
8010319a:	66 90                	xchg   %ax,%ax
8010319c:	66 90                	xchg   %ax,%ax
8010319e:	66 90                	xchg   %ax,%ax

801031a0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
801031a6:	e8 75 f8 ff ff       	call   80102a20 <cpunum>
801031ab:	83 ec 08             	sub    $0x8,%esp
801031ae:	50                   	push   %eax
801031af:	68 40 7b 10 80       	push   $0x80107b40
801031b4:	e8 c7 d4 ff ff       	call   80100680 <cprintf>
  idtinit();       // load idt register
801031b9:	e8 42 2c 00 00       	call   80105e00 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801031be:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031c5:	b8 01 00 00 00       	mov    $0x1,%eax
801031ca:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
801031d1:	e8 4a 0c 00 00       	call   80103e20 <scheduler>
801031d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031dd:	8d 76 00             	lea    0x0(%esi),%esi

801031e0 <mpenter>:
{
801031e0:	55                   	push   %ebp
801031e1:	89 e5                	mov    %esp,%ebp
801031e3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801031e6:	e8 a5 3d 00 00       	call   80106f90 <switchkvm>
  seginit();
801031eb:	e8 30 3c 00 00       	call   80106e20 <seginit>
  lapicinit();
801031f0:	e8 2b f7 ff ff       	call   80102920 <lapicinit>
  mpmain();
801031f5:	e8 a6 ff ff ff       	call   801031a0 <mpmain>
801031fa:	66 90                	xchg   %ax,%ax
801031fc:	66 90                	xchg   %ax,%ax
801031fe:	66 90                	xchg   %ax,%ax

80103200 <main>:
{
80103200:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103204:	83 e4 f0             	and    $0xfffffff0,%esp
80103207:	ff 71 fc             	pushl  -0x4(%ecx)
8010320a:	55                   	push   %ebp
8010320b:	89 e5                	mov    %esp,%ebp
8010320d:	53                   	push   %ebx
8010320e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010320f:	83 ec 08             	sub    $0x8,%esp
80103212:	68 00 00 40 80       	push   $0x80400000
80103217:	68 d0 62 11 80       	push   $0x801162d0
8010321c:	e8 1f f5 ff ff       	call   80102740 <kinit1>
  kvmalloc();      // kernel page table
80103221:	e8 4a 3d 00 00       	call   80106f70 <kvmalloc>
  mpinit();        // detect other processors
80103226:	e8 b5 01 00 00       	call   801033e0 <mpinit>
  lapicinit();     // interrupt controller
8010322b:	e8 f0 f6 ff ff       	call   80102920 <lapicinit>
  seginit();       // segment descriptors
80103230:	e8 eb 3b 00 00       	call   80106e20 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80103235:	e8 e6 f7 ff ff       	call   80102a20 <cpunum>
8010323a:	5a                   	pop    %edx
8010323b:	59                   	pop    %ecx
8010323c:	50                   	push   %eax
8010323d:	68 51 7b 10 80       	push   $0x80107b51
80103242:	e8 39 d4 ff ff       	call   80100680 <cprintf>
  picinit();       // another interrupt controller
80103247:	e8 d4 03 00 00       	call   80103620 <picinit>
  ioapicinit();    // another interrupt controller
8010324c:	e8 8f f2 ff ff       	call   801024e0 <ioapicinit>
  consoleinit();   // console hardware
80103251:	e8 2a d9 ff ff       	call   80100b80 <consoleinit>
  uartinit();      // serial port
80103256:	e8 35 2e 00 00       	call   80106090 <uartinit>
  pinit();         // process table
8010325b:	e8 20 09 00 00       	call   80103b80 <pinit>
  tvinit();        // trap vectors
80103260:	e8 1b 2b 00 00       	call   80105d80 <tvinit>
  binit();         // buffer cache
80103265:	e8 d6 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010326a:	e8 b1 dc ff ff       	call   80100f20 <fileinit>
  ideinit();       // disk
8010326f:	e8 4c f0 ff ff       	call   801022c0 <ideinit>
  if(!ismp)
80103274:	8b 1d 88 27 11 80    	mov    0x80112788,%ebx
8010327a:	83 c4 10             	add    $0x10,%esp
8010327d:	85 db                	test   %ebx,%ebx
8010327f:	0f 84 cf 00 00 00    	je     80103354 <main+0x154>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103285:	83 ec 04             	sub    $0x4,%esp
80103288:	68 8a 00 00 00       	push   $0x8a
8010328d:	68 8c b4 10 80       	push   $0x8010b48c
80103292:	68 00 70 00 80       	push   $0x80007000
80103297:	e8 74 18 00 00       	call   80104b10 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010329c:	83 c4 10             	add    $0x10,%esp
8010329f:	69 05 84 27 11 80 bc 	imul   $0xbc,0x80112784,%eax
801032a6:	00 00 00 
801032a9:	05 a0 27 11 80       	add    $0x801127a0,%eax
801032ae:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801032b3:	0f 86 7f 00 00 00    	jbe    80103338 <main+0x138>
801032b9:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801032be:	eb 19                	jmp    801032d9 <main+0xd9>
801032c0:	69 05 84 27 11 80 bc 	imul   $0xbc,0x80112784,%eax
801032c7:	00 00 00 
801032ca:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
801032d0:	05 a0 27 11 80       	add    $0x801127a0,%eax
801032d5:	39 c3                	cmp    %eax,%ebx
801032d7:	73 5f                	jae    80103338 <main+0x138>
    if(c == cpus+cpunum())  // We've started already.
801032d9:	e8 42 f7 ff ff       	call   80102a20 <cpunum>
801032de:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801032e4:	05 a0 27 11 80       	add    $0x801127a0,%eax
801032e9:	39 c3                	cmp    %eax,%ebx
801032eb:	74 d3                	je     801032c0 <main+0xc0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801032ed:	e8 be f4 ff ff       	call   801027b0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801032f2:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
801032f5:	c7 05 f8 6f 00 80 e0 	movl   $0x801031e0,0x80006ff8
801032fc:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801032ff:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103306:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103309:	05 00 10 00 00       	add    $0x1000,%eax
8010330e:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103313:	68 00 70 00 00       	push   $0x7000
80103318:	0f b6 03             	movzbl (%ebx),%eax
8010331b:	50                   	push   %eax
8010331c:	e8 bf f7 ff ff       	call   80102ae0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103321:	83 c4 10             	add    $0x10,%esp
80103324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103328:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
8010332e:	85 c0                	test   %eax,%eax
80103330:	74 f6                	je     80103328 <main+0x128>
80103332:	eb 8c                	jmp    801032c0 <main+0xc0>
80103334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103338:	83 ec 08             	sub    $0x8,%esp
8010333b:	68 00 00 00 8e       	push   $0x8e000000
80103340:	68 00 00 40 80       	push   $0x80400000
80103345:	e8 96 f3 ff ff       	call   801026e0 <kinit2>
  userinit();      // first user process
8010334a:	e8 51 08 00 00       	call   80103ba0 <userinit>
  mpmain();        // finish this processor's setup
8010334f:	e8 4c fe ff ff       	call   801031a0 <mpmain>
    timerinit();   // uniprocessor timer
80103354:	e8 c7 29 00 00       	call   80105d20 <timerinit>
80103359:	e9 27 ff ff ff       	jmp    80103285 <main+0x85>
8010335e:	66 90                	xchg   %ax,%ax

80103360 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	57                   	push   %edi
80103364:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103365:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010336b:	53                   	push   %ebx
  e = addr+len;
8010336c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010336f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103372:	39 de                	cmp    %ebx,%esi
80103374:	72 10                	jb     80103386 <mpsearch1+0x26>
80103376:	eb 50                	jmp    801033c8 <mpsearch1+0x68>
80103378:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010337f:	90                   	nop
80103380:	89 fe                	mov    %edi,%esi
80103382:	39 fb                	cmp    %edi,%ebx
80103384:	76 42                	jbe    801033c8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103386:	83 ec 04             	sub    $0x4,%esp
80103389:	8d 7e 10             	lea    0x10(%esi),%edi
8010338c:	6a 04                	push   $0x4
8010338e:	68 68 7b 10 80       	push   $0x80107b68
80103393:	56                   	push   %esi
80103394:	e8 27 17 00 00       	call   80104ac0 <memcmp>
80103399:	83 c4 10             	add    $0x10,%esp
8010339c:	89 c2                	mov    %eax,%edx
8010339e:	85 c0                	test   %eax,%eax
801033a0:	75 de                	jne    80103380 <mpsearch1+0x20>
801033a2:	89 f0                	mov    %esi,%eax
801033a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801033a8:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
801033ab:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801033ae:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801033b0:	39 f8                	cmp    %edi,%eax
801033b2:	75 f4                	jne    801033a8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033b4:	84 d2                	test   %dl,%dl
801033b6:	75 c8                	jne    80103380 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801033b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033bb:	89 f0                	mov    %esi,%eax
801033bd:	5b                   	pop    %ebx
801033be:	5e                   	pop    %esi
801033bf:	5f                   	pop    %edi
801033c0:	5d                   	pop    %ebp
801033c1:	c3                   	ret    
801033c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801033cb:	31 f6                	xor    %esi,%esi
}
801033cd:	5b                   	pop    %ebx
801033ce:	89 f0                	mov    %esi,%eax
801033d0:	5e                   	pop    %esi
801033d1:	5f                   	pop    %edi
801033d2:	5d                   	pop    %ebp
801033d3:	c3                   	ret    
801033d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801033df:	90                   	nop

801033e0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801033e9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801033f0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801033f7:	c1 e0 08             	shl    $0x8,%eax
801033fa:	09 d0                	or     %edx,%eax
801033fc:	c1 e0 04             	shl    $0x4,%eax
801033ff:	75 1b                	jne    8010341c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103401:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103408:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010340f:	c1 e0 08             	shl    $0x8,%eax
80103412:	09 d0                	or     %edx,%eax
80103414:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103417:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010341c:	ba 00 04 00 00       	mov    $0x400,%edx
80103421:	e8 3a ff ff ff       	call   80103360 <mpsearch1>
80103426:	89 c3                	mov    %eax,%ebx
80103428:	85 c0                	test   %eax,%eax
8010342a:	0f 84 68 01 00 00    	je     80103598 <mpinit+0x1b8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103430:	8b 73 04             	mov    0x4(%ebx),%esi
80103433:	85 f6                	test   %esi,%esi
80103435:	0f 84 f8 00 00 00    	je     80103533 <mpinit+0x153>
  if(memcmp(conf, "PCMP", 4) != 0)
8010343b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010343e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103444:	6a 04                	push   $0x4
80103446:	68 6d 7b 10 80       	push   $0x80107b6d
8010344b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010344c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010344f:	e8 6c 16 00 00       	call   80104ac0 <memcmp>
80103454:	83 c4 10             	add    $0x10,%esp
80103457:	89 c2                	mov    %eax,%edx
80103459:	85 c0                	test   %eax,%eax
8010345b:	0f 85 d2 00 00 00    	jne    80103533 <mpinit+0x153>
  if(conf->version != 1 && conf->version != 4)
80103461:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103468:	3c 01                	cmp    $0x1,%al
8010346a:	74 08                	je     80103474 <mpinit+0x94>
8010346c:	3c 04                	cmp    $0x4,%al
8010346e:	0f 85 bf 00 00 00    	jne    80103533 <mpinit+0x153>
  if(sum((uchar*)conf, conf->length) != 0)
80103474:	0f b7 be 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edi
  for(i=0; i<len; i++)
8010347b:	66 85 ff             	test   %di,%di
8010347e:	74 20                	je     801034a0 <mpinit+0xc0>
80103480:	89 f0                	mov    %esi,%eax
80103482:	01 f7                	add    %esi,%edi
80103484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103488:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010348f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103492:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103494:	39 c7                	cmp    %eax,%edi
80103496:	75 f0                	jne    80103488 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103498:	84 d2                	test   %dl,%dl
8010349a:	0f 85 93 00 00 00    	jne    80103533 <mpinit+0x153>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
801034a0:	c7 05 88 27 11 80 01 	movl   $0x1,0x80112788
801034a7:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801034aa:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034b0:	8d 96 2c 00 00 80    	lea    -0x7fffffd4(%esi),%edx
  lapic = (uint*)conf->lapicaddr;
801034b6:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034bb:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
801034c2:	03 4d e4             	add    -0x1c(%ebp),%ecx
801034c5:	39 ca                	cmp    %ecx,%edx
801034c7:	72 0e                	jb     801034d7 <mpinit+0xf7>
801034c9:	eb 4d                	jmp    80103518 <mpinit+0x138>
801034cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034cf:	90                   	nop
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801034d0:	83 c2 08             	add    $0x8,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034d3:	39 ca                	cmp    %ecx,%edx
801034d5:	73 38                	jae    8010350f <mpinit+0x12f>
    switch(*p){
801034d7:	0f b6 02             	movzbl (%edx),%eax
801034da:	3c 02                	cmp    $0x2,%al
801034dc:	74 7a                	je     80103558 <mpinit+0x178>
801034de:	77 60                	ja     80103540 <mpinit+0x160>
801034e0:	84 c0                	test   %al,%al
801034e2:	75 ec                	jne    801034d0 <mpinit+0xf0>
      if(ncpu < NCPU) {
801034e4:	8b 35 84 27 11 80    	mov    0x80112784,%esi
801034ea:	83 fe 01             	cmp    $0x1,%esi
801034ed:	7f 19                	jg     80103508 <mpinit+0x128>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801034ef:	69 fe bc 00 00 00    	imul   $0xbc,%esi,%edi
801034f5:	0f b6 42 01          	movzbl 0x1(%edx),%eax
        ncpu++;
801034f9:	83 c6 01             	add    $0x1,%esi
801034fc:	89 35 84 27 11 80    	mov    %esi,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103502:	88 87 a0 27 11 80    	mov    %al,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103508:	83 c2 14             	add    $0x14,%edx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010350b:	39 ca                	cmp    %ecx,%edx
8010350d:	72 c8                	jb     801034d7 <mpinit+0xf7>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010350f:	a1 88 27 11 80       	mov    0x80112788,%eax
80103514:	85 c0                	test   %eax,%eax
80103516:	74 58                	je     80103570 <mpinit+0x190>
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
80103518:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010351c:	74 15                	je     80103533 <mpinit+0x153>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010351e:	b8 70 00 00 00       	mov    $0x70,%eax
80103523:	ba 22 00 00 00       	mov    $0x22,%edx
80103528:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103529:	ba 23 00 00 00       	mov    $0x23,%edx
8010352e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010352f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103532:	ee                   	out    %al,(%dx)
  }
}
80103533:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103536:	5b                   	pop    %ebx
80103537:	5e                   	pop    %esi
80103538:	5f                   	pop    %edi
80103539:	5d                   	pop    %ebp
8010353a:	c3                   	ret    
8010353b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010353f:	90                   	nop
    switch(*p){
80103540:	83 e8 03             	sub    $0x3,%eax
80103543:	3c 01                	cmp    $0x1,%al
80103545:	76 89                	jbe    801034d0 <mpinit+0xf0>
      ismp = 0;
80103547:	c7 05 88 27 11 80 00 	movl   $0x0,0x80112788
8010354e:	00 00 00 
      break;
80103551:	eb 80                	jmp    801034d3 <mpinit+0xf3>
80103553:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103557:	90                   	nop
      ioapicid = ioapic->apicno;
80103558:	0f b6 42 01          	movzbl 0x1(%edx),%eax
      p += sizeof(struct mpioapic);
8010355c:	83 c2 08             	add    $0x8,%edx
      ioapicid = ioapic->apicno;
8010355f:	a2 80 27 11 80       	mov    %al,0x80112780
      continue;
80103564:	e9 6a ff ff ff       	jmp    801034d3 <mpinit+0xf3>
80103569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ncpu = 1;
80103570:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
80103577:	00 00 00 
    lapic = 0;
8010357a:	c7 05 80 26 11 80 00 	movl   $0x0,0x80112680
80103581:	00 00 00 
    ioapicid = 0;
80103584:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
}
8010358b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010358e:	5b                   	pop    %ebx
8010358f:	5e                   	pop    %esi
80103590:	5f                   	pop    %edi
80103591:	5d                   	pop    %ebp
80103592:	c3                   	ret    
80103593:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103597:	90                   	nop
{
80103598:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010359d:	eb 0b                	jmp    801035aa <mpinit+0x1ca>
8010359f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
801035a0:	89 f3                	mov    %esi,%ebx
801035a2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801035a8:	74 89                	je     80103533 <mpinit+0x153>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035aa:	83 ec 04             	sub    $0x4,%esp
801035ad:	8d 73 10             	lea    0x10(%ebx),%esi
801035b0:	6a 04                	push   $0x4
801035b2:	68 68 7b 10 80       	push   $0x80107b68
801035b7:	53                   	push   %ebx
801035b8:	e8 03 15 00 00       	call   80104ac0 <memcmp>
801035bd:	83 c4 10             	add    $0x10,%esp
801035c0:	89 c2                	mov    %eax,%edx
801035c2:	85 c0                	test   %eax,%eax
801035c4:	75 da                	jne    801035a0 <mpinit+0x1c0>
801035c6:	89 d8                	mov    %ebx,%eax
801035c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035cf:	90                   	nop
    sum += addr[i];
801035d0:	0f b6 08             	movzbl (%eax),%ecx
  for(i=0; i<len; i++)
801035d3:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801035d6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801035d8:	39 f0                	cmp    %esi,%eax
801035da:	75 f4                	jne    801035d0 <mpinit+0x1f0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035dc:	84 d2                	test   %dl,%dl
801035de:	75 c0                	jne    801035a0 <mpinit+0x1c0>
801035e0:	e9 4b fe ff ff       	jmp    80103430 <mpinit+0x50>
801035e5:	66 90                	xchg   %ax,%ax
801035e7:	66 90                	xchg   %ax,%ax
801035e9:	66 90                	xchg   %ax,%ax
801035eb:	66 90                	xchg   %ax,%ax
801035ed:	66 90                	xchg   %ax,%ax
801035ef:	90                   	nop

801035f0 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801035f0:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
801035f1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
801035f6:	ba 21 00 00 00       	mov    $0x21,%edx
{
801035fb:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
801035fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103600:	d3 c0                	rol    %cl,%eax
80103602:	66 23 05 00 b0 10 80 	and    0x8010b000,%ax
  irqmask = mask;
80103609:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
8010360f:	ee                   	out    %al,(%dx)
80103610:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
80103615:	66 c1 e8 08          	shr    $0x8,%ax
80103619:	ee                   	out    %al,(%dx)
}
8010361a:	5d                   	pop    %ebp
8010361b:	c3                   	ret    
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103620 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103620:	55                   	push   %ebp
80103621:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103626:	89 e5                	mov    %esp,%ebp
80103628:	57                   	push   %edi
80103629:	56                   	push   %esi
8010362a:	53                   	push   %ebx
8010362b:	bb 21 00 00 00       	mov    $0x21,%ebx
80103630:	89 da                	mov    %ebx,%edx
80103632:	ee                   	out    %al,(%dx)
80103633:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103638:	89 ca                	mov    %ecx,%edx
8010363a:	ee                   	out    %al,(%dx)
8010363b:	be 11 00 00 00       	mov    $0x11,%esi
80103640:	ba 20 00 00 00       	mov    $0x20,%edx
80103645:	89 f0                	mov    %esi,%eax
80103647:	ee                   	out    %al,(%dx)
80103648:	b8 20 00 00 00       	mov    $0x20,%eax
8010364d:	89 da                	mov    %ebx,%edx
8010364f:	ee                   	out    %al,(%dx)
80103650:	b8 04 00 00 00       	mov    $0x4,%eax
80103655:	ee                   	out    %al,(%dx)
80103656:	bf 03 00 00 00       	mov    $0x3,%edi
8010365b:	89 f8                	mov    %edi,%eax
8010365d:	ee                   	out    %al,(%dx)
8010365e:	ba a0 00 00 00       	mov    $0xa0,%edx
80103663:	89 f0                	mov    %esi,%eax
80103665:	ee                   	out    %al,(%dx)
80103666:	b8 28 00 00 00       	mov    $0x28,%eax
8010366b:	89 ca                	mov    %ecx,%edx
8010366d:	ee                   	out    %al,(%dx)
8010366e:	b8 02 00 00 00       	mov    $0x2,%eax
80103673:	ee                   	out    %al,(%dx)
80103674:	89 f8                	mov    %edi,%eax
80103676:	ee                   	out    %al,(%dx)
80103677:	bf 68 00 00 00       	mov    $0x68,%edi
8010367c:	ba 20 00 00 00       	mov    $0x20,%edx
80103681:	89 f8                	mov    %edi,%eax
80103683:	ee                   	out    %al,(%dx)
80103684:	be 0a 00 00 00       	mov    $0xa,%esi
80103689:	89 f0                	mov    %esi,%eax
8010368b:	ee                   	out    %al,(%dx)
8010368c:	ba a0 00 00 00       	mov    $0xa0,%edx
80103691:	89 f8                	mov    %edi,%eax
80103693:	ee                   	out    %al,(%dx)
80103694:	89 f0                	mov    %esi,%eax
80103696:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
80103697:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
8010369e:	66 83 f8 ff          	cmp    $0xffff,%ax
801036a2:	74 0a                	je     801036ae <picinit+0x8e>
801036a4:	89 da                	mov    %ebx,%edx
801036a6:	ee                   	out    %al,(%dx)
  outb(IO_PIC2+1, mask >> 8);
801036a7:	66 c1 e8 08          	shr    $0x8,%ax
801036ab:	89 ca                	mov    %ecx,%edx
801036ad:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
801036ae:	5b                   	pop    %ebx
801036af:	5e                   	pop    %esi
801036b0:	5f                   	pop    %edi
801036b1:	5d                   	pop    %ebp
801036b2:	c3                   	ret    
801036b3:	66 90                	xchg   %ax,%ax
801036b5:	66 90                	xchg   %ax,%ax
801036b7:	66 90                	xchg   %ax,%ax
801036b9:	66 90                	xchg   %ax,%ax
801036bb:	66 90                	xchg   %ax,%ax
801036bd:	66 90                	xchg   %ax,%ax
801036bf:	90                   	nop

801036c0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	57                   	push   %edi
801036c4:	56                   	push   %esi
801036c5:	53                   	push   %ebx
801036c6:	83 ec 0c             	sub    $0xc,%esp
801036c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801036cf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801036d5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801036db:	e8 60 d8 ff ff       	call   80100f40 <filealloc>
801036e0:	89 03                	mov    %eax,(%ebx)
801036e2:	85 c0                	test   %eax,%eax
801036e4:	0f 84 a8 00 00 00    	je     80103792 <pipealloc+0xd2>
801036ea:	e8 51 d8 ff ff       	call   80100f40 <filealloc>
801036ef:	89 06                	mov    %eax,(%esi)
801036f1:	85 c0                	test   %eax,%eax
801036f3:	0f 84 87 00 00 00    	je     80103780 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801036f9:	e8 b2 f0 ff ff       	call   801027b0 <kalloc>
801036fe:	89 c7                	mov    %eax,%edi
80103700:	85 c0                	test   %eax,%eax
80103702:	0f 84 b0 00 00 00    	je     801037b8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103708:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010370f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103712:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103715:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010371c:	00 00 00 
  p->nwrite = 0;
8010371f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103726:	00 00 00 
  p->nread = 0;
80103729:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103730:	00 00 00 
  initlock(&p->lock, "pipe");
80103733:	68 72 7b 10 80       	push   $0x80107b72
80103738:	50                   	push   %eax
80103739:	e8 e2 10 00 00       	call   80104820 <initlock>
  (*f0)->type = FD_PIPE;
8010373e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103740:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103743:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103749:	8b 03                	mov    (%ebx),%eax
8010374b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010374f:	8b 03                	mov    (%ebx),%eax
80103751:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103755:	8b 03                	mov    (%ebx),%eax
80103757:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010375a:	8b 06                	mov    (%esi),%eax
8010375c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103762:	8b 06                	mov    (%esi),%eax
80103764:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103768:	8b 06                	mov    (%esi),%eax
8010376a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010376e:	8b 06                	mov    (%esi),%eax
80103770:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103773:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103776:	31 c0                	xor    %eax,%eax
}
80103778:	5b                   	pop    %ebx
80103779:	5e                   	pop    %esi
8010377a:	5f                   	pop    %edi
8010377b:	5d                   	pop    %ebp
8010377c:	c3                   	ret    
8010377d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
80103780:	8b 03                	mov    (%ebx),%eax
80103782:	85 c0                	test   %eax,%eax
80103784:	74 1e                	je     801037a4 <pipealloc+0xe4>
    fileclose(*f0);
80103786:	83 ec 0c             	sub    $0xc,%esp
80103789:	50                   	push   %eax
8010378a:	e8 71 d8 ff ff       	call   80101000 <fileclose>
8010378f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103792:	8b 06                	mov    (%esi),%eax
80103794:	85 c0                	test   %eax,%eax
80103796:	74 0c                	je     801037a4 <pipealloc+0xe4>
    fileclose(*f1);
80103798:	83 ec 0c             	sub    $0xc,%esp
8010379b:	50                   	push   %eax
8010379c:	e8 5f d8 ff ff       	call   80101000 <fileclose>
801037a1:	83 c4 10             	add    $0x10,%esp
}
801037a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801037a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801037ac:	5b                   	pop    %ebx
801037ad:	5e                   	pop    %esi
801037ae:	5f                   	pop    %edi
801037af:	5d                   	pop    %ebp
801037b0:	c3                   	ret    
801037b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801037b8:	8b 03                	mov    (%ebx),%eax
801037ba:	85 c0                	test   %eax,%eax
801037bc:	75 c8                	jne    80103786 <pipealloc+0xc6>
801037be:	eb d2                	jmp    80103792 <pipealloc+0xd2>

801037c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	56                   	push   %esi
801037c4:	53                   	push   %ebx
801037c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801037cb:	83 ec 0c             	sub    $0xc,%esp
801037ce:	53                   	push   %ebx
801037cf:	e8 6c 10 00 00       	call   80104840 <acquire>
  if(writable){
801037d4:	83 c4 10             	add    $0x10,%esp
801037d7:	85 f6                	test   %esi,%esi
801037d9:	74 65                	je     80103840 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801037db:	83 ec 0c             	sub    $0xc,%esp
801037de:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801037e4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801037eb:	00 00 00 
    wakeup(&p->nread);
801037ee:	50                   	push   %eax
801037ef:	e8 ac 0a 00 00       	call   801042a0 <wakeup>
801037f4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801037f7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801037fd:	85 d2                	test   %edx,%edx
801037ff:	75 0a                	jne    8010380b <pipeclose+0x4b>
80103801:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103807:	85 c0                	test   %eax,%eax
80103809:	74 15                	je     80103820 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010380b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010380e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103811:	5b                   	pop    %ebx
80103812:	5e                   	pop    %esi
80103813:	5d                   	pop    %ebp
    release(&p->lock);
80103814:	e9 07 12 00 00       	jmp    80104a20 <release>
80103819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103820:	83 ec 0c             	sub    $0xc,%esp
80103823:	53                   	push   %ebx
80103824:	e8 f7 11 00 00       	call   80104a20 <release>
    kfree((char*)p);
80103829:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010382c:	83 c4 10             	add    $0x10,%esp
}
8010382f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103832:	5b                   	pop    %ebx
80103833:	5e                   	pop    %esi
80103834:	5d                   	pop    %ebp
    kfree((char*)p);
80103835:	e9 b6 ed ff ff       	jmp    801025f0 <kfree>
8010383a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103840:	83 ec 0c             	sub    $0xc,%esp
80103843:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103849:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103850:	00 00 00 
    wakeup(&p->nwrite);
80103853:	50                   	push   %eax
80103854:	e8 47 0a 00 00       	call   801042a0 <wakeup>
80103859:	83 c4 10             	add    $0x10,%esp
8010385c:	eb 99                	jmp    801037f7 <pipeclose+0x37>
8010385e:	66 90                	xchg   %ax,%ax

80103860 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	57                   	push   %edi
80103864:	56                   	push   %esi
80103865:	53                   	push   %ebx
80103866:	83 ec 28             	sub    $0x28,%esp
80103869:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010386c:	57                   	push   %edi
8010386d:	e8 ce 0f 00 00       	call   80104840 <acquire>
  for(i = 0; i < n; i++){
80103872:	8b 45 10             	mov    0x10(%ebp),%eax
80103875:	83 c4 10             	add    $0x10,%esp
80103878:	85 c0                	test   %eax,%eax
8010387a:	0f 8e b8 00 00 00    	jle    80103938 <pipewrite+0xd8>
80103880:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103883:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103889:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
8010388f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103892:	03 45 10             	add    0x10(%ebp),%eax
80103895:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103898:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010389e:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801038a4:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801038aa:	39 d1                	cmp    %edx,%ecx
801038ac:	74 39                	je     801038e7 <pipewrite+0x87>
801038ae:	eb 5a                	jmp    8010390a <pipewrite+0xaa>
      if(p->readopen == 0 || proc->killed){
801038b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801038b6:	8b 48 24             	mov    0x24(%eax),%ecx
801038b9:	85 c9                	test   %ecx,%ecx
801038bb:	75 34                	jne    801038f1 <pipewrite+0x91>
      wakeup(&p->nread);
801038bd:	83 ec 0c             	sub    $0xc,%esp
801038c0:	56                   	push   %esi
801038c1:	e8 da 09 00 00       	call   801042a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801038c6:	58                   	pop    %eax
801038c7:	5a                   	pop    %edx
801038c8:	57                   	push   %edi
801038c9:	53                   	push   %ebx
801038ca:	e8 11 09 00 00       	call   801041e0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801038cf:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801038d5:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
801038db:	83 c4 10             	add    $0x10,%esp
801038de:	05 00 02 00 00       	add    $0x200,%eax
801038e3:	39 c2                	cmp    %eax,%edx
801038e5:	75 29                	jne    80103910 <pipewrite+0xb0>
      if(p->readopen == 0 || proc->killed){
801038e7:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
801038ed:	85 c0                	test   %eax,%eax
801038ef:	75 bf                	jne    801038b0 <pipewrite+0x50>
        release(&p->lock);
801038f1:	83 ec 0c             	sub    $0xc,%esp
801038f4:	57                   	push   %edi
801038f5:	e8 26 11 00 00       	call   80104a20 <release>
        return -1;
801038fa:	83 c4 10             	add    $0x10,%esp
801038fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103902:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103905:	5b                   	pop    %ebx
80103906:	5e                   	pop    %esi
80103907:	5f                   	pop    %edi
80103908:	5d                   	pop    %ebp
80103909:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010390a:	89 ca                	mov    %ecx,%edx
8010390c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103910:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103913:	8d 4a 01             	lea    0x1(%edx),%ecx
80103916:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010391c:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103922:	0f b6 18             	movzbl (%eax),%ebx
  for(i = 0; i < n; i++){
80103925:	83 c0 01             	add    $0x1,%eax
80103928:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010392b:	88 5c 17 34          	mov    %bl,0x34(%edi,%edx,1)
  for(i = 0; i < n; i++){
8010392f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80103932:	0f 85 60 ff ff ff    	jne    80103898 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103938:	83 ec 0c             	sub    $0xc,%esp
8010393b:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
80103941:	52                   	push   %edx
80103942:	e8 59 09 00 00       	call   801042a0 <wakeup>
  release(&p->lock);
80103947:	89 3c 24             	mov    %edi,(%esp)
8010394a:	e8 d1 10 00 00       	call   80104a20 <release>
  return n;
8010394f:	8b 45 10             	mov    0x10(%ebp),%eax
80103952:	83 c4 10             	add    $0x10,%esp
80103955:	eb ab                	jmp    80103902 <pipewrite+0xa2>
80103957:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010395e:	66 90                	xchg   %ax,%ax

80103960 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	57                   	push   %edi
80103964:	56                   	push   %esi
80103965:	53                   	push   %ebx
80103966:	83 ec 18             	sub    $0x18,%esp
80103969:	8b 75 08             	mov    0x8(%ebp),%esi
8010396c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010396f:	56                   	push   %esi
80103970:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103976:	e8 c5 0e 00 00       	call   80104840 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010397b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103981:	83 c4 10             	add    $0x10,%esp
80103984:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010398a:	74 31                	je     801039bd <piperead+0x5d>
8010398c:	eb 39                	jmp    801039c7 <piperead+0x67>
8010398e:	66 90                	xchg   %ax,%ax
    if(proc->killed){
80103990:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103997:	8b 4a 24             	mov    0x24(%edx),%ecx
8010399a:	85 c9                	test   %ecx,%ecx
8010399c:	0f 85 8e 00 00 00    	jne    80103a30 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801039a2:	83 ec 08             	sub    $0x8,%esp
801039a5:	56                   	push   %esi
801039a6:	53                   	push   %ebx
801039a7:	e8 34 08 00 00       	call   801041e0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801039ac:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
801039b2:	83 c4 10             	add    $0x10,%esp
801039b5:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
801039bb:	75 0a                	jne    801039c7 <piperead+0x67>
801039bd:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
801039c3:	85 c0                	test   %eax,%eax
801039c5:	75 c9                	jne    80103990 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039c7:	8b 55 10             	mov    0x10(%ebp),%edx
801039ca:	31 db                	xor    %ebx,%ebx
801039cc:	85 d2                	test   %edx,%edx
801039ce:	7f 27                	jg     801039f7 <piperead+0x97>
801039d0:	eb 33                	jmp    80103a05 <piperead+0xa5>
801039d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801039d8:	8d 4a 01             	lea    0x1(%edx),%ecx
801039db:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801039e1:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801039e7:	0f b6 54 16 34       	movzbl 0x34(%esi,%edx,1),%edx
801039ec:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039ef:	83 c3 01             	add    $0x1,%ebx
801039f2:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801039f5:	74 0e                	je     80103a05 <piperead+0xa5>
    if(p->nread == p->nwrite)
801039f7:	8b 96 34 02 00 00    	mov    0x234(%esi),%edx
801039fd:	3b 96 38 02 00 00    	cmp    0x238(%esi),%edx
80103a03:	75 d3                	jne    801039d8 <piperead+0x78>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103a05:	83 ec 0c             	sub    $0xc,%esp
80103a08:	8d 96 38 02 00 00    	lea    0x238(%esi),%edx
80103a0e:	52                   	push   %edx
80103a0f:	e8 8c 08 00 00       	call   801042a0 <wakeup>
  release(&p->lock);
80103a14:	89 34 24             	mov    %esi,(%esp)
80103a17:	e8 04 10 00 00       	call   80104a20 <release>
  return i;
80103a1c:	83 c4 10             	add    $0x10,%esp
}
80103a1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a22:	89 d8                	mov    %ebx,%eax
80103a24:	5b                   	pop    %ebx
80103a25:	5e                   	pop    %esi
80103a26:	5f                   	pop    %edi
80103a27:	5d                   	pop    %ebp
80103a28:	c3                   	ret    
80103a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
80103a30:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103a33:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103a38:	56                   	push   %esi
80103a39:	e8 e2 0f 00 00       	call   80104a20 <release>
      return -1;
80103a3e:	83 c4 10             	add    $0x10,%esp
}
80103a41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a44:	89 d8                	mov    %ebx,%eax
80103a46:	5b                   	pop    %ebx
80103a47:	5e                   	pop    %esi
80103a48:	5f                   	pop    %edi
80103a49:	5d                   	pop    %ebp
80103a4a:	c3                   	ret    
80103a4b:	66 90                	xchg   %ax,%ax
80103a4d:	66 90                	xchg   %ax,%ax
80103a4f:	90                   	nop

80103a50 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a54:	bb 54 29 11 80       	mov    $0x80112954,%ebx
{
80103a59:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a5c:	68 20 29 11 80       	push   $0x80112920
80103a61:	e8 da 0d 00 00       	call   80104840 <acquire>
80103a66:	83 c4 10             	add    $0x10,%esp
80103a69:	eb 17                	jmp    80103a82 <allocproc+0x32>
80103a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a6f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a70:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103a76:	81 fb 54 4a 11 80    	cmp    $0x80114a54,%ebx
80103a7c:	0f 84 7e 00 00 00    	je     80103b00 <allocproc+0xb0>
    if(p->state == UNUSED)
80103a82:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a85:	85 c0                	test   %eax,%eax
80103a87:	75 e7                	jne    80103a70 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a89:	a1 08 b0 10 80       	mov    0x8010b008,%eax
  p->priority = 10;

  release(&ptable.lock);
80103a8e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a91:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 10;
80103a98:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
  p->pid = nextpid++;
80103a9f:	89 43 10             	mov    %eax,0x10(%ebx)
80103aa2:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103aa5:	68 20 29 11 80       	push   $0x80112920
  p->pid = nextpid++;
80103aaa:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  release(&ptable.lock);
80103ab0:	e8 6b 0f 00 00       	call   80104a20 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103ab5:	e8 f6 ec ff ff       	call   801027b0 <kalloc>
80103aba:	83 c4 10             	add    $0x10,%esp
80103abd:	89 43 08             	mov    %eax,0x8(%ebx)
80103ac0:	85 c0                	test   %eax,%eax
80103ac2:	74 55                	je     80103b19 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103ac4:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103aca:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103acd:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103ad2:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103ad5:	c7 40 14 6e 5d 10 80 	movl   $0x80105d6e,0x14(%eax)
  p->context = (struct context*)sp;
80103adc:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103adf:	6a 14                	push   $0x14
80103ae1:	6a 00                	push   $0x0
80103ae3:	50                   	push   %eax
80103ae4:	e8 87 0f 00 00       	call   80104a70 <memset>
  p->context->eip = (uint)forkret;
80103ae9:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103aec:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103aef:	c7 40 10 30 3b 10 80 	movl   $0x80103b30,0x10(%eax)
}
80103af6:	89 d8                	mov    %ebx,%eax
80103af8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103afb:	c9                   	leave  
80103afc:	c3                   	ret    
80103afd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103b00:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103b03:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103b05:	68 20 29 11 80       	push   $0x80112920
80103b0a:	e8 11 0f 00 00       	call   80104a20 <release>
}
80103b0f:	89 d8                	mov    %ebx,%eax
  return 0;
80103b11:	83 c4 10             	add    $0x10,%esp
}
80103b14:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b17:	c9                   	leave  
80103b18:	c3                   	ret    
    p->state = UNUSED;
80103b19:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103b20:	31 db                	xor    %ebx,%ebx
}
80103b22:	89 d8                	mov    %ebx,%eax
80103b24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b27:	c9                   	leave  
80103b28:	c3                   	ret    
80103b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b30 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103b30:	55                   	push   %ebp
80103b31:	89 e5                	mov    %esp,%ebp
80103b33:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103b36:	68 20 29 11 80       	push   $0x80112920
80103b3b:	e8 e0 0e 00 00       	call   80104a20 <release>

  if (first) {
80103b40:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103b45:	83 c4 10             	add    $0x10,%esp
80103b48:	85 c0                	test   %eax,%eax
80103b4a:	75 04                	jne    80103b50 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103b4c:	c9                   	leave  
80103b4d:	c3                   	ret    
80103b4e:	66 90                	xchg   %ax,%ax
    first = 0;
80103b50:	c7 05 04 b0 10 80 00 	movl   $0x0,0x8010b004
80103b57:	00 00 00 
    iinit(ROOTDEV);
80103b5a:	83 ec 0c             	sub    $0xc,%esp
80103b5d:	6a 01                	push   $0x1
80103b5f:	e8 1c db ff ff       	call   80101680 <iinit>
    initlog(ROOTDEV);
80103b64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b6b:	e8 f0 f2 ff ff       	call   80102e60 <initlog>
}
80103b70:	83 c4 10             	add    $0x10,%esp
80103b73:	c9                   	leave  
80103b74:	c3                   	ret    
80103b75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b80 <pinit>:
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103b86:	68 77 7b 10 80       	push   $0x80107b77
80103b8b:	68 20 29 11 80       	push   $0x80112920
80103b90:	e8 8b 0c 00 00       	call   80104820 <initlock>
}
80103b95:	83 c4 10             	add    $0x10,%esp
80103b98:	c9                   	leave  
80103b99:	c3                   	ret    
80103b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ba0 <userinit>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	53                   	push   %ebx
80103ba4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ba7:	e8 a4 fe ff ff       	call   80103a50 <allocproc>
80103bac:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103bae:	a3 54 4a 11 80       	mov    %eax,0x80114a54
  if((p->pgdir = setupkvm()) == 0)
80103bb3:	e8 48 33 00 00       	call   80106f00 <setupkvm>
80103bb8:	89 43 04             	mov    %eax,0x4(%ebx)
80103bbb:	85 c0                	test   %eax,%eax
80103bbd:	0f 84 bd 00 00 00    	je     80103c80 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103bc3:	83 ec 04             	sub    $0x4,%esp
80103bc6:	68 2c 00 00 00       	push   $0x2c
80103bcb:	68 60 b4 10 80       	push   $0x8010b460
80103bd0:	50                   	push   %eax
80103bd1:	e8 6a 34 00 00       	call   80107040 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103bd6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103bd9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103bdf:	6a 4c                	push   $0x4c
80103be1:	6a 00                	push   $0x0
80103be3:	ff 73 18             	pushl  0x18(%ebx)
80103be6:	e8 85 0e 00 00       	call   80104a70 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103beb:	8b 43 18             	mov    0x18(%ebx),%eax
80103bee:	ba 23 00 00 00       	mov    $0x23,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bf3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bf6:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bfb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bff:	8b 43 18             	mov    0x18(%ebx),%eax
80103c02:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103c06:	8b 43 18             	mov    0x18(%ebx),%eax
80103c09:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c0d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c11:	8b 43 18             	mov    0x18(%ebx),%eax
80103c14:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c18:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c1c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c1f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c26:	8b 43 18             	mov    0x18(%ebx),%eax
80103c29:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c30:	8b 43 18             	mov    0x18(%ebx),%eax
80103c33:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c3a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c3d:	6a 10                	push   $0x10
80103c3f:	68 97 7b 10 80       	push   $0x80107b97
80103c44:	50                   	push   %eax
80103c45:	e8 e6 0f 00 00       	call   80104c30 <safestrcpy>
  p->cwd = namei("/");
80103c4a:	c7 04 24 a0 7b 10 80 	movl   $0x80107ba0,(%esp)
80103c51:	e8 4a e5 ff ff       	call   801021a0 <namei>
80103c56:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103c59:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103c60:	e8 db 0b 00 00       	call   80104840 <acquire>
  p->state = RUNNABLE;
80103c65:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c6c:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103c73:	e8 a8 0d 00 00       	call   80104a20 <release>
}
80103c78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c7b:	83 c4 10             	add    $0x10,%esp
80103c7e:	c9                   	leave  
80103c7f:	c3                   	ret    
    panic("userinit: out of memory?");
80103c80:	83 ec 0c             	sub    $0xc,%esp
80103c83:	68 7e 7b 10 80       	push   $0x80107b7e
80103c88:	e8 f3 c6 ff ff       	call   80100380 <panic>
80103c8d:	8d 76 00             	lea    0x0(%esi),%esi

80103c90 <growproc>:
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	83 ec 08             	sub    $0x8,%esp
  sz = proc->sz;
80103c96:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103c9d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  sz = proc->sz;
80103ca0:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103ca2:	85 c9                	test   %ecx,%ecx
80103ca4:	7f 1a                	jg     80103cc0 <growproc+0x30>
  } else if(n < 0){
80103ca6:	75 38                	jne    80103ce0 <growproc+0x50>
  proc->sz = sz;
80103ca8:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103caa:	83 ec 0c             	sub    $0xc,%esp
80103cad:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103cb4:	e8 e7 32 00 00       	call   80106fa0 <switchuvm>
  return 0;
80103cb9:	83 c4 10             	add    $0x10,%esp
80103cbc:	31 c0                	xor    %eax,%eax
}
80103cbe:	c9                   	leave  
80103cbf:	c3                   	ret    
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103cc0:	83 ec 04             	sub    $0x4,%esp
80103cc3:	01 c1                	add    %eax,%ecx
80103cc5:	51                   	push   %ecx
80103cc6:	50                   	push   %eax
80103cc7:	ff 72 04             	pushl  0x4(%edx)
80103cca:	e8 e1 34 00 00       	call   801071b0 <allocuvm>
80103ccf:	83 c4 10             	add    $0x10,%esp
80103cd2:	85 c0                	test   %eax,%eax
80103cd4:	74 20                	je     80103cf6 <growproc+0x66>
  proc->sz = sz;
80103cd6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103cdd:	eb c9                	jmp    80103ca8 <growproc+0x18>
80103cdf:	90                   	nop
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103ce0:	83 ec 04             	sub    $0x4,%esp
80103ce3:	01 c1                	add    %eax,%ecx
80103ce5:	51                   	push   %ecx
80103ce6:	50                   	push   %eax
80103ce7:	ff 72 04             	pushl  0x4(%edx)
80103cea:	e8 f1 35 00 00       	call   801072e0 <deallocuvm>
80103cef:	83 c4 10             	add    $0x10,%esp
80103cf2:	85 c0                	test   %eax,%eax
80103cf4:	75 e0                	jne    80103cd6 <growproc+0x46>
}
80103cf6:	c9                   	leave  
      return -1;
80103cf7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103cfc:	c3                   	ret    
80103cfd:	8d 76 00             	lea    0x0(%esi),%esi

80103d00 <fork>:
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	57                   	push   %edi
80103d04:	56                   	push   %esi
80103d05:	53                   	push   %ebx
80103d06:	83 ec 0c             	sub    $0xc,%esp
  if((np = allocproc()) == 0){
80103d09:	e8 42 fd ff ff       	call   80103a50 <allocproc>
80103d0e:	85 c0                	test   %eax,%eax
80103d10:	0f 84 d6 00 00 00    	je     80103dec <fork+0xec>
80103d16:	89 c3                	mov    %eax,%ebx
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103d18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d1e:	83 ec 08             	sub    $0x8,%esp
80103d21:	ff 30                	pushl  (%eax)
80103d23:	ff 70 04             	pushl  0x4(%eax)
80103d26:	e8 b5 36 00 00       	call   801073e0 <copyuvm>
80103d2b:	83 c4 10             	add    $0x10,%esp
80103d2e:	89 43 04             	mov    %eax,0x4(%ebx)
80103d31:	85 c0                	test   %eax,%eax
80103d33:	0f 84 ba 00 00 00    	je     80103df3 <fork+0xf3>
  np->sz = proc->sz;
80103d39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *np->tf = *proc->tf;
80103d3f:	8b 7b 18             	mov    0x18(%ebx),%edi
80103d42:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = proc->sz;
80103d47:	8b 00                	mov    (%eax),%eax
80103d49:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103d4b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d51:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103d54:	8b 70 18             	mov    0x18(%eax),%esi
80103d57:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103d59:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103d5b:	8b 43 18             	mov    0x18(%ebx),%eax
    if(proc->ofile[i])
80103d5e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  np->tf->eax = 0;
80103d65:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[i])
80103d70:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103d74:	85 c0                	test   %eax,%eax
80103d76:	74 17                	je     80103d8f <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103d78:	83 ec 0c             	sub    $0xc,%esp
80103d7b:	50                   	push   %eax
80103d7c:	e8 2f d2 ff ff       	call   80100fb0 <filedup>
  np->cwd = idup(proc->cwd);
80103d81:	83 c4 10             	add    $0x10,%esp
      np->ofile[i] = filedup(proc->ofile[i]);
80103d84:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  np->cwd = idup(proc->cwd);
80103d88:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(i = 0; i < NOFILE; i++)
80103d8f:	83 c6 01             	add    $0x1,%esi
80103d92:	83 fe 10             	cmp    $0x10,%esi
80103d95:	75 d9                	jne    80103d70 <fork+0x70>
  np->cwd = idup(proc->cwd);
80103d97:	83 ec 0c             	sub    $0xc,%esp
80103d9a:	ff 72 68             	pushl  0x68(%edx)
80103d9d:	e8 ce da ff ff       	call   80101870 <idup>
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103da2:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(proc->cwd);
80103da5:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103da8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103dae:	6a 10                	push   $0x10
80103db0:	83 c0 6c             	add    $0x6c,%eax
80103db3:	50                   	push   %eax
80103db4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103db7:	50                   	push   %eax
80103db8:	e8 73 0e 00 00       	call   80104c30 <safestrcpy>
  pid = np->pid;
80103dbd:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103dc0:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103dc7:	e8 74 0a 00 00       	call   80104840 <acquire>
  np->state = RUNNABLE;
80103dcc:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103dd3:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103dda:	e8 41 0c 00 00       	call   80104a20 <release>
  return pid;
80103ddf:	83 c4 10             	add    $0x10,%esp
}
80103de2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103de5:	89 f0                	mov    %esi,%eax
80103de7:	5b                   	pop    %ebx
80103de8:	5e                   	pop    %esi
80103de9:	5f                   	pop    %edi
80103dea:	5d                   	pop    %ebp
80103deb:	c3                   	ret    
    return -1;
80103dec:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103df1:	eb ef                	jmp    80103de2 <fork+0xe2>
    kfree(np->kstack);
80103df3:	83 ec 0c             	sub    $0xc,%esp
80103df6:	ff 73 08             	pushl  0x8(%ebx)
    return -1;
80103df9:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103dfe:	e8 ed e7 ff ff       	call   801025f0 <kfree>
    np->kstack = 0;
80103e03:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103e0a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103e0d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103e14:	eb cc                	jmp    80103de2 <fork+0xe2>
80103e16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e1d:	8d 76 00             	lea    0x0(%esi),%esi

80103e20 <scheduler>:
{
80103e20:	55                   	push   %ebp
80103e21:	89 e5                	mov    %esp,%ebp
80103e23:	53                   	push   %ebx
80103e24:	83 ec 04             	sub    $0x4,%esp
80103e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e2e:	66 90                	xchg   %ax,%ax
  asm volatile("sti");
80103e30:	fb                   	sti    
    acquire(&ptable.lock);
80103e31:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e34:	bb 54 29 11 80       	mov    $0x80112954,%ebx
    acquire(&ptable.lock);
80103e39:	68 20 29 11 80       	push   $0x80112920
80103e3e:	e8 fd 09 00 00       	call   80104840 <acquire>
80103e43:	83 c4 10             	add    $0x10,%esp
80103e46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e4d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103e50:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103e54:	75 45                	jne    80103e9b <scheduler+0x7b>
      switchuvm(p);
80103e56:	83 ec 0c             	sub    $0xc,%esp
      proc = p;
80103e59:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103e60:	53                   	push   %ebx
80103e61:	e8 3a 31 00 00       	call   80106fa0 <switchuvm>
      swtch(&cpu->scheduler, p->context);
80103e66:	58                   	pop    %eax
80103e67:	5a                   	pop    %edx
80103e68:	ff 73 1c             	pushl  0x1c(%ebx)
80103e6b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      p->state = RUNNING;
80103e71:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&cpu->scheduler, p->context);
80103e78:	83 c0 04             	add    $0x4,%eax
80103e7b:	50                   	push   %eax
80103e7c:	e8 0a 0e 00 00       	call   80104c8b <swtch>
      switchkvm();
80103e81:	e8 0a 31 00 00       	call   80106f90 <switchkvm>
	  p->contextSwitch++;
80103e86:	83 83 80 00 00 00 01 	addl   $0x1,0x80(%ebx)
      proc = 0;
80103e8d:	83 c4 10             	add    $0x10,%esp
80103e90:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103e97:	00 00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e9b:	81 c3 84 00 00 00    	add    $0x84,%ebx
80103ea1:	81 fb 54 4a 11 80    	cmp    $0x80114a54,%ebx
80103ea7:	75 a7                	jne    80103e50 <scheduler+0x30>
    release(&ptable.lock);
80103ea9:	83 ec 0c             	sub    $0xc,%esp
80103eac:	68 20 29 11 80       	push   $0x80112920
80103eb1:	e8 6a 0b 00 00       	call   80104a20 <release>
    sti();
80103eb6:	83 c4 10             	add    $0x10,%esp
80103eb9:	e9 72 ff ff ff       	jmp    80103e30 <scheduler+0x10>
80103ebe:	66 90                	xchg   %ax,%ax

80103ec0 <sched>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	53                   	push   %ebx
80103ec4:	83 ec 10             	sub    $0x10,%esp
  if(!holding(&ptable.lock))
80103ec7:	68 20 29 11 80       	push   $0x80112920
80103ecc:	e8 9f 0a 00 00       	call   80104970 <holding>
80103ed1:	83 c4 10             	add    $0x10,%esp
80103ed4:	85 c0                	test   %eax,%eax
80103ed6:	74 4c                	je     80103f24 <sched+0x64>
  if(cpu->ncli != 1)
80103ed8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103edf:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103ee6:	75 63                	jne    80103f4b <sched+0x8b>
  if(proc->state == RUNNING)
80103ee8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103eee:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103ef2:	74 4a                	je     80103f3e <sched+0x7e>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ef4:	9c                   	pushf  
80103ef5:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
80103ef6:	80 e5 02             	and    $0x2,%ch
80103ef9:	75 36                	jne    80103f31 <sched+0x71>
  swtch(&proc->context, cpu->scheduler);
80103efb:	83 ec 08             	sub    $0x8,%esp
80103efe:	83 c0 1c             	add    $0x1c,%eax
  intena = cpu->intena;
80103f01:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103f07:	ff 72 04             	pushl  0x4(%edx)
80103f0a:	50                   	push   %eax
80103f0b:	e8 7b 0d 00 00       	call   80104c8b <swtch>
  cpu->intena = intena;
80103f10:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103f16:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80103f19:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103f1f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f22:	c9                   	leave  
80103f23:	c3                   	ret    
    panic("sched ptable.lock");
80103f24:	83 ec 0c             	sub    $0xc,%esp
80103f27:	68 a2 7b 10 80       	push   $0x80107ba2
80103f2c:	e8 4f c4 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103f31:	83 ec 0c             	sub    $0xc,%esp
80103f34:	68 ce 7b 10 80       	push   $0x80107bce
80103f39:	e8 42 c4 ff ff       	call   80100380 <panic>
    panic("sched running");
80103f3e:	83 ec 0c             	sub    $0xc,%esp
80103f41:	68 c0 7b 10 80       	push   $0x80107bc0
80103f46:	e8 35 c4 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103f4b:	83 ec 0c             	sub    $0xc,%esp
80103f4e:	68 b4 7b 10 80       	push   $0x80107bb4
80103f53:	e8 28 c4 ff ff       	call   80100380 <panic>
80103f58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f5f:	90                   	nop

80103f60 <exit>:
{
80103f60:	55                   	push   %ebp
  if(proc == initproc)
80103f61:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103f68:	89 e5                	mov    %esp,%ebp
80103f6a:	56                   	push   %esi
80103f6b:	53                   	push   %ebx
80103f6c:	31 db                	xor    %ebx,%ebx
  if(proc == initproc)
80103f6e:	3b 15 54 4a 11 80    	cmp    0x80114a54,%edx
80103f74:	0f 84 27 01 00 00    	je     801040a1 <exit+0x141>
80103f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd]){
80103f80:	8d 73 08             	lea    0x8(%ebx),%esi
80103f83:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103f87:	85 c0                	test   %eax,%eax
80103f89:	74 1b                	je     80103fa6 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103f8b:	83 ec 0c             	sub    $0xc,%esp
80103f8e:	50                   	push   %eax
80103f8f:	e8 6c d0 ff ff       	call   80101000 <fileclose>
      proc->ofile[fd] = 0;
80103f94:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103f9b:	83 c4 10             	add    $0x10,%esp
80103f9e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103fa5:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103fa6:	83 c3 01             	add    $0x1,%ebx
80103fa9:	83 fb 10             	cmp    $0x10,%ebx
80103fac:	75 d2                	jne    80103f80 <exit+0x20>
  begin_op();
80103fae:	e8 4d ef ff ff       	call   80102f00 <begin_op>
  iput(proc->cwd);
80103fb3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103fb9:	83 ec 0c             	sub    $0xc,%esp
80103fbc:	ff 70 68             	pushl  0x68(%eax)
80103fbf:	e8 0c da ff ff       	call   801019d0 <iput>
  end_op();
80103fc4:	e8 a7 ef ff ff       	call   80102f70 <end_op>
  proc->cwd = 0;
80103fc9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103fcf:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
  acquire(&ptable.lock);
80103fd6:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80103fdd:	e8 5e 08 00 00       	call   80104840 <acquire>
  wakeup1(proc->parent);
80103fe2:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80103fe9:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fec:	b8 54 29 11 80       	mov    $0x80112954,%eax
  wakeup1(proc->parent);
80103ff1:	8b 53 14             	mov    0x14(%ebx),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ff4:	eb 16                	jmp    8010400c <exit+0xac>
80103ff6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ffd:	8d 76 00             	lea    0x0(%esi),%esi
80104000:	05 84 00 00 00       	add    $0x84,%eax
80104005:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
8010400a:	74 1e                	je     8010402a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
8010400c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104010:	75 ee                	jne    80104000 <exit+0xa0>
80104012:	3b 50 20             	cmp    0x20(%eax),%edx
80104015:	75 e9                	jne    80104000 <exit+0xa0>
      p->state = RUNNABLE;
80104017:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010401e:	05 84 00 00 00       	add    $0x84,%eax
80104023:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
80104028:	75 e2                	jne    8010400c <exit+0xac>
      p->parent = initproc;
8010402a:	8b 0d 54 4a 11 80    	mov    0x80114a54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104030:	ba 54 29 11 80       	mov    $0x80112954,%edx
80104035:	eb 17                	jmp    8010404e <exit+0xee>
80104037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010403e:	66 90                	xchg   %ax,%ax
80104040:	81 c2 84 00 00 00    	add    $0x84,%edx
80104046:	81 fa 54 4a 11 80    	cmp    $0x80114a54,%edx
8010404c:	74 3a                	je     80104088 <exit+0x128>
    if(p->parent == proc){
8010404e:	3b 5a 14             	cmp    0x14(%edx),%ebx
80104051:	75 ed                	jne    80104040 <exit+0xe0>
      if(p->state == ZOMBIE)
80104053:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104057:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010405a:	75 e4                	jne    80104040 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010405c:	b8 54 29 11 80       	mov    $0x80112954,%eax
80104061:	eb 11                	jmp    80104074 <exit+0x114>
80104063:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104067:	90                   	nop
80104068:	05 84 00 00 00       	add    $0x84,%eax
8010406d:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
80104072:	74 cc                	je     80104040 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80104074:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104078:	75 ee                	jne    80104068 <exit+0x108>
8010407a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010407d:	75 e9                	jne    80104068 <exit+0x108>
      p->state = RUNNABLE;
8010407f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104086:	eb e0                	jmp    80104068 <exit+0x108>
  proc->state = ZOMBIE;
80104088:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
8010408f:	e8 2c fe ff ff       	call   80103ec0 <sched>
  panic("zombie exit");
80104094:	83 ec 0c             	sub    $0xc,%esp
80104097:	68 ef 7b 10 80       	push   $0x80107bef
8010409c:	e8 df c2 ff ff       	call   80100380 <panic>
    panic("init exiting");
801040a1:	83 ec 0c             	sub    $0xc,%esp
801040a4:	68 e2 7b 10 80       	push   $0x80107be2
801040a9:	e8 d2 c2 ff ff       	call   80100380 <panic>
801040ae:	66 90                	xchg   %ax,%ax

801040b0 <wait>:
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	56                   	push   %esi
801040b4:	53                   	push   %ebx
  acquire(&ptable.lock);
801040b5:	83 ec 0c             	sub    $0xc,%esp
801040b8:	68 20 29 11 80       	push   $0x80112920
801040bd:	e8 7e 07 00 00       	call   80104840 <acquire>
      if(p->parent != proc)
801040c2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801040c8:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801040cb:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040cd:	bb 54 29 11 80       	mov    $0x80112954,%ebx
801040d2:	eb 12                	jmp    801040e6 <wait+0x36>
801040d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040d8:	81 c3 84 00 00 00    	add    $0x84,%ebx
801040de:	81 fb 54 4a 11 80    	cmp    $0x80114a54,%ebx
801040e4:	74 1e                	je     80104104 <wait+0x54>
      if(p->parent != proc)
801040e6:	39 43 14             	cmp    %eax,0x14(%ebx)
801040e9:	75 ed                	jne    801040d8 <wait+0x28>
      if(p->state == ZOMBIE){
801040eb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801040ef:	74 3f                	je     80104130 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f1:	81 c3 84 00 00 00    	add    $0x84,%ebx
      havekids = 1;
801040f7:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040fc:	81 fb 54 4a 11 80    	cmp    $0x80114a54,%ebx
80104102:	75 e2                	jne    801040e6 <wait+0x36>
    if(!havekids || proc->killed){
80104104:	85 d2                	test   %edx,%edx
80104106:	74 7e                	je     80104186 <wait+0xd6>
80104108:	8b 50 24             	mov    0x24(%eax),%edx
8010410b:	85 d2                	test   %edx,%edx
8010410d:	75 77                	jne    80104186 <wait+0xd6>
  proc->chan = chan;
8010410f:	89 40 20             	mov    %eax,0x20(%eax)
  proc->state = SLEEPING;
80104112:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80104119:	e8 a2 fd ff ff       	call   80103ec0 <sched>
  proc->chan = 0;
8010411e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104124:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
8010412b:	eb 9e                	jmp    801040cb <wait+0x1b>
8010412d:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104130:	83 ec 0c             	sub    $0xc,%esp
80104133:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104136:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104139:	e8 b2 e4 ff ff       	call   801025f0 <kfree>
        freevm(p->pgdir);
8010413e:	59                   	pop    %ecx
8010413f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104142:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104149:	e8 c2 31 00 00       	call   80107310 <freevm>
        release(&ptable.lock);
8010414e:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
        p->pid = 0;
80104155:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010415c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104163:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104167:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010416e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104175:	e8 a6 08 00 00       	call   80104a20 <release>
        return pid;
8010417a:	83 c4 10             	add    $0x10,%esp
}
8010417d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104180:	89 f0                	mov    %esi,%eax
80104182:	5b                   	pop    %ebx
80104183:	5e                   	pop    %esi
80104184:	5d                   	pop    %ebp
80104185:	c3                   	ret    
      release(&ptable.lock);
80104186:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104189:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010418e:	68 20 29 11 80       	push   $0x80112920
80104193:	e8 88 08 00 00       	call   80104a20 <release>
      return -1;
80104198:	83 c4 10             	add    $0x10,%esp
8010419b:	eb e0                	jmp    8010417d <wait+0xcd>
8010419d:	8d 76 00             	lea    0x0(%esi),%esi

801041a0 <yield>:
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801041a6:	68 20 29 11 80       	push   $0x80112920
801041ab:	e8 90 06 00 00       	call   80104840 <acquire>
  proc->state = RUNNABLE;
801041b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801041b6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
801041bd:	e8 fe fc ff ff       	call   80103ec0 <sched>
  release(&ptable.lock);
801041c2:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
801041c9:	e8 52 08 00 00       	call   80104a20 <release>
}
801041ce:	83 c4 10             	add    $0x10,%esp
801041d1:	c9                   	leave  
801041d2:	c3                   	ret    
801041d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041e0 <sleep>:
{
801041e0:	55                   	push   %ebp
  if(proc == 0)
801041e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
801041e7:	89 e5                	mov    %esp,%ebp
801041e9:	56                   	push   %esi
801041ea:	8b 75 08             	mov    0x8(%ebp),%esi
801041ed:	53                   	push   %ebx
801041ee:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
801041f1:	85 c0                	test   %eax,%eax
801041f3:	0f 84 97 00 00 00    	je     80104290 <sleep+0xb0>
  if(lk == 0)
801041f9:	85 db                	test   %ebx,%ebx
801041fb:	0f 84 82 00 00 00    	je     80104283 <sleep+0xa3>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104201:	81 fb 20 29 11 80    	cmp    $0x80112920,%ebx
80104207:	74 57                	je     80104260 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104209:	83 ec 0c             	sub    $0xc,%esp
8010420c:	68 20 29 11 80       	push   $0x80112920
80104211:	e8 2a 06 00 00       	call   80104840 <acquire>
    release(lk);
80104216:	89 1c 24             	mov    %ebx,(%esp)
80104219:	e8 02 08 00 00       	call   80104a20 <release>
  proc->chan = chan;
8010421e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104224:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80104227:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
8010422e:	e8 8d fc ff ff       	call   80103ec0 <sched>
  proc->chan = 0;
80104233:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104239:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    release(&ptable.lock);
80104240:	c7 04 24 20 29 11 80 	movl   $0x80112920,(%esp)
80104247:	e8 d4 07 00 00       	call   80104a20 <release>
    acquire(lk);
8010424c:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010424f:	83 c4 10             	add    $0x10,%esp
}
80104252:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104255:	5b                   	pop    %ebx
80104256:	5e                   	pop    %esi
80104257:	5d                   	pop    %ebp
    acquire(lk);
80104258:	e9 e3 05 00 00       	jmp    80104840 <acquire>
8010425d:	8d 76 00             	lea    0x0(%esi),%esi
  proc->chan = chan;
80104260:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80104263:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
8010426a:	e8 51 fc ff ff       	call   80103ec0 <sched>
  proc->chan = 0;
8010426f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104275:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
}
8010427c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010427f:	5b                   	pop    %ebx
80104280:	5e                   	pop    %esi
80104281:	5d                   	pop    %ebp
80104282:	c3                   	ret    
    panic("sleep without lk");
80104283:	83 ec 0c             	sub    $0xc,%esp
80104286:	68 01 7c 10 80       	push   $0x80107c01
8010428b:	e8 f0 c0 ff ff       	call   80100380 <panic>
    panic("sleep");
80104290:	83 ec 0c             	sub    $0xc,%esp
80104293:	68 fb 7b 10 80       	push   $0x80107bfb
80104298:	e8 e3 c0 ff ff       	call   80100380 <panic>
8010429d:	8d 76 00             	lea    0x0(%esi),%esi

801042a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 10             	sub    $0x10,%esp
801042a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801042aa:	68 20 29 11 80       	push   $0x80112920
801042af:	e8 8c 05 00 00       	call   80104840 <acquire>
801042b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042b7:	b8 54 29 11 80       	mov    $0x80112954,%eax
801042bc:	eb 0e                	jmp    801042cc <wakeup+0x2c>
801042be:	66 90                	xchg   %ax,%ax
801042c0:	05 84 00 00 00       	add    $0x84,%eax
801042c5:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
801042ca:	74 1e                	je     801042ea <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801042cc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801042d0:	75 ee                	jne    801042c0 <wakeup+0x20>
801042d2:	3b 58 20             	cmp    0x20(%eax),%ebx
801042d5:	75 e9                	jne    801042c0 <wakeup+0x20>
      p->state = RUNNABLE;
801042d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042de:	05 84 00 00 00       	add    $0x84,%eax
801042e3:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
801042e8:	75 e2                	jne    801042cc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801042ea:	c7 45 08 20 29 11 80 	movl   $0x80112920,0x8(%ebp)
}
801042f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042f4:	c9                   	leave  
  release(&ptable.lock);
801042f5:	e9 26 07 00 00       	jmp    80104a20 <release>
801042fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104300 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	53                   	push   %ebx
80104304:	83 ec 10             	sub    $0x10,%esp
80104307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010430a:	68 20 29 11 80       	push   $0x80112920
8010430f:	e8 2c 05 00 00       	call   80104840 <acquire>
80104314:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104317:	b8 54 29 11 80       	mov    $0x80112954,%eax
8010431c:	eb 0e                	jmp    8010432c <kill+0x2c>
8010431e:	66 90                	xchg   %ax,%ax
80104320:	05 84 00 00 00       	add    $0x84,%eax
80104325:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
8010432a:	74 34                	je     80104360 <kill+0x60>
    if(p->pid == pid){
8010432c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010432f:	75 ef                	jne    80104320 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104331:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104335:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010433c:	75 07                	jne    80104345 <kill+0x45>
        p->state = RUNNABLE;
8010433e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104345:	83 ec 0c             	sub    $0xc,%esp
80104348:	68 20 29 11 80       	push   $0x80112920
8010434d:	e8 ce 06 00 00       	call   80104a20 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104352:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104355:	83 c4 10             	add    $0x10,%esp
80104358:	31 c0                	xor    %eax,%eax
}
8010435a:	c9                   	leave  
8010435b:	c3                   	ret    
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104360:	83 ec 0c             	sub    $0xc,%esp
80104363:	68 20 29 11 80       	push   $0x80112920
80104368:	e8 b3 06 00 00       	call   80104a20 <release>
}
8010436d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104370:	83 c4 10             	add    $0x10,%esp
80104373:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104378:	c9                   	leave  
80104379:	c3                   	ret    
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104380 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	57                   	push   %edi
80104384:	56                   	push   %esi
80104385:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104388:	53                   	push   %ebx
80104389:	bb c0 29 11 80       	mov    $0x801129c0,%ebx
8010438e:	83 ec 3c             	sub    $0x3c,%esp
80104391:	eb 27                	jmp    801043ba <procdump+0x3a>
80104393:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104397:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104398:	83 ec 0c             	sub    $0xc,%esp
8010439b:	68 66 7b 10 80       	push   $0x80107b66
801043a0:	e8 db c2 ff ff       	call   80100680 <cprintf>
801043a5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043a8:	81 c3 84 00 00 00    	add    $0x84,%ebx
801043ae:	81 fb c0 4a 11 80    	cmp    $0x80114ac0,%ebx
801043b4:	0f 84 7e 00 00 00    	je     80104438 <procdump+0xb8>
    if(p->state == UNUSED)
801043ba:	8b 43 a0             	mov    -0x60(%ebx),%eax
801043bd:	85 c0                	test   %eax,%eax
801043bf:	74 e7                	je     801043a8 <procdump+0x28>
      state = "???";
801043c1:	ba 12 7c 10 80       	mov    $0x80107c12,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043c6:	83 f8 05             	cmp    $0x5,%eax
801043c9:	77 11                	ja     801043dc <procdump+0x5c>
801043cb:	8b 14 85 f0 7c 10 80 	mov    -0x7fef8310(,%eax,4),%edx
      state = "???";
801043d2:	b8 12 7c 10 80       	mov    $0x80107c12,%eax
801043d7:	85 d2                	test   %edx,%edx
801043d9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801043dc:	53                   	push   %ebx
801043dd:	52                   	push   %edx
801043de:	ff 73 a4             	pushl  -0x5c(%ebx)
801043e1:	68 16 7c 10 80       	push   $0x80107c16
801043e6:	e8 95 c2 ff ff       	call   80100680 <cprintf>
    if(p->state == SLEEPING){
801043eb:	83 c4 10             	add    $0x10,%esp
801043ee:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801043f2:	75 a4                	jne    80104398 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801043f4:	83 ec 08             	sub    $0x8,%esp
801043f7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801043fa:	8d 7d c0             	lea    -0x40(%ebp),%edi
801043fd:	50                   	push   %eax
801043fe:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104401:	8b 40 0c             	mov    0xc(%eax),%eax
80104404:	83 c0 08             	add    $0x8,%eax
80104407:	50                   	push   %eax
80104408:	e8 03 05 00 00       	call   80104910 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010440d:	83 c4 10             	add    $0x10,%esp
80104410:	8b 17                	mov    (%edi),%edx
80104412:	85 d2                	test   %edx,%edx
80104414:	74 82                	je     80104398 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104416:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104419:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010441c:	52                   	push   %edx
8010441d:	68 89 76 10 80       	push   $0x80107689
80104422:	e8 59 c2 ff ff       	call   80100680 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104427:	83 c4 10             	add    $0x10,%esp
8010442a:	39 fe                	cmp    %edi,%esi
8010442c:	75 e2                	jne    80104410 <procdump+0x90>
8010442e:	e9 65 ff ff ff       	jmp    80104398 <procdump+0x18>
80104433:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104437:	90                   	nop
  }
}
80104438:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010443b:	5b                   	pop    %ebx
8010443c:	5e                   	pop    %esi
8010443d:	5f                   	pop    %edi
8010443e:	5d                   	pop    %ebp
8010443f:	c3                   	ret    

80104440 <halt>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104440:	31 c0                	xor    %eax,%eax
80104442:	ba f4 00 00 00       	mov    $0xf4,%edx
80104447:	ee                   	out    %al,(%dx)
int
halt()
{
	outb(0xf4, 0x00);
	return 22;
}
80104448:	b8 16 00 00 00       	mov    $0x16,%eax
8010444d:	c3                   	ret    
8010444e:	66 90                	xchg   %ax,%ax

80104450 <cps>:

int
cps()
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp
80104453:	53                   	push   %ebx
80104454:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
80104457:	fb                   	sti    
struct proc *p;
sti();
acquire(&ptable.lock);
80104458:	68 20 29 11 80       	push   $0x80112920
8010445d:	bb c0 29 11 80       	mov    $0x801129c0,%ebx
80104462:	e8 d9 03 00 00       	call   80104840 <acquire>
cprintf("Name \t Pid \t State \t\t Priority \n");
80104467:	c7 04 24 cc 7c 10 80 	movl   $0x80107ccc,(%esp)
8010446e:	e8 0d c2 ff ff       	call   80100680 <cprintf>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
80104473:	83 c4 10             	add    $0x10,%esp
80104476:	eb 32                	jmp    801044aa <cps+0x5a>
80104478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010447f:	90                   	nop
{
	if(p->state == SLEEPING)
		cprintf("%s \t %d \t Sleeping \t %d \n ", p->name, p->pid, p->priority);
	if(p->state == RUNNING)
80104480:	83 f8 04             	cmp    $0x4,%eax
80104483:	74 49                	je     801044ce <cps+0x7e>
 		cprintf("%s \t %d \t Running \t %d \n ", p->name, p->pid, p->priority);
  	if(p->state == RUNNABLE)
80104485:	83 f8 03             	cmp    $0x3,%eax
80104488:	74 60                	je     801044ea <cps+0x9a>
 		cprintf("%s \t %d \t Runnable \t %d \n ", p->name, p->pid, p->priority);
 	if(p->state == ZOMBIE)
8010448a:	83 f8 05             	cmp    $0x5,%eax
8010448d:	74 77                	je     80104506 <cps+0xb6>
 		cprintf("%s \t %d \t Zombie \t %d \n ", p->name, p->pid, p->priority);
 	if(p->state == EMBRYO)
8010448f:	83 f8 01             	cmp    $0x1,%eax
80104492:	0f 84 8e 00 00 00    	je     80104526 <cps+0xd6>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
80104498:	81 c3 84 00 00 00    	add    $0x84,%ebx
8010449e:	81 fb c0 4a 11 80    	cmp    $0x80114ac0,%ebx
801044a4:	0f 84 a2 00 00 00    	je     8010454c <cps+0xfc>
	if(p->state == SLEEPING)
801044aa:	8b 43 a0             	mov    -0x60(%ebx),%eax
801044ad:	83 f8 02             	cmp    $0x2,%eax
801044b0:	75 ce                	jne    80104480 <cps+0x30>
		cprintf("%s \t %d \t Sleeping \t %d \n ", p->name, p->pid, p->priority);
801044b2:	ff 73 10             	pushl  0x10(%ebx)
801044b5:	ff 73 a4             	pushl  -0x5c(%ebx)
801044b8:	53                   	push   %ebx
801044b9:	68 1f 7c 10 80       	push   $0x80107c1f
801044be:	e8 bd c1 ff ff       	call   80100680 <cprintf>
	if(p->state == RUNNING)
801044c3:	8b 43 a0             	mov    -0x60(%ebx),%eax
801044c6:	83 c4 10             	add    $0x10,%esp
801044c9:	83 f8 04             	cmp    $0x4,%eax
801044cc:	75 b7                	jne    80104485 <cps+0x35>
 		cprintf("%s \t %d \t Running \t %d \n ", p->name, p->pid, p->priority);
801044ce:	ff 73 10             	pushl  0x10(%ebx)
801044d1:	ff 73 a4             	pushl  -0x5c(%ebx)
801044d4:	53                   	push   %ebx
801044d5:	68 3a 7c 10 80       	push   $0x80107c3a
801044da:	e8 a1 c1 ff ff       	call   80100680 <cprintf>
  	if(p->state == RUNNABLE)
801044df:	8b 43 a0             	mov    -0x60(%ebx),%eax
801044e2:	83 c4 10             	add    $0x10,%esp
801044e5:	83 f8 03             	cmp    $0x3,%eax
801044e8:	75 a0                	jne    8010448a <cps+0x3a>
 		cprintf("%s \t %d \t Runnable \t %d \n ", p->name, p->pid, p->priority);
801044ea:	ff 73 10             	pushl  0x10(%ebx)
801044ed:	ff 73 a4             	pushl  -0x5c(%ebx)
801044f0:	53                   	push   %ebx
801044f1:	68 54 7c 10 80       	push   $0x80107c54
801044f6:	e8 85 c1 ff ff       	call   80100680 <cprintf>
 	if(p->state == ZOMBIE)
801044fb:	8b 43 a0             	mov    -0x60(%ebx),%eax
801044fe:	83 c4 10             	add    $0x10,%esp
80104501:	83 f8 05             	cmp    $0x5,%eax
80104504:	75 89                	jne    8010448f <cps+0x3f>
 		cprintf("%s \t %d \t Zombie \t %d \n ", p->name, p->pid, p->priority);
80104506:	ff 73 10             	pushl  0x10(%ebx)
80104509:	ff 73 a4             	pushl  -0x5c(%ebx)
8010450c:	53                   	push   %ebx
8010450d:	68 6f 7c 10 80       	push   $0x80107c6f
80104512:	e8 69 c1 ff ff       	call   80100680 <cprintf>
 	if(p->state == EMBRYO)
80104517:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010451a:	83 c4 10             	add    $0x10,%esp
8010451d:	83 f8 01             	cmp    $0x1,%eax
80104520:	0f 85 72 ff ff ff    	jne    80104498 <cps+0x48>
 		cprintf("%s \t %d \t Embryo \t %d \n ", p->name, p->pid, p->priority);	
80104526:	ff 73 10             	pushl  0x10(%ebx)
80104529:	ff 73 a4             	pushl  -0x5c(%ebx)
8010452c:	53                   	push   %ebx
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
8010452d:	81 c3 84 00 00 00    	add    $0x84,%ebx
 		cprintf("%s \t %d \t Embryo \t %d \n ", p->name, p->pid, p->priority);	
80104533:	68 88 7c 10 80       	push   $0x80107c88
80104538:	e8 43 c1 ff ff       	call   80100680 <cprintf>
8010453d:	83 c4 10             	add    $0x10,%esp
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
80104540:	81 fb c0 4a 11 80    	cmp    $0x80114ac0,%ebx
80104546:	0f 85 5e ff ff ff    	jne    801044aa <cps+0x5a>
}
release(&ptable.lock);
8010454c:	83 ec 0c             	sub    $0xc,%esp
8010454f:	68 20 29 11 80       	push   $0x80112920
80104554:	e8 c7 04 00 00       	call   80104a20 <release>
return 23;
}
80104559:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010455c:	b8 17 00 00 00       	mov    $0x17,%eax
80104561:	c9                   	leave  
80104562:	c3                   	ret    
80104563:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010456a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104570 <chpr>:

// change priority
int
chpr(int pid, int priority)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	53                   	push   %ebx
80104574:	83 ec 10             	sub    $0x10,%esp
80104577:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc *p;
	acquire(&ptable.lock);
8010457a:	68 20 29 11 80       	push   $0x80112920
8010457f:	e8 bc 02 00 00       	call   80104840 <acquire>
80104584:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104587:	b8 54 29 11 80       	mov    $0x80112954,%eax
8010458c:	eb 0e                	jmp    8010459c <chpr+0x2c>
8010458e:	66 90                	xchg   %ax,%ax
80104590:	05 84 00 00 00       	add    $0x84,%eax
80104595:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
8010459a:	74 0b                	je     801045a7 <chpr+0x37>
	  if(p->pid == pid){
8010459c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010459f:	75 ef                	jne    80104590 <chpr+0x20>
			p->priority = priority;
801045a1:	8b 55 0c             	mov    0xc(%ebp),%edx
801045a4:	89 50 7c             	mov    %edx,0x7c(%eax)
			break;
		}
	}
	release(&ptable.lock);
801045a7:	83 ec 0c             	sub    $0xc,%esp
801045aa:	68 20 29 11 80       	push   $0x80112920
801045af:	e8 6c 04 00 00       	call   80104a20 <release>
	return pid;
}
801045b4:	89 d8                	mov    %ebx,%eax
801045b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045b9:	c9                   	leave  
801045ba:	c3                   	ret    
801045bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045bf:	90                   	nop

801045c0 <getNumProc>:

// getNumProc
int
getNumProc()
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	53                   	push   %ebx
	struct proc *p;
	int count = 0;
801045c4:	31 db                	xor    %ebx,%ebx
{
801045c6:	83 ec 10             	sub    $0x10,%esp
	acquire(&ptable.lock);
801045c9:	68 20 29 11 80       	push   $0x80112920
801045ce:	e8 6d 02 00 00       	call   80104840 <acquire>
801045d3:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801045d6:	b8 54 29 11 80       	mov    $0x80112954,%eax
801045db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045df:	90                   	nop
		if(p->state != UNUSED)
			++count;
801045e0:	83 78 0c 01          	cmpl   $0x1,0xc(%eax)
801045e4:	83 db ff             	sbb    $0xffffffff,%ebx
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
801045e7:	05 84 00 00 00       	add    $0x84,%eax
801045ec:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
801045f1:	75 ed                	jne    801045e0 <getNumProc+0x20>
	}
	release(&ptable.lock);
801045f3:	83 ec 0c             	sub    $0xc,%esp
801045f6:	68 20 29 11 80       	push   $0x80112920
801045fb:	e8 20 04 00 00       	call   80104a20 <release>
	return count;
}
80104600:	89 d8                	mov    %ebx,%eax
80104602:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104605:	c9                   	leave  
80104606:	c3                   	ret    
80104607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010460e:	66 90                	xchg   %ax,%ax

80104610 <getMaxPid>:

// getMaxPid
int
getMaxPid()
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
	struct proc *p;
	int max = -1;
80104614:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
{
80104619:	83 ec 10             	sub    $0x10,%esp
	acquire(&ptable.lock);
8010461c:	68 20 29 11 80       	push   $0x80112920
80104621:	e8 1a 02 00 00       	call   80104840 <acquire>
80104626:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104629:	b8 54 29 11 80       	mov    $0x80112954,%eax
8010462e:	66 90                	xchg   %ax,%ax
		if(p->pid > max)
80104630:	8b 50 10             	mov    0x10(%eax),%edx
80104633:	39 d3                	cmp    %edx,%ebx
80104635:	0f 4c da             	cmovl  %edx,%ebx
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104638:	05 84 00 00 00       	add    $0x84,%eax
8010463d:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
80104642:	75 ec                	jne    80104630 <getMaxPid+0x20>
			max = p->pid;
	}
	release(&ptable.lock);
80104644:	83 ec 0c             	sub    $0xc,%esp
80104647:	68 20 29 11 80       	push   $0x80112920
8010464c:	e8 cf 03 00 00       	call   80104a20 <release>
	return max;
}
80104651:	89 d8                	mov    %ebx,%eax
80104653:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104656:	c9                   	leave  
80104657:	c3                   	ret    
80104658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010465f:	90                   	nop

80104660 <getProcInfo>:

// getProcInfo
int
getProcInfo(int pid, struct processInfo *pfo)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
80104665:	8b 75 0c             	mov    0xc(%ebp),%esi
80104668:	8b 5d 08             	mov    0x8(%ebp),%ebx
	int found = 0;
	struct proc *p;
	acquire(&ptable.lock);
8010466b:	83 ec 0c             	sub    $0xc,%esp
8010466e:	68 20 29 11 80       	push   $0x80112920
80104673:	e8 c8 01 00 00       	call   80104840 <acquire>
80104678:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010467b:	b8 54 29 11 80       	mov    $0x80112954,%eax
80104680:	eb 12                	jmp    80104694 <getProcInfo+0x34>
80104682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104688:	05 84 00 00 00       	add    $0x84,%eax
8010468d:	3d 54 4a 11 80       	cmp    $0x80114a54,%eax
80104692:	74 34                	je     801046c8 <getProcInfo+0x68>
		if(p->pid == pid) {
80104694:	39 58 10             	cmp    %ebx,0x10(%eax)
80104697:	75 ef                	jne    80104688 <getProcInfo+0x28>
			break;
		}
	}
	if(found == 0)
		return -1;
	pfo->ppid = p->pid;
80104699:	89 1e                	mov    %ebx,(%esi)
	pfo->psize = p->sz;
8010469b:	8b 10                	mov    (%eax),%edx
	pfo->numberContextSwitches = p->contextSwitch;
	release(&ptable.lock);
8010469d:	83 ec 0c             	sub    $0xc,%esp
	pfo->psize = p->sz;
801046a0:	89 56 04             	mov    %edx,0x4(%esi)
	pfo->numberContextSwitches = p->contextSwitch;
801046a3:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
801046a9:	89 46 08             	mov    %eax,0x8(%esi)
	release(&ptable.lock);
801046ac:	68 20 29 11 80       	push   $0x80112920
801046b1:	e8 6a 03 00 00       	call   80104a20 <release>
	return 0;	
801046b6:	83 c4 10             	add    $0x10,%esp
}
801046b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
	return 0;	
801046bc:	31 c0                	xor    %eax,%eax
}
801046be:	5b                   	pop    %ebx
801046bf:	5e                   	pop    %esi
801046c0:	5d                   	pop    %ebp
801046c1:	c3                   	ret    
801046c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
		return -1;
801046cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801046d0:	5b                   	pop    %ebx
801046d1:	5e                   	pop    %esi
801046d2:	5d                   	pop    %ebp
801046d3:	c3                   	ret    
801046d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046df:	90                   	nop

801046e0 <setprio>:

// setprio
int
setprio(int n)
{
801046e0:	55                   	push   %ebp
	proc->priority = n;
801046e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
801046e7:	89 e5                	mov    %esp,%ebp
	proc->priority = n;
801046e9:	8b 55 08             	mov    0x8(%ebp),%edx
801046ec:	89 50 7c             	mov    %edx,0x7c(%eax)
	return 0;
}
801046ef:	31 c0                	xor    %eax,%eax
801046f1:	5d                   	pop    %ebp
801046f2:	c3                   	ret    
801046f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104700 <getprio>:

// getprio
int
getprio()
{
	return proc->priority;
80104700:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104706:	8b 40 7c             	mov    0x7c(%eax),%eax
}
80104709:	c3                   	ret    
8010470a:	66 90                	xchg   %ax,%ax
8010470c:	66 90                	xchg   %ax,%ax
8010470e:	66 90                	xchg   %ax,%ax

80104710 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	53                   	push   %ebx
80104714:	83 ec 0c             	sub    $0xc,%esp
80104717:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010471a:	68 08 7d 10 80       	push   $0x80107d08
8010471f:	8d 43 04             	lea    0x4(%ebx),%eax
80104722:	50                   	push   %eax
80104723:	e8 f8 00 00 00       	call   80104820 <initlock>
  lk->name = name;
80104728:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010472b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104731:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104734:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010473b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010473e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104741:	c9                   	leave  
80104742:	c3                   	ret    
80104743:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010474a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104750 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	56                   	push   %esi
80104754:	53                   	push   %ebx
80104755:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104758:	8d 73 04             	lea    0x4(%ebx),%esi
8010475b:	83 ec 0c             	sub    $0xc,%esp
8010475e:	56                   	push   %esi
8010475f:	e8 dc 00 00 00       	call   80104840 <acquire>
  while (lk->locked) {
80104764:	8b 13                	mov    (%ebx),%edx
80104766:	83 c4 10             	add    $0x10,%esp
80104769:	85 d2                	test   %edx,%edx
8010476b:	74 16                	je     80104783 <acquiresleep+0x33>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104770:	83 ec 08             	sub    $0x8,%esp
80104773:	56                   	push   %esi
80104774:	53                   	push   %ebx
80104775:	e8 66 fa ff ff       	call   801041e0 <sleep>
  while (lk->locked) {
8010477a:	8b 03                	mov    (%ebx),%eax
8010477c:	83 c4 10             	add    $0x10,%esp
8010477f:	85 c0                	test   %eax,%eax
80104781:	75 ed                	jne    80104770 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104783:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
80104789:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010478f:	8b 40 10             	mov    0x10(%eax),%eax
80104792:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104795:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104798:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010479b:	5b                   	pop    %ebx
8010479c:	5e                   	pop    %esi
8010479d:	5d                   	pop    %ebp
  release(&lk->lk);
8010479e:	e9 7d 02 00 00       	jmp    80104a20 <release>
801047a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047b0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801047b8:	8d 73 04             	lea    0x4(%ebx),%esi
801047bb:	83 ec 0c             	sub    $0xc,%esp
801047be:	56                   	push   %esi
801047bf:	e8 7c 00 00 00       	call   80104840 <acquire>
  lk->locked = 0;
801047c4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801047ca:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801047d1:	89 1c 24             	mov    %ebx,(%esp)
801047d4:	e8 c7 fa ff ff       	call   801042a0 <wakeup>
  release(&lk->lk);
801047d9:	89 75 08             	mov    %esi,0x8(%ebp)
801047dc:	83 c4 10             	add    $0x10,%esp
}
801047df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047e2:	5b                   	pop    %ebx
801047e3:	5e                   	pop    %esi
801047e4:	5d                   	pop    %ebp
  release(&lk->lk);
801047e5:	e9 36 02 00 00       	jmp    80104a20 <release>
801047ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047f0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	56                   	push   %esi
801047f4:	53                   	push   %ebx
801047f5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801047f8:	8d 5e 04             	lea    0x4(%esi),%ebx
801047fb:	83 ec 0c             	sub    $0xc,%esp
801047fe:	53                   	push   %ebx
801047ff:	e8 3c 00 00 00       	call   80104840 <acquire>
  r = lk->locked;
80104804:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104806:	89 1c 24             	mov    %ebx,(%esp)
80104809:	e8 12 02 00 00       	call   80104a20 <release>
  return r;
}
8010480e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104811:	89 f0                	mov    %esi,%eax
80104813:	5b                   	pop    %ebx
80104814:	5e                   	pop    %esi
80104815:	5d                   	pop    %ebp
80104816:	c3                   	ret    
80104817:	66 90                	xchg   %ax,%ax
80104819:	66 90                	xchg   %ax,%ax
8010481b:	66 90                	xchg   %ax,%ax
8010481d:	66 90                	xchg   %ax,%ax
8010481f:	90                   	nop

80104820 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104826:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104829:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010482f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104832:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104839:	5d                   	pop    %ebp
8010483a:	c3                   	ret    
8010483b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010483f:	90                   	nop

80104840 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104847:	9c                   	pushf  
80104848:	5a                   	pop    %edx
  asm volatile("cli");
80104849:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
8010484a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104851:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104857:	85 c0                	test   %eax,%eax
80104859:	75 0c                	jne    80104867 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
8010485b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104861:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
80104867:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
8010486a:	83 c0 01             	add    $0x1,%eax
8010486d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
80104873:	8b 02                	mov    (%edx),%eax
80104875:	85 c0                	test   %eax,%eax
80104877:	74 05                	je     8010487e <acquire+0x3e>
80104879:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010487c:	74 7a                	je     801048f8 <acquire+0xb8>
  asm volatile("lock; xchgl %0, %1" :
8010487e:	b9 01 00 00 00       	mov    $0x1,%ecx
80104883:	eb 06                	jmp    8010488b <acquire+0x4b>
80104885:	8d 76 00             	lea    0x0(%esi),%esi
  while(xchg(&lk->locked, 1) != 0)
80104888:	8b 55 08             	mov    0x8(%ebp),%edx
8010488b:	89 c8                	mov    %ecx,%eax
8010488d:	f0 87 02             	lock xchg %eax,(%edx)
80104890:	85 c0                	test   %eax,%eax
80104892:	75 f4                	jne    80104888 <acquire+0x48>
  __sync_synchronize();
80104894:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  ebp = (uint*)v - 2;
80104899:	89 ea                	mov    %ebp,%edx
  lk->cpu = cpu;
8010489b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801048a1:	8b 4d 08             	mov    0x8(%ebp),%ecx
801048a4:	89 41 08             	mov    %eax,0x8(%ecx)
  for(i = 0; i < 10; i++){
801048a7:	31 c0                	xor    %eax,%eax
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801048b0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801048b6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801048bc:	77 1a                	ja     801048d8 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
801048be:	8b 5a 04             	mov    0x4(%edx),%ebx
801048c1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801048c5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801048c8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801048ca:	83 f8 0a             	cmp    $0xa,%eax
801048cd:	75 e1                	jne    801048b0 <acquire+0x70>
}
801048cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048d2:	c9                   	leave  
801048d3:	c3                   	ret    
801048d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801048d8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
801048dc:	83 c1 34             	add    $0x34,%ecx
801048df:	90                   	nop
    pcs[i] = 0;
801048e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048e6:	83 c0 04             	add    $0x4,%eax
801048e9:	39 c8                	cmp    %ecx,%eax
801048eb:	75 f3                	jne    801048e0 <acquire+0xa0>
}
801048ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048f0:	c9                   	leave  
801048f1:	c3                   	ret    
801048f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("acquire");
801048f8:	83 ec 0c             	sub    $0xc,%esp
801048fb:	68 13 7d 10 80       	push   $0x80107d13
80104900:	e8 7b ba ff ff       	call   80100380 <panic>
80104905:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <getcallerpcs>:
{
80104910:	55                   	push   %ebp
  for(i = 0; i < 10; i++){
80104911:	31 d2                	xor    %edx,%edx
{
80104913:	89 e5                	mov    %esp,%ebp
80104915:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104916:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104919:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010491c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
8010491f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104920:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104926:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010492c:	77 1a                	ja     80104948 <getcallerpcs+0x38>
    pcs[i] = ebp[1];     // saved %eip
8010492e:	8b 58 04             	mov    0x4(%eax),%ebx
80104931:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104934:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104937:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104939:	83 fa 0a             	cmp    $0xa,%edx
8010493c:	75 e2                	jne    80104920 <getcallerpcs+0x10>
}
8010493e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104941:	c9                   	leave  
80104942:	c3                   	ret    
80104943:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104947:	90                   	nop
  for(; i < 10; i++)
80104948:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010494b:	8d 51 28             	lea    0x28(%ecx),%edx
8010494e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104950:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104956:	83 c0 04             	add    $0x4,%eax
80104959:	39 d0                	cmp    %edx,%eax
8010495b:	75 f3                	jne    80104950 <getcallerpcs+0x40>
}
8010495d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104960:	c9                   	leave  
80104961:	c3                   	ret    
80104962:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104970 <holding>:
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104976:	8b 02                	mov    (%edx),%eax
80104978:	85 c0                	test   %eax,%eax
8010497a:	74 14                	je     80104990 <holding+0x20>
8010497c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104982:	39 42 08             	cmp    %eax,0x8(%edx)
80104985:	0f 94 c0             	sete   %al
}
80104988:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
80104989:	0f b6 c0             	movzbl %al,%eax
}
8010498c:	c3                   	ret    
8010498d:	8d 76 00             	lea    0x0(%esi),%esi
80104990:	31 c0                	xor    %eax,%eax
80104992:	5d                   	pop    %ebp
80104993:	c3                   	ret    
80104994:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010499b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010499f:	90                   	nop

801049a0 <pushcli>:
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801049a0:	9c                   	pushf  
801049a1:	59                   	pop    %ecx
  asm volatile("cli");
801049a2:	fa                   	cli    
  if(cpu->ncli == 0)
801049a3:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801049aa:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801049b0:	85 c0                	test   %eax,%eax
801049b2:	75 0c                	jne    801049c0 <pushcli+0x20>
    cpu->intena = eflags & FL_IF;
801049b4:	81 e1 00 02 00 00    	and    $0x200,%ecx
801049ba:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
801049c0:	83 c0 01             	add    $0x1,%eax
801049c3:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
801049c9:	c3                   	ret    
801049ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049d0 <popcli>:

void
popcli(void)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801049d6:	9c                   	pushf  
801049d7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801049d8:	f6 c4 02             	test   $0x2,%ah
801049db:	75 2c                	jne    80104a09 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801049dd:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801049e4:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
801049eb:	78 0f                	js     801049fc <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
801049ed:	75 0b                	jne    801049fa <popcli+0x2a>
801049ef:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
801049f5:	85 c0                	test   %eax,%eax
801049f7:	74 01                	je     801049fa <popcli+0x2a>
  asm volatile("sti");
801049f9:	fb                   	sti    
    sti();
}
801049fa:	c9                   	leave  
801049fb:	c3                   	ret    
    panic("popcli");
801049fc:	83 ec 0c             	sub    $0xc,%esp
801049ff:	68 32 7d 10 80       	push   $0x80107d32
80104a04:	e8 77 b9 ff ff       	call   80100380 <panic>
    panic("popcli - interruptible");
80104a09:	83 ec 0c             	sub    $0xc,%esp
80104a0c:	68 1b 7d 10 80       	push   $0x80107d1b
80104a11:	e8 6a b9 ff ff       	call   80100380 <panic>
80104a16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a1d:	8d 76 00             	lea    0x0(%esi),%esi

80104a20 <release>:
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	83 ec 08             	sub    $0x8,%esp
80104a26:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
80104a29:	8b 10                	mov    (%eax),%edx
80104a2b:	85 d2                	test   %edx,%edx
80104a2d:	74 0c                	je     80104a3b <release+0x1b>
80104a2f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a36:	39 50 08             	cmp    %edx,0x8(%eax)
80104a39:	74 15                	je     80104a50 <release+0x30>
    panic("release");
80104a3b:	83 ec 0c             	sub    $0xc,%esp
80104a3e:	68 39 7d 10 80       	push   $0x80107d39
80104a43:	e8 38 b9 ff ff       	call   80100380 <panic>
80104a48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a4f:	90                   	nop
  lk->pcs[0] = 0;
80104a50:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104a57:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
80104a5e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104a63:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
80104a69:	c9                   	leave  
  popcli();
80104a6a:	e9 61 ff ff ff       	jmp    801049d0 <popcli>
80104a6f:	90                   	nop

80104a70 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	8b 55 08             	mov    0x8(%ebp),%edx
80104a77:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a7a:	53                   	push   %ebx
80104a7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104a7e:	89 d7                	mov    %edx,%edi
80104a80:	09 cf                	or     %ecx,%edi
80104a82:	83 e7 03             	and    $0x3,%edi
80104a85:	75 29                	jne    80104ab0 <memset+0x40>
    c &= 0xFF;
80104a87:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a8a:	c1 e0 18             	shl    $0x18,%eax
80104a8d:	89 fb                	mov    %edi,%ebx
80104a8f:	c1 e9 02             	shr    $0x2,%ecx
80104a92:	c1 e3 10             	shl    $0x10,%ebx
80104a95:	09 d8                	or     %ebx,%eax
80104a97:	09 f8                	or     %edi,%eax
80104a99:	c1 e7 08             	shl    $0x8,%edi
80104a9c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104a9e:	89 d7                	mov    %edx,%edi
80104aa0:	fc                   	cld    
80104aa1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104aa3:	5b                   	pop    %ebx
80104aa4:	89 d0                	mov    %edx,%eax
80104aa6:	5f                   	pop    %edi
80104aa7:	5d                   	pop    %ebp
80104aa8:	c3                   	ret    
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104ab0:	89 d7                	mov    %edx,%edi
80104ab2:	fc                   	cld    
80104ab3:	f3 aa                	rep stos %al,%es:(%edi)
80104ab5:	5b                   	pop    %ebx
80104ab6:	89 d0                	mov    %edx,%eax
80104ab8:	5f                   	pop    %edi
80104ab9:	5d                   	pop    %ebp
80104aba:	c3                   	ret    
80104abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104abf:	90                   	nop

80104ac0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	56                   	push   %esi
80104ac4:	8b 75 10             	mov    0x10(%ebp),%esi
80104ac7:	8b 55 08             	mov    0x8(%ebp),%edx
80104aca:	53                   	push   %ebx
80104acb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104ace:	85 f6                	test   %esi,%esi
80104ad0:	74 2e                	je     80104b00 <memcmp+0x40>
80104ad2:	01 c6                	add    %eax,%esi
80104ad4:	eb 14                	jmp    80104aea <memcmp+0x2a>
80104ad6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104add:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104ae0:	83 c0 01             	add    $0x1,%eax
80104ae3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104ae6:	39 f0                	cmp    %esi,%eax
80104ae8:	74 16                	je     80104b00 <memcmp+0x40>
    if(*s1 != *s2)
80104aea:	0f b6 0a             	movzbl (%edx),%ecx
80104aed:	0f b6 18             	movzbl (%eax),%ebx
80104af0:	38 d9                	cmp    %bl,%cl
80104af2:	74 ec                	je     80104ae0 <memcmp+0x20>
      return *s1 - *s2;
80104af4:	0f b6 c1             	movzbl %cl,%eax
80104af7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104af9:	5b                   	pop    %ebx
80104afa:	5e                   	pop    %esi
80104afb:	5d                   	pop    %ebp
80104afc:	c3                   	ret    
80104afd:	8d 76 00             	lea    0x0(%esi),%esi
80104b00:	5b                   	pop    %ebx
  return 0;
80104b01:	31 c0                	xor    %eax,%eax
}
80104b03:	5e                   	pop    %esi
80104b04:	5d                   	pop    %ebp
80104b05:	c3                   	ret    
80104b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b0d:	8d 76 00             	lea    0x0(%esi),%esi

80104b10 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	8b 55 08             	mov    0x8(%ebp),%edx
80104b17:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104b1a:	56                   	push   %esi
80104b1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104b1e:	39 d6                	cmp    %edx,%esi
80104b20:	73 26                	jae    80104b48 <memmove+0x38>
80104b22:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104b25:	39 fa                	cmp    %edi,%edx
80104b27:	73 1f                	jae    80104b48 <memmove+0x38>
80104b29:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104b2c:	85 c9                	test   %ecx,%ecx
80104b2e:	74 0c                	je     80104b3c <memmove+0x2c>
      *--d = *--s;
80104b30:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104b34:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104b37:	83 e8 01             	sub    $0x1,%eax
80104b3a:	73 f4                	jae    80104b30 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104b3c:	5e                   	pop    %esi
80104b3d:	89 d0                	mov    %edx,%eax
80104b3f:	5f                   	pop    %edi
80104b40:	5d                   	pop    %ebp
80104b41:	c3                   	ret    
80104b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104b48:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104b4b:	89 d7                	mov    %edx,%edi
80104b4d:	85 c9                	test   %ecx,%ecx
80104b4f:	74 eb                	je     80104b3c <memmove+0x2c>
80104b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104b58:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104b59:	39 f0                	cmp    %esi,%eax
80104b5b:	75 fb                	jne    80104b58 <memmove+0x48>
}
80104b5d:	5e                   	pop    %esi
80104b5e:	89 d0                	mov    %edx,%eax
80104b60:	5f                   	pop    %edi
80104b61:	5d                   	pop    %ebp
80104b62:	c3                   	ret    
80104b63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b70 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104b70:	eb 9e                	jmp    80104b10 <memmove>
80104b72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b80 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	56                   	push   %esi
80104b84:	8b 75 10             	mov    0x10(%ebp),%esi
80104b87:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b8a:	53                   	push   %ebx
80104b8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
80104b8e:	85 f6                	test   %esi,%esi
80104b90:	74 36                	je     80104bc8 <strncmp+0x48>
80104b92:	01 c6                	add    %eax,%esi
80104b94:	eb 18                	jmp    80104bae <strncmp+0x2e>
80104b96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b9d:	8d 76 00             	lea    0x0(%esi),%esi
80104ba0:	38 da                	cmp    %bl,%dl
80104ba2:	75 14                	jne    80104bb8 <strncmp+0x38>
    n--, p++, q++;
80104ba4:	83 c0 01             	add    $0x1,%eax
80104ba7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104baa:	39 f0                	cmp    %esi,%eax
80104bac:	74 1a                	je     80104bc8 <strncmp+0x48>
80104bae:	0f b6 11             	movzbl (%ecx),%edx
80104bb1:	0f b6 18             	movzbl (%eax),%ebx
80104bb4:	84 d2                	test   %dl,%dl
80104bb6:	75 e8                	jne    80104ba0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104bb8:	0f b6 c2             	movzbl %dl,%eax
80104bbb:	29 d8                	sub    %ebx,%eax
}
80104bbd:	5b                   	pop    %ebx
80104bbe:	5e                   	pop    %esi
80104bbf:	5d                   	pop    %ebp
80104bc0:	c3                   	ret    
80104bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bc8:	5b                   	pop    %ebx
    return 0;
80104bc9:	31 c0                	xor    %eax,%eax
}
80104bcb:	5e                   	pop    %esi
80104bcc:	5d                   	pop    %ebp
80104bcd:	c3                   	ret    
80104bce:	66 90                	xchg   %ax,%ax

80104bd0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	57                   	push   %edi
80104bd4:	56                   	push   %esi
80104bd5:	8b 75 08             	mov    0x8(%ebp),%esi
80104bd8:	53                   	push   %ebx
80104bd9:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104bdc:	89 f2                	mov    %esi,%edx
80104bde:	eb 17                	jmp    80104bf7 <strncpy+0x27>
80104be0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104be4:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104be7:	83 c2 01             	add    $0x1,%edx
80104bea:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104bee:	89 f9                	mov    %edi,%ecx
80104bf0:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bf3:	84 c9                	test   %cl,%cl
80104bf5:	74 09                	je     80104c00 <strncpy+0x30>
80104bf7:	89 c3                	mov    %eax,%ebx
80104bf9:	83 e8 01             	sub    $0x1,%eax
80104bfc:	85 db                	test   %ebx,%ebx
80104bfe:	7f e0                	jg     80104be0 <strncpy+0x10>
    ;
  while(n-- > 0)
80104c00:	89 d1                	mov    %edx,%ecx
80104c02:	85 c0                	test   %eax,%eax
80104c04:	7e 1d                	jle    80104c23 <strncpy+0x53>
80104c06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c0d:	8d 76 00             	lea    0x0(%esi),%esi
    *s++ = 0;
80104c10:	83 c1 01             	add    $0x1,%ecx
80104c13:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80104c17:	89 c8                	mov    %ecx,%eax
80104c19:	f7 d0                	not    %eax
80104c1b:	01 d0                	add    %edx,%eax
80104c1d:	01 d8                	add    %ebx,%eax
80104c1f:	85 c0                	test   %eax,%eax
80104c21:	7f ed                	jg     80104c10 <strncpy+0x40>
  return os;
}
80104c23:	5b                   	pop    %ebx
80104c24:	89 f0                	mov    %esi,%eax
80104c26:	5e                   	pop    %esi
80104c27:	5f                   	pop    %edi
80104c28:	5d                   	pop    %ebp
80104c29:	c3                   	ret    
80104c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c30 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	56                   	push   %esi
80104c34:	8b 55 10             	mov    0x10(%ebp),%edx
80104c37:	8b 75 08             	mov    0x8(%ebp),%esi
80104c3a:	53                   	push   %ebx
80104c3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104c3e:	85 d2                	test   %edx,%edx
80104c40:	7e 25                	jle    80104c67 <safestrcpy+0x37>
80104c42:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104c46:	89 f2                	mov    %esi,%edx
80104c48:	eb 16                	jmp    80104c60 <safestrcpy+0x30>
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104c50:	0f b6 08             	movzbl (%eax),%ecx
80104c53:	83 c0 01             	add    $0x1,%eax
80104c56:	83 c2 01             	add    $0x1,%edx
80104c59:	88 4a ff             	mov    %cl,-0x1(%edx)
80104c5c:	84 c9                	test   %cl,%cl
80104c5e:	74 04                	je     80104c64 <safestrcpy+0x34>
80104c60:	39 d8                	cmp    %ebx,%eax
80104c62:	75 ec                	jne    80104c50 <safestrcpy+0x20>
    ;
  *s = 0;
80104c64:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104c67:	89 f0                	mov    %esi,%eax
80104c69:	5b                   	pop    %ebx
80104c6a:	5e                   	pop    %esi
80104c6b:	5d                   	pop    %ebp
80104c6c:	c3                   	ret    
80104c6d:	8d 76 00             	lea    0x0(%esi),%esi

80104c70 <strlen>:

int
strlen(const char *s)
{
80104c70:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c71:	31 c0                	xor    %eax,%eax
{
80104c73:	89 e5                	mov    %esp,%ebp
80104c75:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104c78:	80 3a 00             	cmpb   $0x0,(%edx)
80104c7b:	74 0c                	je     80104c89 <strlen+0x19>
80104c7d:	8d 76 00             	lea    0x0(%esi),%esi
80104c80:	83 c0 01             	add    $0x1,%eax
80104c83:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c87:	75 f7                	jne    80104c80 <strlen+0x10>
    ;
  return n;
}
80104c89:	5d                   	pop    %ebp
80104c8a:	c3                   	ret    

80104c8b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c8b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c8f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104c93:	55                   	push   %ebp
  pushl %ebx
80104c94:	53                   	push   %ebx
  pushl %esi
80104c95:	56                   	push   %esi
  pushl %edi
80104c96:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c97:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c99:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80104c9b:	5f                   	pop    %edi
  popl %esi
80104c9c:	5e                   	pop    %esi
  popl %ebx
80104c9d:	5b                   	pop    %ebx
  popl %ebp
80104c9e:	5d                   	pop    %ebp
  ret
80104c9f:	c3                   	ret    

80104ca0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104ca0:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104ca1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104ca8:	8b 12                	mov    (%edx),%edx
{
80104caa:	89 e5                	mov    %esp,%ebp
80104cac:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80104caf:	39 c2                	cmp    %eax,%edx
80104cb1:	76 15                	jbe    80104cc8 <fetchint+0x28>
80104cb3:	8d 48 04             	lea    0x4(%eax),%ecx
80104cb6:	39 ca                	cmp    %ecx,%edx
80104cb8:	72 0e                	jb     80104cc8 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
80104cba:	8b 10                	mov    (%eax),%edx
80104cbc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cbf:	89 10                	mov    %edx,(%eax)
  return 0;
80104cc1:	31 c0                	xor    %eax,%eax
}
80104cc3:	5d                   	pop    %ebp
80104cc4:	c3                   	ret    
80104cc5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104cc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ccd:	5d                   	pop    %ebp
80104cce:	c3                   	ret    
80104ccf:	90                   	nop

80104cd0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104cd0:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104cd1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80104cd7:	89 e5                	mov    %esp,%ebp
80104cd9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
80104cdc:	39 08                	cmp    %ecx,(%eax)
80104cde:	76 30                	jbe    80104d10 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ce3:	89 08                	mov    %ecx,(%eax)
  ep = (char*)proc->sz;
80104ce5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ceb:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++)
80104ced:	39 d1                	cmp    %edx,%ecx
80104cef:	73 1f                	jae    80104d10 <fetchstr+0x40>
80104cf1:	89 c8                	mov    %ecx,%eax
80104cf3:	eb 0a                	jmp    80104cff <fetchstr+0x2f>
80104cf5:	8d 76 00             	lea    0x0(%esi),%esi
80104cf8:	83 c0 01             	add    $0x1,%eax
80104cfb:	39 c2                	cmp    %eax,%edx
80104cfd:	76 11                	jbe    80104d10 <fetchstr+0x40>
    if(*s == 0)
80104cff:	80 38 00             	cmpb   $0x0,(%eax)
80104d02:	75 f4                	jne    80104cf8 <fetchstr+0x28>
      return s - *pp;
80104d04:	29 c8                	sub    %ecx,%eax
  return -1;
}
80104d06:	5d                   	pop    %ebp
80104d07:	c3                   	ret    
80104d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0f:	90                   	nop
    return -1;
80104d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d15:	5d                   	pop    %ebp
80104d16:	c3                   	ret    
80104d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104d20:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104d21:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104d28:	8b 42 18             	mov    0x18(%edx),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80104d2b:	8b 12                	mov    (%edx),%edx
{
80104d2d:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104d2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d32:	8b 40 44             	mov    0x44(%eax),%eax
80104d35:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104d38:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104d3b:	39 d1                	cmp    %edx,%ecx
80104d3d:	73 19                	jae    80104d58 <argint+0x38>
80104d3f:	8d 48 08             	lea    0x8(%eax),%ecx
80104d42:	39 ca                	cmp    %ecx,%edx
80104d44:	72 12                	jb     80104d58 <argint+0x38>
  *ip = *(int*)(addr);
80104d46:	8b 50 04             	mov    0x4(%eax),%edx
80104d49:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d4c:	89 10                	mov    %edx,(%eax)
  return 0;
80104d4e:	31 c0                	xor    %eax,%eax
}
80104d50:	5d                   	pop    %ebp
80104d51:	c3                   	ret    
80104d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104d58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d5d:	5d                   	pop    %ebp
80104d5e:	c3                   	ret    
80104d5f:	90                   	nop

80104d60 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d60:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104d61:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d67:	8b 50 18             	mov    0x18(%eax),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104d6a:	8b 00                	mov    (%eax),%eax
{
80104d6c:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104d6e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d71:	8b 52 44             	mov    0x44(%edx),%edx
80104d74:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104d77:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104d7a:	39 c1                	cmp    %eax,%ecx
80104d7c:	73 22                	jae    80104da0 <argptr+0x40>
80104d7e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104d81:	39 c8                	cmp    %ecx,%eax
80104d83:	72 1b                	jb     80104da0 <argptr+0x40>
  *ip = *(int*)(addr);
80104d85:	8b 52 04             	mov    0x4(%edx),%edx
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80104d88:	39 c2                	cmp    %eax,%edx
80104d8a:	73 14                	jae    80104da0 <argptr+0x40>
80104d8c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d8f:	01 d1                	add    %edx,%ecx
80104d91:	39 c1                	cmp    %eax,%ecx
80104d93:	77 0b                	ja     80104da0 <argptr+0x40>
    return -1;
  *pp = (char*)i;
80104d95:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d98:	89 10                	mov    %edx,(%eax)
  return 0;
80104d9a:	31 c0                	xor    %eax,%eax
}
80104d9c:	5d                   	pop    %ebp
80104d9d:	c3                   	ret    
80104d9e:	66 90                	xchg   %ax,%ax
    return -1;
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104da5:	5d                   	pop    %ebp
80104da6:	c3                   	ret    
80104da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dae:	66 90                	xchg   %ax,%ax

80104db0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104db0:	55                   	push   %ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104db1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104db7:	8b 50 18             	mov    0x18(%eax),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104dba:	8b 00                	mov    (%eax),%eax
{
80104dbc:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104dbe:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104dc1:	8b 52 44             	mov    0x44(%edx),%edx
80104dc4:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104dc7:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
80104dca:	39 c1                	cmp    %eax,%ecx
80104dcc:	73 42                	jae    80104e10 <argstr+0x60>
80104dce:	8d 4a 08             	lea    0x8(%edx),%ecx
80104dd1:	39 c8                	cmp    %ecx,%eax
80104dd3:	72 3b                	jb     80104e10 <argstr+0x60>
  *ip = *(int*)(addr);
80104dd5:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
80104dd8:	39 c1                	cmp    %eax,%ecx
80104dda:	73 34                	jae    80104e10 <argstr+0x60>
  *pp = (char*)addr;
80104ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ddf:	89 08                	mov    %ecx,(%eax)
  ep = (char*)proc->sz;
80104de1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104de7:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++)
80104de9:	39 d1                	cmp    %edx,%ecx
80104deb:	73 23                	jae    80104e10 <argstr+0x60>
80104ded:	89 c8                	mov    %ecx,%eax
80104def:	eb 0e                	jmp    80104dff <argstr+0x4f>
80104df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104df8:	83 c0 01             	add    $0x1,%eax
80104dfb:	39 c2                	cmp    %eax,%edx
80104dfd:	76 11                	jbe    80104e10 <argstr+0x60>
    if(*s == 0)
80104dff:	80 38 00             	cmpb   $0x0,(%eax)
80104e02:	75 f4                	jne    80104df8 <argstr+0x48>
      return s - *pp;
80104e04:	29 c8                	sub    %ecx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104e06:	5d                   	pop    %ebp
80104e07:	c3                   	ret    
80104e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e0f:	90                   	nop
    return -1;
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e15:	5d                   	pop    %ebp
80104e16:	c3                   	ret    
80104e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e1e:	66 90                	xchg   %ax,%ax

80104e20 <syscall>:
[SYS_close]   "close",
};*/

void
syscall(void)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	83 ec 08             	sub    $0x8,%esp
  int num;

  num = proc->tf->eax;
80104e26:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104e2d:	8b 42 18             	mov    0x18(%edx),%eax
80104e30:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e33:	8d 48 ff             	lea    -0x1(%eax),%ecx
80104e36:	83 f9 1c             	cmp    $0x1c,%ecx
80104e39:	77 25                	ja     80104e60 <syscall+0x40>
80104e3b:	8b 0c 85 60 7d 10 80 	mov    -0x7fef82a0(,%eax,4),%ecx
80104e42:	85 c9                	test   %ecx,%ecx
80104e44:	74 1a                	je     80104e60 <syscall+0x40>
    proc->tf->eax = syscalls[num]();
80104e46:	ff d1                	call   *%ecx
80104e48:	89 c2                	mov    %eax,%edx
80104e4a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e50:	8b 40 18             	mov    0x18(%eax),%eax
80104e53:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104e56:	c9                   	leave  
80104e57:	c3                   	ret    
80104e58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e5f:	90                   	nop
    cprintf("%d %s: unknown sys call %d\n",
80104e60:	50                   	push   %eax
            proc->pid, proc->name, num);
80104e61:	8d 42 6c             	lea    0x6c(%edx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104e64:	50                   	push   %eax
80104e65:	ff 72 10             	pushl  0x10(%edx)
80104e68:	68 41 7d 10 80       	push   $0x80107d41
80104e6d:	e8 0e b8 ff ff       	call   80100680 <cprintf>
    proc->tf->eax = -1;
80104e72:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e78:	83 c4 10             	add    $0x10,%esp
80104e7b:	8b 40 18             	mov    0x18(%eax),%eax
80104e7e:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e85:	c9                   	leave  
80104e86:	c3                   	ret    
80104e87:	66 90                	xchg   %ax,%ax
80104e89:	66 90                	xchg   %ax,%ax
80104e8b:	66 90                	xchg   %ax,%ax
80104e8d:	66 90                	xchg   %ax,%ax
80104e8f:	90                   	nop

80104e90 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	57                   	push   %edi
80104e94:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104e95:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104e98:	53                   	push   %ebx
80104e99:	83 ec 44             	sub    $0x44,%esp
80104e9c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104e9f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104ea2:	57                   	push   %edi
80104ea3:	50                   	push   %eax
{
80104ea4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104ea7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104eaa:	e8 11 d3 ff ff       	call   801021c0 <nameiparent>
80104eaf:	83 c4 10             	add    $0x10,%esp
80104eb2:	85 c0                	test   %eax,%eax
80104eb4:	0f 84 46 01 00 00    	je     80105000 <create+0x170>
    return 0;
  ilock(dp);
80104eba:	83 ec 0c             	sub    $0xc,%esp
80104ebd:	89 c3                	mov    %eax,%ebx
80104ebf:	50                   	push   %eax
80104ec0:	e8 db c9 ff ff       	call   801018a0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104ec5:	83 c4 0c             	add    $0xc,%esp
80104ec8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104ecb:	50                   	push   %eax
80104ecc:	57                   	push   %edi
80104ecd:	53                   	push   %ebx
80104ece:	e8 0d cf ff ff       	call   80101de0 <dirlookup>
80104ed3:	83 c4 10             	add    $0x10,%esp
80104ed6:	89 c6                	mov    %eax,%esi
80104ed8:	85 c0                	test   %eax,%eax
80104eda:	74 54                	je     80104f30 <create+0xa0>
    iunlockput(dp);
80104edc:	83 ec 0c             	sub    $0xc,%esp
80104edf:	53                   	push   %ebx
80104ee0:	e8 2b cc ff ff       	call   80101b10 <iunlockput>
    ilock(ip);
80104ee5:	89 34 24             	mov    %esi,(%esp)
80104ee8:	e8 b3 c9 ff ff       	call   801018a0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104eed:	83 c4 10             	add    $0x10,%esp
80104ef0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104ef5:	75 19                	jne    80104f10 <create+0x80>
80104ef7:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104efc:	75 12                	jne    80104f10 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104efe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f01:	89 f0                	mov    %esi,%eax
80104f03:	5b                   	pop    %ebx
80104f04:	5e                   	pop    %esi
80104f05:	5f                   	pop    %edi
80104f06:	5d                   	pop    %ebp
80104f07:	c3                   	ret    
80104f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f0f:	90                   	nop
    iunlockput(ip);
80104f10:	83 ec 0c             	sub    $0xc,%esp
80104f13:	56                   	push   %esi
    return 0;
80104f14:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104f16:	e8 f5 cb ff ff       	call   80101b10 <iunlockput>
    return 0;
80104f1b:	83 c4 10             	add    $0x10,%esp
}
80104f1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f21:	89 f0                	mov    %esi,%eax
80104f23:	5b                   	pop    %ebx
80104f24:	5e                   	pop    %esi
80104f25:	5f                   	pop    %edi
80104f26:	5d                   	pop    %ebp
80104f27:	c3                   	ret    
80104f28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f2f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104f30:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104f34:	83 ec 08             	sub    $0x8,%esp
80104f37:	50                   	push   %eax
80104f38:	ff 33                	pushl  (%ebx)
80104f3a:	e8 f1 c7 ff ff       	call   80101730 <ialloc>
80104f3f:	83 c4 10             	add    $0x10,%esp
80104f42:	89 c6                	mov    %eax,%esi
80104f44:	85 c0                	test   %eax,%eax
80104f46:	0f 84 cd 00 00 00    	je     80105019 <create+0x189>
  ilock(ip);
80104f4c:	83 ec 0c             	sub    $0xc,%esp
80104f4f:	50                   	push   %eax
80104f50:	e8 4b c9 ff ff       	call   801018a0 <ilock>
  ip->major = major;
80104f55:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104f59:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104f5d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104f61:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104f65:	b8 01 00 00 00       	mov    $0x1,%eax
80104f6a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104f6e:	89 34 24             	mov    %esi,(%esp)
80104f71:	e8 7a c8 ff ff       	call   801017f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f76:	83 c4 10             	add    $0x10,%esp
80104f79:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104f7e:	74 30                	je     80104fb0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104f80:	83 ec 04             	sub    $0x4,%esp
80104f83:	ff 76 04             	pushl  0x4(%esi)
80104f86:	57                   	push   %edi
80104f87:	53                   	push   %ebx
80104f88:	e8 53 d1 ff ff       	call   801020e0 <dirlink>
80104f8d:	83 c4 10             	add    $0x10,%esp
80104f90:	85 c0                	test   %eax,%eax
80104f92:	78 78                	js     8010500c <create+0x17c>
  iunlockput(dp);
80104f94:	83 ec 0c             	sub    $0xc,%esp
80104f97:	53                   	push   %ebx
80104f98:	e8 73 cb ff ff       	call   80101b10 <iunlockput>
  return ip;
80104f9d:	83 c4 10             	add    $0x10,%esp
}
80104fa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fa3:	89 f0                	mov    %esi,%eax
80104fa5:	5b                   	pop    %ebx
80104fa6:	5e                   	pop    %esi
80104fa7:	5f                   	pop    %edi
80104fa8:	5d                   	pop    %ebp
80104fa9:	c3                   	ret    
80104faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104fb0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104fb3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104fb8:	53                   	push   %ebx
80104fb9:	e8 32 c8 ff ff       	call   801017f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104fbe:	83 c4 0c             	add    $0xc,%esp
80104fc1:	ff 76 04             	pushl  0x4(%esi)
80104fc4:	68 f4 7d 10 80       	push   $0x80107df4
80104fc9:	56                   	push   %esi
80104fca:	e8 11 d1 ff ff       	call   801020e0 <dirlink>
80104fcf:	83 c4 10             	add    $0x10,%esp
80104fd2:	85 c0                	test   %eax,%eax
80104fd4:	78 18                	js     80104fee <create+0x15e>
80104fd6:	83 ec 04             	sub    $0x4,%esp
80104fd9:	ff 73 04             	pushl  0x4(%ebx)
80104fdc:	68 f3 7d 10 80       	push   $0x80107df3
80104fe1:	56                   	push   %esi
80104fe2:	e8 f9 d0 ff ff       	call   801020e0 <dirlink>
80104fe7:	83 c4 10             	add    $0x10,%esp
80104fea:	85 c0                	test   %eax,%eax
80104fec:	79 92                	jns    80104f80 <create+0xf0>
      panic("create dots");
80104fee:	83 ec 0c             	sub    $0xc,%esp
80104ff1:	68 e7 7d 10 80       	push   $0x80107de7
80104ff6:	e8 85 b3 ff ff       	call   80100380 <panic>
80104ffb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fff:	90                   	nop
}
80105000:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105003:	31 f6                	xor    %esi,%esi
}
80105005:	5b                   	pop    %ebx
80105006:	89 f0                	mov    %esi,%eax
80105008:	5e                   	pop    %esi
80105009:	5f                   	pop    %edi
8010500a:	5d                   	pop    %ebp
8010500b:	c3                   	ret    
    panic("create: dirlink");
8010500c:	83 ec 0c             	sub    $0xc,%esp
8010500f:	68 f6 7d 10 80       	push   $0x80107df6
80105014:	e8 67 b3 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105019:	83 ec 0c             	sub    $0xc,%esp
8010501c:	68 d8 7d 10 80       	push   $0x80107dd8
80105021:	e8 5a b3 ff ff       	call   80100380 <panic>
80105026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010502d:	8d 76 00             	lea    0x0(%esi),%esi

80105030 <sys_dup>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105034:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105037:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(n, &fd) < 0)
8010503a:	50                   	push   %eax
8010503b:	6a 00                	push   $0x0
8010503d:	e8 de fc ff ff       	call   80104d20 <argint>
80105042:	83 c4 10             	add    $0x10,%esp
80105045:	85 c0                	test   %eax,%eax
80105047:	78 2f                	js     80105078 <sys_dup+0x48>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105049:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010504c:	83 fa 0f             	cmp    $0xf,%edx
8010504f:	77 27                	ja     80105078 <sys_dup+0x48>
80105051:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105057:	8b 54 90 28          	mov    0x28(%eax,%edx,4),%edx
8010505b:	85 d2                	test   %edx,%edx
8010505d:	74 19                	je     80105078 <sys_dup+0x48>
  for(fd = 0; fd < NOFILE; fd++){
8010505f:	31 db                	xor    %ebx,%ebx
80105061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
80105068:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
8010506c:	85 c9                	test   %ecx,%ecx
8010506e:	74 18                	je     80105088 <sys_dup+0x58>
  for(fd = 0; fd < NOFILE; fd++){
80105070:	83 c3 01             	add    $0x1,%ebx
80105073:	83 fb 10             	cmp    $0x10,%ebx
80105076:	75 f0                	jne    80105068 <sys_dup+0x38>
    return -1;
80105078:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
8010507d:	89 d8                	mov    %ebx,%eax
8010507f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105082:	c9                   	leave  
80105083:	c3                   	ret    
80105084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  filedup(f);
80105088:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
8010508b:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)
  filedup(f);
8010508f:	52                   	push   %edx
80105090:	e8 1b bf ff ff       	call   80100fb0 <filedup>
}
80105095:	89 d8                	mov    %ebx,%eax
  return fd;
80105097:	83 c4 10             	add    $0x10,%esp
}
8010509a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010509d:	c9                   	leave  
8010509e:	c3                   	ret    
8010509f:	90                   	nop

801050a0 <sys_read>:
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	56                   	push   %esi
801050a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801050a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801050a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050ab:	53                   	push   %ebx
801050ac:	6a 00                	push   $0x0
801050ae:	e8 6d fc ff ff       	call   80104d20 <argint>
801050b3:	83 c4 10             	add    $0x10,%esp
801050b6:	85 c0                	test   %eax,%eax
801050b8:	78 5e                	js     80105118 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801050ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050bd:	83 f8 0f             	cmp    $0xf,%eax
801050c0:	77 56                	ja     80105118 <sys_read+0x78>
801050c2:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801050c9:	8b 74 82 28          	mov    0x28(%edx,%eax,4),%esi
801050cd:	85 f6                	test   %esi,%esi
801050cf:	74 47                	je     80105118 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050d1:	83 ec 08             	sub    $0x8,%esp
801050d4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050d7:	50                   	push   %eax
801050d8:	6a 02                	push   $0x2
801050da:	e8 41 fc ff ff       	call   80104d20 <argint>
801050df:	83 c4 10             	add    $0x10,%esp
801050e2:	85 c0                	test   %eax,%eax
801050e4:	78 32                	js     80105118 <sys_read+0x78>
801050e6:	83 ec 04             	sub    $0x4,%esp
801050e9:	ff 75 f0             	pushl  -0x10(%ebp)
801050ec:	53                   	push   %ebx
801050ed:	6a 01                	push   $0x1
801050ef:	e8 6c fc ff ff       	call   80104d60 <argptr>
801050f4:	83 c4 10             	add    $0x10,%esp
801050f7:	85 c0                	test   %eax,%eax
801050f9:	78 1d                	js     80105118 <sys_read+0x78>
  return fileread(f, p, n);
801050fb:	83 ec 04             	sub    $0x4,%esp
801050fe:	ff 75 f0             	pushl  -0x10(%ebp)
80105101:	ff 75 f4             	pushl  -0xc(%ebp)
80105104:	56                   	push   %esi
80105105:	e8 26 c0 ff ff       	call   80101130 <fileread>
8010510a:	83 c4 10             	add    $0x10,%esp
}
8010510d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105110:	5b                   	pop    %ebx
80105111:	5e                   	pop    %esi
80105112:	5d                   	pop    %ebp
80105113:	c3                   	ret    
80105114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105118:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010511d:	eb ee                	jmp    8010510d <sys_read+0x6d>
8010511f:	90                   	nop

80105120 <sys_write>:
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	56                   	push   %esi
80105124:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105125:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105128:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010512b:	53                   	push   %ebx
8010512c:	6a 00                	push   $0x0
8010512e:	e8 ed fb ff ff       	call   80104d20 <argint>
80105133:	83 c4 10             	add    $0x10,%esp
80105136:	85 c0                	test   %eax,%eax
80105138:	78 5e                	js     80105198 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010513a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010513d:	83 f8 0f             	cmp    $0xf,%eax
80105140:	77 56                	ja     80105198 <sys_write+0x78>
80105142:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105149:	8b 74 82 28          	mov    0x28(%edx,%eax,4),%esi
8010514d:	85 f6                	test   %esi,%esi
8010514f:	74 47                	je     80105198 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105151:	83 ec 08             	sub    $0x8,%esp
80105154:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105157:	50                   	push   %eax
80105158:	6a 02                	push   $0x2
8010515a:	e8 c1 fb ff ff       	call   80104d20 <argint>
8010515f:	83 c4 10             	add    $0x10,%esp
80105162:	85 c0                	test   %eax,%eax
80105164:	78 32                	js     80105198 <sys_write+0x78>
80105166:	83 ec 04             	sub    $0x4,%esp
80105169:	ff 75 f0             	pushl  -0x10(%ebp)
8010516c:	53                   	push   %ebx
8010516d:	6a 01                	push   $0x1
8010516f:	e8 ec fb ff ff       	call   80104d60 <argptr>
80105174:	83 c4 10             	add    $0x10,%esp
80105177:	85 c0                	test   %eax,%eax
80105179:	78 1d                	js     80105198 <sys_write+0x78>
  return filewrite(f, p, n);
8010517b:	83 ec 04             	sub    $0x4,%esp
8010517e:	ff 75 f0             	pushl  -0x10(%ebp)
80105181:	ff 75 f4             	pushl  -0xc(%ebp)
80105184:	56                   	push   %esi
80105185:	e8 36 c0 ff ff       	call   801011c0 <filewrite>
8010518a:	83 c4 10             	add    $0x10,%esp
}
8010518d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105190:	5b                   	pop    %ebx
80105191:	5e                   	pop    %esi
80105192:	5d                   	pop    %ebp
80105193:	c3                   	ret    
80105194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105198:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010519d:	eb ee                	jmp    8010518d <sys_write+0x6d>
8010519f:	90                   	nop

801051a0 <sys_close>:
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
801051a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051a9:	50                   	push   %eax
801051aa:	6a 00                	push   $0x0
801051ac:	e8 6f fb ff ff       	call   80104d20 <argint>
801051b1:	83 c4 10             	add    $0x10,%esp
801051b4:	85 c0                	test   %eax,%eax
801051b6:	78 38                	js     801051f0 <sys_close+0x50>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801051b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051bb:	83 f8 0f             	cmp    $0xf,%eax
801051be:	77 30                	ja     801051f0 <sys_close+0x50>
801051c0:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
801051c7:	83 c0 08             	add    $0x8,%eax
801051ca:	8b 54 81 08          	mov    0x8(%ecx,%eax,4),%edx
801051ce:	85 d2                	test   %edx,%edx
801051d0:	74 1e                	je     801051f0 <sys_close+0x50>
  fileclose(f);
801051d2:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
801051d5:	c7 44 81 08 00 00 00 	movl   $0x0,0x8(%ecx,%eax,4)
801051dc:	00 
  fileclose(f);
801051dd:	52                   	push   %edx
801051de:	e8 1d be ff ff       	call   80101000 <fileclose>
  return 0;
801051e3:	83 c4 10             	add    $0x10,%esp
801051e6:	31 c0                	xor    %eax,%eax
}
801051e8:	c9                   	leave  
801051e9:	c3                   	ret    
801051ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051f0:	c9                   	leave  
    return -1;
801051f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051f6:	c3                   	ret    
801051f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051fe:	66 90                	xchg   %ax,%ax

80105200 <sys_fstat>:
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	56                   	push   %esi
80105204:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105205:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105208:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010520b:	53                   	push   %ebx
8010520c:	6a 00                	push   $0x0
8010520e:	e8 0d fb ff ff       	call   80104d20 <argint>
80105213:	83 c4 10             	add    $0x10,%esp
80105216:	85 c0                	test   %eax,%eax
80105218:	78 46                	js     80105260 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010521a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010521d:	83 f8 0f             	cmp    $0xf,%eax
80105220:	77 3e                	ja     80105260 <sys_fstat+0x60>
80105222:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105229:	8b 74 82 28          	mov    0x28(%edx,%eax,4),%esi
8010522d:	85 f6                	test   %esi,%esi
8010522f:	74 2f                	je     80105260 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105231:	83 ec 04             	sub    $0x4,%esp
80105234:	6a 14                	push   $0x14
80105236:	53                   	push   %ebx
80105237:	6a 01                	push   $0x1
80105239:	e8 22 fb ff ff       	call   80104d60 <argptr>
8010523e:	83 c4 10             	add    $0x10,%esp
80105241:	85 c0                	test   %eax,%eax
80105243:	78 1b                	js     80105260 <sys_fstat+0x60>
  return filestat(f, st);
80105245:	83 ec 08             	sub    $0x8,%esp
80105248:	ff 75 f4             	pushl  -0xc(%ebp)
8010524b:	56                   	push   %esi
8010524c:	e8 8f be ff ff       	call   801010e0 <filestat>
80105251:	83 c4 10             	add    $0x10,%esp
}
80105254:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105257:	5b                   	pop    %ebx
80105258:	5e                   	pop    %esi
80105259:	5d                   	pop    %ebp
8010525a:	c3                   	ret    
8010525b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010525f:	90                   	nop
    return -1;
80105260:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105265:	eb ed                	jmp    80105254 <sys_fstat+0x54>
80105267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526e:	66 90                	xchg   %ax,%ax

80105270 <sys_link>:
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	57                   	push   %edi
80105274:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105275:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105278:	53                   	push   %ebx
80105279:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010527c:	50                   	push   %eax
8010527d:	6a 00                	push   $0x0
8010527f:	e8 2c fb ff ff       	call   80104db0 <argstr>
80105284:	83 c4 10             	add    $0x10,%esp
80105287:	85 c0                	test   %eax,%eax
80105289:	0f 88 fb 00 00 00    	js     8010538a <sys_link+0x11a>
8010528f:	83 ec 08             	sub    $0x8,%esp
80105292:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105295:	50                   	push   %eax
80105296:	6a 01                	push   $0x1
80105298:	e8 13 fb ff ff       	call   80104db0 <argstr>
8010529d:	83 c4 10             	add    $0x10,%esp
801052a0:	85 c0                	test   %eax,%eax
801052a2:	0f 88 e2 00 00 00    	js     8010538a <sys_link+0x11a>
  begin_op();
801052a8:	e8 53 dc ff ff       	call   80102f00 <begin_op>
  if((ip = namei(old)) == 0){
801052ad:	83 ec 0c             	sub    $0xc,%esp
801052b0:	ff 75 d4             	pushl  -0x2c(%ebp)
801052b3:	e8 e8 ce ff ff       	call   801021a0 <namei>
801052b8:	83 c4 10             	add    $0x10,%esp
801052bb:	89 c3                	mov    %eax,%ebx
801052bd:	85 c0                	test   %eax,%eax
801052bf:	0f 84 e4 00 00 00    	je     801053a9 <sys_link+0x139>
  ilock(ip);
801052c5:	83 ec 0c             	sub    $0xc,%esp
801052c8:	50                   	push   %eax
801052c9:	e8 d2 c5 ff ff       	call   801018a0 <ilock>
  if(ip->type == T_DIR){
801052ce:	83 c4 10             	add    $0x10,%esp
801052d1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052d6:	0f 84 b5 00 00 00    	je     80105391 <sys_link+0x121>
  iupdate(ip);
801052dc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801052df:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801052e4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801052e7:	53                   	push   %ebx
801052e8:	e8 03 c5 ff ff       	call   801017f0 <iupdate>
  iunlock(ip);
801052ed:	89 1c 24             	mov    %ebx,(%esp)
801052f0:	e8 8b c6 ff ff       	call   80101980 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801052f5:	58                   	pop    %eax
801052f6:	5a                   	pop    %edx
801052f7:	57                   	push   %edi
801052f8:	ff 75 d0             	pushl  -0x30(%ebp)
801052fb:	e8 c0 ce ff ff       	call   801021c0 <nameiparent>
80105300:	83 c4 10             	add    $0x10,%esp
80105303:	89 c6                	mov    %eax,%esi
80105305:	85 c0                	test   %eax,%eax
80105307:	74 5b                	je     80105364 <sys_link+0xf4>
  ilock(dp);
80105309:	83 ec 0c             	sub    $0xc,%esp
8010530c:	50                   	push   %eax
8010530d:	e8 8e c5 ff ff       	call   801018a0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105312:	8b 03                	mov    (%ebx),%eax
80105314:	83 c4 10             	add    $0x10,%esp
80105317:	39 06                	cmp    %eax,(%esi)
80105319:	75 3d                	jne    80105358 <sys_link+0xe8>
8010531b:	83 ec 04             	sub    $0x4,%esp
8010531e:	ff 73 04             	pushl  0x4(%ebx)
80105321:	57                   	push   %edi
80105322:	56                   	push   %esi
80105323:	e8 b8 cd ff ff       	call   801020e0 <dirlink>
80105328:	83 c4 10             	add    $0x10,%esp
8010532b:	85 c0                	test   %eax,%eax
8010532d:	78 29                	js     80105358 <sys_link+0xe8>
  iunlockput(dp);
8010532f:	83 ec 0c             	sub    $0xc,%esp
80105332:	56                   	push   %esi
80105333:	e8 d8 c7 ff ff       	call   80101b10 <iunlockput>
  iput(ip);
80105338:	89 1c 24             	mov    %ebx,(%esp)
8010533b:	e8 90 c6 ff ff       	call   801019d0 <iput>
  end_op();
80105340:	e8 2b dc ff ff       	call   80102f70 <end_op>
  return 0;
80105345:	83 c4 10             	add    $0x10,%esp
80105348:	31 c0                	xor    %eax,%eax
}
8010534a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010534d:	5b                   	pop    %ebx
8010534e:	5e                   	pop    %esi
8010534f:	5f                   	pop    %edi
80105350:	5d                   	pop    %ebp
80105351:	c3                   	ret    
80105352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105358:	83 ec 0c             	sub    $0xc,%esp
8010535b:	56                   	push   %esi
8010535c:	e8 af c7 ff ff       	call   80101b10 <iunlockput>
    goto bad;
80105361:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105364:	83 ec 0c             	sub    $0xc,%esp
80105367:	53                   	push   %ebx
80105368:	e8 33 c5 ff ff       	call   801018a0 <ilock>
  ip->nlink--;
8010536d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105372:	89 1c 24             	mov    %ebx,(%esp)
80105375:	e8 76 c4 ff ff       	call   801017f0 <iupdate>
  iunlockput(ip);
8010537a:	89 1c 24             	mov    %ebx,(%esp)
8010537d:	e8 8e c7 ff ff       	call   80101b10 <iunlockput>
  end_op();
80105382:	e8 e9 db ff ff       	call   80102f70 <end_op>
  return -1;
80105387:	83 c4 10             	add    $0x10,%esp
8010538a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010538f:	eb b9                	jmp    8010534a <sys_link+0xda>
    iunlockput(ip);
80105391:	83 ec 0c             	sub    $0xc,%esp
80105394:	53                   	push   %ebx
80105395:	e8 76 c7 ff ff       	call   80101b10 <iunlockput>
    end_op();
8010539a:	e8 d1 db ff ff       	call   80102f70 <end_op>
    return -1;
8010539f:	83 c4 10             	add    $0x10,%esp
801053a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053a7:	eb a1                	jmp    8010534a <sys_link+0xda>
    end_op();
801053a9:	e8 c2 db ff ff       	call   80102f70 <end_op>
    return -1;
801053ae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053b3:	eb 95                	jmp    8010534a <sys_link+0xda>
801053b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053c0 <sys_unlink>:
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	57                   	push   %edi
801053c4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801053c5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801053c8:	53                   	push   %ebx
801053c9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801053cc:	50                   	push   %eax
801053cd:	6a 00                	push   $0x0
801053cf:	e8 dc f9 ff ff       	call   80104db0 <argstr>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	0f 88 7a 01 00 00    	js     80105559 <sys_unlink+0x199>
  begin_op();
801053df:	e8 1c db ff ff       	call   80102f00 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801053e4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801053e7:	83 ec 08             	sub    $0x8,%esp
801053ea:	53                   	push   %ebx
801053eb:	ff 75 c0             	pushl  -0x40(%ebp)
801053ee:	e8 cd cd ff ff       	call   801021c0 <nameiparent>
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801053f9:	85 c0                	test   %eax,%eax
801053fb:	0f 84 62 01 00 00    	je     80105563 <sys_unlink+0x1a3>
  ilock(dp);
80105401:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105404:	83 ec 0c             	sub    $0xc,%esp
80105407:	57                   	push   %edi
80105408:	e8 93 c4 ff ff       	call   801018a0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010540d:	58                   	pop    %eax
8010540e:	5a                   	pop    %edx
8010540f:	68 f4 7d 10 80       	push   $0x80107df4
80105414:	53                   	push   %ebx
80105415:	e8 a6 c9 ff ff       	call   80101dc0 <namecmp>
8010541a:	83 c4 10             	add    $0x10,%esp
8010541d:	85 c0                	test   %eax,%eax
8010541f:	0f 84 fb 00 00 00    	je     80105520 <sys_unlink+0x160>
80105425:	83 ec 08             	sub    $0x8,%esp
80105428:	68 f3 7d 10 80       	push   $0x80107df3
8010542d:	53                   	push   %ebx
8010542e:	e8 8d c9 ff ff       	call   80101dc0 <namecmp>
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	0f 84 e2 00 00 00    	je     80105520 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010543e:	83 ec 04             	sub    $0x4,%esp
80105441:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105444:	50                   	push   %eax
80105445:	53                   	push   %ebx
80105446:	57                   	push   %edi
80105447:	e8 94 c9 ff ff       	call   80101de0 <dirlookup>
8010544c:	83 c4 10             	add    $0x10,%esp
8010544f:	89 c3                	mov    %eax,%ebx
80105451:	85 c0                	test   %eax,%eax
80105453:	0f 84 c7 00 00 00    	je     80105520 <sys_unlink+0x160>
  ilock(ip);
80105459:	83 ec 0c             	sub    $0xc,%esp
8010545c:	50                   	push   %eax
8010545d:	e8 3e c4 ff ff       	call   801018a0 <ilock>
  if(ip->nlink < 1)
80105462:	83 c4 10             	add    $0x10,%esp
80105465:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010546a:	0f 8e 1c 01 00 00    	jle    8010558c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105470:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105475:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105478:	74 66                	je     801054e0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010547a:	83 ec 04             	sub    $0x4,%esp
8010547d:	6a 10                	push   $0x10
8010547f:	6a 00                	push   $0x0
80105481:	57                   	push   %edi
80105482:	e8 e9 f5 ff ff       	call   80104a70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105487:	6a 10                	push   $0x10
80105489:	ff 75 c4             	pushl  -0x3c(%ebp)
8010548c:	57                   	push   %edi
8010548d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105490:	e8 fb c7 ff ff       	call   80101c90 <writei>
80105495:	83 c4 20             	add    $0x20,%esp
80105498:	83 f8 10             	cmp    $0x10,%eax
8010549b:	0f 85 de 00 00 00    	jne    8010557f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
801054a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801054a6:	0f 84 94 00 00 00    	je     80105540 <sys_unlink+0x180>
  iunlockput(dp);
801054ac:	83 ec 0c             	sub    $0xc,%esp
801054af:	ff 75 b4             	pushl  -0x4c(%ebp)
801054b2:	e8 59 c6 ff ff       	call   80101b10 <iunlockput>
  ip->nlink--;
801054b7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801054bc:	89 1c 24             	mov    %ebx,(%esp)
801054bf:	e8 2c c3 ff ff       	call   801017f0 <iupdate>
  iunlockput(ip);
801054c4:	89 1c 24             	mov    %ebx,(%esp)
801054c7:	e8 44 c6 ff ff       	call   80101b10 <iunlockput>
  end_op();
801054cc:	e8 9f da ff ff       	call   80102f70 <end_op>
  return 0;
801054d1:	83 c4 10             	add    $0x10,%esp
801054d4:	31 c0                	xor    %eax,%eax
}
801054d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054d9:	5b                   	pop    %ebx
801054da:	5e                   	pop    %esi
801054db:	5f                   	pop    %edi
801054dc:	5d                   	pop    %ebp
801054dd:	c3                   	ret    
801054de:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801054e0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801054e4:	76 94                	jbe    8010547a <sys_unlink+0xba>
801054e6:	be 20 00 00 00       	mov    $0x20,%esi
801054eb:	eb 0b                	jmp    801054f8 <sys_unlink+0x138>
801054ed:	8d 76 00             	lea    0x0(%esi),%esi
801054f0:	83 c6 10             	add    $0x10,%esi
801054f3:	3b 73 58             	cmp    0x58(%ebx),%esi
801054f6:	73 82                	jae    8010547a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054f8:	6a 10                	push   $0x10
801054fa:	56                   	push   %esi
801054fb:	57                   	push   %edi
801054fc:	53                   	push   %ebx
801054fd:	e8 8e c6 ff ff       	call   80101b90 <readi>
80105502:	83 c4 10             	add    $0x10,%esp
80105505:	83 f8 10             	cmp    $0x10,%eax
80105508:	75 68                	jne    80105572 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010550a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010550f:	74 df                	je     801054f0 <sys_unlink+0x130>
    iunlockput(ip);
80105511:	83 ec 0c             	sub    $0xc,%esp
80105514:	53                   	push   %ebx
80105515:	e8 f6 c5 ff ff       	call   80101b10 <iunlockput>
    goto bad;
8010551a:	83 c4 10             	add    $0x10,%esp
8010551d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105520:	83 ec 0c             	sub    $0xc,%esp
80105523:	ff 75 b4             	pushl  -0x4c(%ebp)
80105526:	e8 e5 c5 ff ff       	call   80101b10 <iunlockput>
  end_op();
8010552b:	e8 40 da ff ff       	call   80102f70 <end_op>
  return -1;
80105530:	83 c4 10             	add    $0x10,%esp
80105533:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105538:	eb 9c                	jmp    801054d6 <sys_unlink+0x116>
8010553a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105540:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105543:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105546:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010554b:	50                   	push   %eax
8010554c:	e8 9f c2 ff ff       	call   801017f0 <iupdate>
80105551:	83 c4 10             	add    $0x10,%esp
80105554:	e9 53 ff ff ff       	jmp    801054ac <sys_unlink+0xec>
    return -1;
80105559:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010555e:	e9 73 ff ff ff       	jmp    801054d6 <sys_unlink+0x116>
    end_op();
80105563:	e8 08 da ff ff       	call   80102f70 <end_op>
    return -1;
80105568:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010556d:	e9 64 ff ff ff       	jmp    801054d6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105572:	83 ec 0c             	sub    $0xc,%esp
80105575:	68 18 7e 10 80       	push   $0x80107e18
8010557a:	e8 01 ae ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010557f:	83 ec 0c             	sub    $0xc,%esp
80105582:	68 2a 7e 10 80       	push   $0x80107e2a
80105587:	e8 f4 ad ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010558c:	83 ec 0c             	sub    $0xc,%esp
8010558f:	68 06 7e 10 80       	push   $0x80107e06
80105594:	e8 e7 ad ff ff       	call   80100380 <panic>
80105599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801055a0 <sys_open>:

int
sys_open(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	57                   	push   %edi
801055a4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801055a5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801055a8:	53                   	push   %ebx
801055a9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801055ac:	50                   	push   %eax
801055ad:	6a 00                	push   $0x0
801055af:	e8 fc f7 ff ff       	call   80104db0 <argstr>
801055b4:	83 c4 10             	add    $0x10,%esp
801055b7:	85 c0                	test   %eax,%eax
801055b9:	0f 88 96 00 00 00    	js     80105655 <sys_open+0xb5>
801055bf:	83 ec 08             	sub    $0x8,%esp
801055c2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055c5:	50                   	push   %eax
801055c6:	6a 01                	push   $0x1
801055c8:	e8 53 f7 ff ff       	call   80104d20 <argint>
801055cd:	83 c4 10             	add    $0x10,%esp
801055d0:	85 c0                	test   %eax,%eax
801055d2:	0f 88 7d 00 00 00    	js     80105655 <sys_open+0xb5>
    return -1;

  begin_op();
801055d8:	e8 23 d9 ff ff       	call   80102f00 <begin_op>

  if(omode & O_CREATE){
801055dd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801055e1:	75 7d                	jne    80105660 <sys_open+0xc0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801055e3:	83 ec 0c             	sub    $0xc,%esp
801055e6:	ff 75 e0             	pushl  -0x20(%ebp)
801055e9:	e8 b2 cb ff ff       	call   801021a0 <namei>
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	89 c7                	mov    %eax,%edi
801055f3:	85 c0                	test   %eax,%eax
801055f5:	0f 84 82 00 00 00    	je     8010567d <sys_open+0xdd>
      end_op();
      return -1;
    }
    ilock(ip);
801055fb:	83 ec 0c             	sub    $0xc,%esp
801055fe:	50                   	push   %eax
801055ff:	e8 9c c2 ff ff       	call   801018a0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105604:	83 c4 10             	add    $0x10,%esp
80105607:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
8010560c:	0f 84 c6 00 00 00    	je     801056d8 <sys_open+0x138>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105612:	e8 29 b9 ff ff       	call   80100f40 <filealloc>
80105617:	89 c6                	mov    %eax,%esi
80105619:	85 c0                	test   %eax,%eax
8010561b:	74 27                	je     80105644 <sys_open+0xa4>
    if(proc->ofile[fd] == 0){
8010561d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
80105623:	31 db                	xor    %ebx,%ebx
80105625:	8d 76 00             	lea    0x0(%esi),%esi
    if(proc->ofile[fd] == 0){
80105628:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010562c:	85 d2                	test   %edx,%edx
8010562e:	74 60                	je     80105690 <sys_open+0xf0>
  for(fd = 0; fd < NOFILE; fd++){
80105630:	83 c3 01             	add    $0x1,%ebx
80105633:	83 fb 10             	cmp    $0x10,%ebx
80105636:	75 f0                	jne    80105628 <sys_open+0x88>
    if(f)
      fileclose(f);
80105638:	83 ec 0c             	sub    $0xc,%esp
8010563b:	56                   	push   %esi
8010563c:	e8 bf b9 ff ff       	call   80101000 <fileclose>
80105641:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105644:	83 ec 0c             	sub    $0xc,%esp
80105647:	57                   	push   %edi
80105648:	e8 c3 c4 ff ff       	call   80101b10 <iunlockput>
    end_op();
8010564d:	e8 1e d9 ff ff       	call   80102f70 <end_op>
    return -1;
80105652:	83 c4 10             	add    $0x10,%esp
80105655:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010565a:	eb 6d                	jmp    801056c9 <sys_open+0x129>
8010565c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105660:	83 ec 0c             	sub    $0xc,%esp
80105663:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105666:	31 c9                	xor    %ecx,%ecx
80105668:	ba 02 00 00 00       	mov    $0x2,%edx
8010566d:	6a 00                	push   $0x0
8010566f:	e8 1c f8 ff ff       	call   80104e90 <create>
    if(ip == 0){
80105674:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105677:	89 c7                	mov    %eax,%edi
    if(ip == 0){
80105679:	85 c0                	test   %eax,%eax
8010567b:	75 95                	jne    80105612 <sys_open+0x72>
      end_op();
8010567d:	e8 ee d8 ff ff       	call   80102f70 <end_op>
      return -1;
80105682:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105687:	eb 40                	jmp    801056c9 <sys_open+0x129>
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105690:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80105693:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105697:	57                   	push   %edi
80105698:	e8 e3 c2 ff ff       	call   80101980 <iunlock>
  end_op();
8010569d:	e8 ce d8 ff ff       	call   80102f70 <end_op>

  f->type = FD_INODE;
801056a2:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801056a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056ab:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801056ae:	89 7e 10             	mov    %edi,0x10(%esi)
  f->readable = !(omode & O_WRONLY);
801056b1:	89 d0                	mov    %edx,%eax
  f->off = 0;
801056b3:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
801056ba:	f7 d0                	not    %eax
801056bc:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056bf:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801056c2:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801056c5:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
}
801056c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056cc:	89 d8                	mov    %ebx,%eax
801056ce:	5b                   	pop    %ebx
801056cf:	5e                   	pop    %esi
801056d0:	5f                   	pop    %edi
801056d1:	5d                   	pop    %ebp
801056d2:	c3                   	ret    
801056d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056d7:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801056d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801056db:	85 c9                	test   %ecx,%ecx
801056dd:	0f 84 2f ff ff ff    	je     80105612 <sys_open+0x72>
801056e3:	e9 5c ff ff ff       	jmp    80105644 <sys_open+0xa4>
801056e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ef:	90                   	nop

801056f0 <sys_mkdir>:

int
sys_mkdir(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801056f6:	e8 05 d8 ff ff       	call   80102f00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801056fb:	83 ec 08             	sub    $0x8,%esp
801056fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105701:	50                   	push   %eax
80105702:	6a 00                	push   $0x0
80105704:	e8 a7 f6 ff ff       	call   80104db0 <argstr>
80105709:	83 c4 10             	add    $0x10,%esp
8010570c:	85 c0                	test   %eax,%eax
8010570e:	78 30                	js     80105740 <sys_mkdir+0x50>
80105710:	83 ec 0c             	sub    $0xc,%esp
80105713:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105716:	31 c9                	xor    %ecx,%ecx
80105718:	ba 01 00 00 00       	mov    $0x1,%edx
8010571d:	6a 00                	push   $0x0
8010571f:	e8 6c f7 ff ff       	call   80104e90 <create>
80105724:	83 c4 10             	add    $0x10,%esp
80105727:	85 c0                	test   %eax,%eax
80105729:	74 15                	je     80105740 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010572b:	83 ec 0c             	sub    $0xc,%esp
8010572e:	50                   	push   %eax
8010572f:	e8 dc c3 ff ff       	call   80101b10 <iunlockput>
  end_op();
80105734:	e8 37 d8 ff ff       	call   80102f70 <end_op>
  return 0;
80105739:	83 c4 10             	add    $0x10,%esp
8010573c:	31 c0                	xor    %eax,%eax
}
8010573e:	c9                   	leave  
8010573f:	c3                   	ret    
    end_op();
80105740:	e8 2b d8 ff ff       	call   80102f70 <end_op>
    return -1;
80105745:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010574a:	c9                   	leave  
8010574b:	c3                   	ret    
8010574c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105750 <sys_mknod>:

int
sys_mknod(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105756:	e8 a5 d7 ff ff       	call   80102f00 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010575b:	83 ec 08             	sub    $0x8,%esp
8010575e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105761:	50                   	push   %eax
80105762:	6a 00                	push   $0x0
80105764:	e8 47 f6 ff ff       	call   80104db0 <argstr>
80105769:	83 c4 10             	add    $0x10,%esp
8010576c:	85 c0                	test   %eax,%eax
8010576e:	78 60                	js     801057d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105770:	83 ec 08             	sub    $0x8,%esp
80105773:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105776:	50                   	push   %eax
80105777:	6a 01                	push   $0x1
80105779:	e8 a2 f5 ff ff       	call   80104d20 <argint>
  if((argstr(0, &path)) < 0 ||
8010577e:	83 c4 10             	add    $0x10,%esp
80105781:	85 c0                	test   %eax,%eax
80105783:	78 4b                	js     801057d0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105785:	83 ec 08             	sub    $0x8,%esp
80105788:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010578b:	50                   	push   %eax
8010578c:	6a 02                	push   $0x2
8010578e:	e8 8d f5 ff ff       	call   80104d20 <argint>
     argint(1, &major) < 0 ||
80105793:	83 c4 10             	add    $0x10,%esp
80105796:	85 c0                	test   %eax,%eax
80105798:	78 36                	js     801057d0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010579a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010579e:	83 ec 0c             	sub    $0xc,%esp
801057a1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801057a5:	ba 03 00 00 00       	mov    $0x3,%edx
801057aa:	50                   	push   %eax
801057ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801057ae:	e8 dd f6 ff ff       	call   80104e90 <create>
     argint(2, &minor) < 0 ||
801057b3:	83 c4 10             	add    $0x10,%esp
801057b6:	85 c0                	test   %eax,%eax
801057b8:	74 16                	je     801057d0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801057ba:	83 ec 0c             	sub    $0xc,%esp
801057bd:	50                   	push   %eax
801057be:	e8 4d c3 ff ff       	call   80101b10 <iunlockput>
  end_op();
801057c3:	e8 a8 d7 ff ff       	call   80102f70 <end_op>
  return 0;
801057c8:	83 c4 10             	add    $0x10,%esp
801057cb:	31 c0                	xor    %eax,%eax
}
801057cd:	c9                   	leave  
801057ce:	c3                   	ret    
801057cf:	90                   	nop
    end_op();
801057d0:	e8 9b d7 ff ff       	call   80102f70 <end_op>
    return -1;
801057d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057da:	c9                   	leave  
801057db:	c3                   	ret    
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057e0 <sys_chdir>:

int
sys_chdir(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	53                   	push   %ebx
801057e4:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
801057e7:	e8 14 d7 ff ff       	call   80102f00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801057ec:	83 ec 08             	sub    $0x8,%esp
801057ef:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057f2:	50                   	push   %eax
801057f3:	6a 00                	push   $0x0
801057f5:	e8 b6 f5 ff ff       	call   80104db0 <argstr>
801057fa:	83 c4 10             	add    $0x10,%esp
801057fd:	85 c0                	test   %eax,%eax
801057ff:	78 7f                	js     80105880 <sys_chdir+0xa0>
80105801:	83 ec 0c             	sub    $0xc,%esp
80105804:	ff 75 f4             	pushl  -0xc(%ebp)
80105807:	e8 94 c9 ff ff       	call   801021a0 <namei>
8010580c:	83 c4 10             	add    $0x10,%esp
8010580f:	89 c3                	mov    %eax,%ebx
80105811:	85 c0                	test   %eax,%eax
80105813:	74 6b                	je     80105880 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105815:	83 ec 0c             	sub    $0xc,%esp
80105818:	50                   	push   %eax
80105819:	e8 82 c0 ff ff       	call   801018a0 <ilock>
  if(ip->type != T_DIR){
8010581e:	83 c4 10             	add    $0x10,%esp
80105821:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105826:	75 38                	jne    80105860 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105828:	83 ec 0c             	sub    $0xc,%esp
8010582b:	53                   	push   %ebx
8010582c:	e8 4f c1 ff ff       	call   80101980 <iunlock>
  iput(proc->cwd);
80105831:	58                   	pop    %eax
80105832:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105838:	ff 70 68             	pushl  0x68(%eax)
8010583b:	e8 90 c1 ff ff       	call   801019d0 <iput>
  end_op();
80105840:	e8 2b d7 ff ff       	call   80102f70 <end_op>
  proc->cwd = ip;
80105845:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
8010584b:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
8010584e:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
80105851:	31 c0                	xor    %eax,%eax
}
80105853:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105856:	c9                   	leave  
80105857:	c3                   	ret    
80105858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585f:	90                   	nop
    iunlockput(ip);
80105860:	83 ec 0c             	sub    $0xc,%esp
80105863:	53                   	push   %ebx
80105864:	e8 a7 c2 ff ff       	call   80101b10 <iunlockput>
    end_op();
80105869:	e8 02 d7 ff ff       	call   80102f70 <end_op>
    return -1;
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105876:	eb db                	jmp    80105853 <sys_chdir+0x73>
80105878:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010587f:	90                   	nop
    end_op();
80105880:	e8 eb d6 ff ff       	call   80102f70 <end_op>
    return -1;
80105885:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010588a:	eb c7                	jmp    80105853 <sys_chdir+0x73>
8010588c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105890 <sys_exec>:

int
sys_exec(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	57                   	push   %edi
80105894:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105895:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010589b:	53                   	push   %ebx
8010589c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801058a2:	50                   	push   %eax
801058a3:	6a 00                	push   $0x0
801058a5:	e8 06 f5 ff ff       	call   80104db0 <argstr>
801058aa:	83 c4 10             	add    $0x10,%esp
801058ad:	85 c0                	test   %eax,%eax
801058af:	0f 88 87 00 00 00    	js     8010593c <sys_exec+0xac>
801058b5:	83 ec 08             	sub    $0x8,%esp
801058b8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801058be:	50                   	push   %eax
801058bf:	6a 01                	push   $0x1
801058c1:	e8 5a f4 ff ff       	call   80104d20 <argint>
801058c6:	83 c4 10             	add    $0x10,%esp
801058c9:	85 c0                	test   %eax,%eax
801058cb:	78 6f                	js     8010593c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801058cd:	83 ec 04             	sub    $0x4,%esp
801058d0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801058d6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801058d8:	68 80 00 00 00       	push   $0x80
801058dd:	6a 00                	push   $0x0
801058df:	56                   	push   %esi
801058e0:	e8 8b f1 ff ff       	call   80104a70 <memset>
801058e5:	83 c4 10             	add    $0x10,%esp
801058e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058ef:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801058f0:	83 ec 08             	sub    $0x8,%esp
801058f3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801058f9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105900:	50                   	push   %eax
80105901:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105907:	01 f8                	add    %edi,%eax
80105909:	50                   	push   %eax
8010590a:	e8 91 f3 ff ff       	call   80104ca0 <fetchint>
8010590f:	83 c4 10             	add    $0x10,%esp
80105912:	85 c0                	test   %eax,%eax
80105914:	78 26                	js     8010593c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105916:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010591c:	85 c0                	test   %eax,%eax
8010591e:	74 30                	je     80105950 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105920:	83 ec 08             	sub    $0x8,%esp
80105923:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105926:	52                   	push   %edx
80105927:	50                   	push   %eax
80105928:	e8 a3 f3 ff ff       	call   80104cd0 <fetchstr>
8010592d:	83 c4 10             	add    $0x10,%esp
80105930:	85 c0                	test   %eax,%eax
80105932:	78 08                	js     8010593c <sys_exec+0xac>
  for(i=0;; i++){
80105934:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105937:	83 fb 20             	cmp    $0x20,%ebx
8010593a:	75 b4                	jne    801058f0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010593c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010593f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105944:	5b                   	pop    %ebx
80105945:	5e                   	pop    %esi
80105946:	5f                   	pop    %edi
80105947:	5d                   	pop    %ebp
80105948:	c3                   	ret    
80105949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105950:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105957:	00 00 00 00 
  return exec(path, argv);
8010595b:	83 ec 08             	sub    $0x8,%esp
8010595e:	56                   	push   %esi
8010595f:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105965:	e8 66 b2 ff ff       	call   80100bd0 <exec>
8010596a:	83 c4 10             	add    $0x10,%esp
}
8010596d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105970:	5b                   	pop    %ebx
80105971:	5e                   	pop    %esi
80105972:	5f                   	pop    %edi
80105973:	5d                   	pop    %ebp
80105974:	c3                   	ret    
80105975:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105980 <sys_pipe>:

int
sys_pipe(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	57                   	push   %edi
80105984:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105985:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105988:	53                   	push   %ebx
80105989:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010598c:	6a 08                	push   $0x8
8010598e:	50                   	push   %eax
8010598f:	6a 00                	push   $0x0
80105991:	e8 ca f3 ff ff       	call   80104d60 <argptr>
80105996:	83 c4 10             	add    $0x10,%esp
80105999:	85 c0                	test   %eax,%eax
8010599b:	78 48                	js     801059e5 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010599d:	83 ec 08             	sub    $0x8,%esp
801059a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059a3:	50                   	push   %eax
801059a4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801059a7:	50                   	push   %eax
801059a8:	e8 13 dd ff ff       	call   801036c0 <pipealloc>
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	85 c0                	test   %eax,%eax
801059b2:	78 31                	js     801059e5 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059b4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    if(proc->ofile[fd] == 0){
801059b7:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
801059be:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
801059c0:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
801059c4:	85 d2                	test   %edx,%edx
801059c6:	74 28                	je     801059f0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
801059c8:	83 c0 01             	add    $0x1,%eax
801059cb:	83 f8 10             	cmp    $0x10,%eax
801059ce:	75 f0                	jne    801059c0 <sys_pipe+0x40>
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
801059d0:	83 ec 0c             	sub    $0xc,%esp
801059d3:	53                   	push   %ebx
801059d4:	e8 27 b6 ff ff       	call   80101000 <fileclose>
    fileclose(wf);
801059d9:	58                   	pop    %eax
801059da:	ff 75 e4             	pushl  -0x1c(%ebp)
801059dd:	e8 1e b6 ff ff       	call   80101000 <fileclose>
    return -1;
801059e2:	83 c4 10             	add    $0x10,%esp
801059e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ea:	eb 45                	jmp    80105a31 <sys_pipe+0xb1>
801059ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd] = f;
801059f0:	8d 70 08             	lea    0x8(%eax),%esi
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059f3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801059f6:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
801059f8:	89 5c b1 08          	mov    %ebx,0x8(%ecx,%esi,4)
  for(fd = 0; fd < NOFILE; fd++){
801059fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->ofile[fd] == 0){
80105a00:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
80105a05:	74 19                	je     80105a20 <sys_pipe+0xa0>
  for(fd = 0; fd < NOFILE; fd++){
80105a07:	83 c2 01             	add    $0x1,%edx
80105a0a:	83 fa 10             	cmp    $0x10,%edx
80105a0d:	75 f1                	jne    80105a00 <sys_pipe+0x80>
      proc->ofile[fd0] = 0;
80105a0f:	c7 44 b1 08 00 00 00 	movl   $0x0,0x8(%ecx,%esi,4)
80105a16:	00 
80105a17:	eb b7                	jmp    801059d0 <sys_pipe+0x50>
80105a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd] = f;
80105a20:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
  }
  fd[0] = fd0;
80105a24:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105a27:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105a29:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a2c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105a2f:	31 c0                	xor    %eax,%eax
}
80105a31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a34:	5b                   	pop    %ebx
80105a35:	5e                   	pop    %esi
80105a36:	5f                   	pop    %edi
80105a37:	5d                   	pop    %ebp
80105a38:	c3                   	ret    
80105a39:	66 90                	xchg   %ax,%ax
80105a3b:	66 90                	xchg   %ax,%ax
80105a3d:	66 90                	xchg   %ax,%ax
80105a3f:	90                   	nop

80105a40 <sys_fork>:
#include "processInfo.h"

int
sys_fork(void)
{
  return fork();
80105a40:	e9 bb e2 ff ff       	jmp    80103d00 <fork>
80105a45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a50 <sys_exit>:
}

int
sys_exit(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	83 ec 08             	sub    $0x8,%esp
  exit();
80105a56:	e8 05 e5 ff ff       	call   80103f60 <exit>
  return 0;  // not reached
}
80105a5b:	31 c0                	xor    %eax,%eax
80105a5d:	c9                   	leave  
80105a5e:	c3                   	ret    
80105a5f:	90                   	nop

80105a60 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105a60:	e9 4b e6 ff ff       	jmp    801040b0 <wait>
80105a65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a70 <sys_kill>:
}

int
sys_kill(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105a76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a79:	50                   	push   %eax
80105a7a:	6a 00                	push   $0x0
80105a7c:	e8 9f f2 ff ff       	call   80104d20 <argint>
80105a81:	83 c4 10             	add    $0x10,%esp
80105a84:	85 c0                	test   %eax,%eax
80105a86:	78 18                	js     80105aa0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105a88:	83 ec 0c             	sub    $0xc,%esp
80105a8b:	ff 75 f4             	pushl  -0xc(%ebp)
80105a8e:	e8 6d e8 ff ff       	call   80104300 <kill>
80105a93:	83 c4 10             	add    $0x10,%esp
}
80105a96:	c9                   	leave  
80105a97:	c3                   	ret    
80105a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a9f:	90                   	nop
80105aa0:	c9                   	leave  
    return -1;
80105aa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105aa6:	c3                   	ret    
80105aa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aae:	66 90                	xchg   %ax,%ax

80105ab0 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105ab0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ab6:	8b 40 10             	mov    0x10(%eax),%eax
}
80105ab9:	c3                   	ret    
80105aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ac0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105ac0:	55                   	push   %ebp
80105ac1:	89 e5                	mov    %esp,%ebp
80105ac3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105ac4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ac7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105aca:	50                   	push   %eax
80105acb:	6a 00                	push   $0x0
80105acd:	e8 4e f2 ff ff       	call   80104d20 <argint>
80105ad2:	83 c4 10             	add    $0x10,%esp
80105ad5:	85 c0                	test   %eax,%eax
80105ad7:	78 27                	js     80105b00 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105ad9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
80105adf:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
80105ae2:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105ae4:	ff 75 f4             	pushl  -0xc(%ebp)
80105ae7:	e8 a4 e1 ff ff       	call   80103c90 <growproc>
80105aec:	83 c4 10             	add    $0x10,%esp
80105aef:	85 c0                	test   %eax,%eax
80105af1:	78 0d                	js     80105b00 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105af3:	89 d8                	mov    %ebx,%eax
80105af5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105af8:	c9                   	leave  
80105af9:	c3                   	ret    
80105afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105b00:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b05:	eb ec                	jmp    80105af3 <sys_sbrk+0x33>
80105b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b0e:	66 90                	xchg   %ax,%ax

80105b10 <sys_sleep>:

int
sys_sleep(void)
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105b14:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b17:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b1a:	50                   	push   %eax
80105b1b:	6a 00                	push   $0x0
80105b1d:	e8 fe f1 ff ff       	call   80104d20 <argint>
80105b22:	83 c4 10             	add    $0x10,%esp
80105b25:	85 c0                	test   %eax,%eax
80105b27:	0f 88 8a 00 00 00    	js     80105bb7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105b2d:	83 ec 0c             	sub    $0xc,%esp
80105b30:	68 80 4a 11 80       	push   $0x80114a80
80105b35:	e8 06 ed ff ff       	call   80104840 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105b3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105b3d:	8b 1d 60 4a 11 80    	mov    0x80114a60,%ebx
  while(ticks - ticks0 < n){
80105b43:	83 c4 10             	add    $0x10,%esp
80105b46:	85 d2                	test   %edx,%edx
80105b48:	75 27                	jne    80105b71 <sys_sleep+0x61>
80105b4a:	eb 54                	jmp    80105ba0 <sys_sleep+0x90>
80105b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105b50:	83 ec 08             	sub    $0x8,%esp
80105b53:	68 80 4a 11 80       	push   $0x80114a80
80105b58:	68 60 4a 11 80       	push   $0x80114a60
80105b5d:	e8 7e e6 ff ff       	call   801041e0 <sleep>
  while(ticks - ticks0 < n){
80105b62:	a1 60 4a 11 80       	mov    0x80114a60,%eax
80105b67:	83 c4 10             	add    $0x10,%esp
80105b6a:	29 d8                	sub    %ebx,%eax
80105b6c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105b6f:	73 2f                	jae    80105ba0 <sys_sleep+0x90>
    if(proc->killed){
80105b71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b77:	8b 40 24             	mov    0x24(%eax),%eax
80105b7a:	85 c0                	test   %eax,%eax
80105b7c:	74 d2                	je     80105b50 <sys_sleep+0x40>
      release(&tickslock);
80105b7e:	83 ec 0c             	sub    $0xc,%esp
80105b81:	68 80 4a 11 80       	push   $0x80114a80
80105b86:	e8 95 ee ff ff       	call   80104a20 <release>
  }
  release(&tickslock);
  return 0;
}
80105b8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105b8e:	83 c4 10             	add    $0x10,%esp
80105b91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b96:	c9                   	leave  
80105b97:	c3                   	ret    
80105b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b9f:	90                   	nop
  release(&tickslock);
80105ba0:	83 ec 0c             	sub    $0xc,%esp
80105ba3:	68 80 4a 11 80       	push   $0x80114a80
80105ba8:	e8 73 ee ff ff       	call   80104a20 <release>
  return 0;
80105bad:	83 c4 10             	add    $0x10,%esp
80105bb0:	31 c0                	xor    %eax,%eax
}
80105bb2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bb5:	c9                   	leave  
80105bb6:	c3                   	ret    
    return -1;
80105bb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bbc:	eb f4                	jmp    80105bb2 <sys_sleep+0xa2>
80105bbe:	66 90                	xchg   %ax,%ax

80105bc0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	53                   	push   %ebx
80105bc4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105bc7:	68 80 4a 11 80       	push   $0x80114a80
80105bcc:	e8 6f ec ff ff       	call   80104840 <acquire>
  xticks = ticks;
80105bd1:	8b 1d 60 4a 11 80    	mov    0x80114a60,%ebx
  release(&tickslock);
80105bd7:	c7 04 24 80 4a 11 80 	movl   $0x80114a80,(%esp)
80105bde:	e8 3d ee ff ff       	call   80104a20 <release>
  return xticks;
}
80105be3:	89 d8                	mov    %ebx,%eax
80105be5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105be8:	c9                   	leave  
80105be9:	c3                   	ret    
80105bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105bf0 <sys_halt>:

int
sys_halt(void)
{
	return halt();
80105bf0:	e9 4b e8 ff ff       	jmp    80104440 <halt>
80105bf5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c00 <sys_cps>:
}

int
sys_cps(void)
{
  return cps();
80105c00:	e9 4b e8 ff ff       	jmp    80104450 <cps>
80105c05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c10 <sys_chpr>:
}

int
sys_chpr(void)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
80105c16:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c19:	50                   	push   %eax
80105c1a:	6a 00                	push   $0x0
80105c1c:	e8 ff f0 ff ff       	call   80104d20 <argint>
80105c21:	83 c4 10             	add    $0x10,%esp
80105c24:	85 c0                	test   %eax,%eax
80105c26:	78 28                	js     80105c50 <sys_chpr+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80105c28:	83 ec 08             	sub    $0x8,%esp
80105c2b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c2e:	50                   	push   %eax
80105c2f:	6a 01                	push   $0x1
80105c31:	e8 ea f0 ff ff       	call   80104d20 <argint>
80105c36:	83 c4 10             	add    $0x10,%esp
80105c39:	85 c0                	test   %eax,%eax
80105c3b:	78 13                	js     80105c50 <sys_chpr+0x40>
    return -1;

  return chpr(pid, pr);
80105c3d:	83 ec 08             	sub    $0x8,%esp
80105c40:	ff 75 f4             	pushl  -0xc(%ebp)
80105c43:	ff 75 f0             	pushl  -0x10(%ebp)
80105c46:	e8 25 e9 ff ff       	call   80104570 <chpr>
80105c4b:	83 c4 10             	add    $0x10,%esp
}
80105c4e:	c9                   	leave  
80105c4f:	c3                   	ret    
80105c50:	c9                   	leave  
    return -1;
80105c51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c56:	c3                   	ret    
80105c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c5e:	66 90                	xchg   %ax,%ax

80105c60 <sys_getNumProc>:

int
sys_getNumProc(void)
{
	return getNumProc();
80105c60:	e9 5b e9 ff ff       	jmp    801045c0 <getNumProc>
80105c65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c70 <sys_getMaxPid>:
}

int
sys_getMaxPid(void)
{
	return getMaxPid();
80105c70:	e9 9b e9 ff ff       	jmp    80104610 <getMaxPid>
80105c75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c80 <sys_getProcInfo>:
}

int
sys_getProcInfo(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	83 ec 20             	sub    $0x20,%esp
	int pid;
	struct processInfo *pfo;
	if(argint(0, &pid) < 0)
80105c86:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c89:	50                   	push   %eax
80105c8a:	6a 00                	push   $0x0
80105c8c:	e8 8f f0 ff ff       	call   80104d20 <argint>
80105c91:	83 c4 10             	add    $0x10,%esp
80105c94:	85 c0                	test   %eax,%eax
80105c96:	78 30                	js     80105cc8 <sys_getProcInfo+0x48>
		return -1;
	if(argptr(1, (void*)&pfo, sizeof(*pfo)) < 0)
80105c98:	83 ec 04             	sub    $0x4,%esp
80105c9b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c9e:	6a 0c                	push   $0xc
80105ca0:	50                   	push   %eax
80105ca1:	6a 01                	push   $0x1
80105ca3:	e8 b8 f0 ff ff       	call   80104d60 <argptr>
80105ca8:	83 c4 10             	add    $0x10,%esp
80105cab:	85 c0                	test   %eax,%eax
80105cad:	78 19                	js     80105cc8 <sys_getProcInfo+0x48>
		return -1;

	return getProcInfo(pid, pfo);
80105caf:	83 ec 08             	sub    $0x8,%esp
80105cb2:	ff 75 f4             	pushl  -0xc(%ebp)
80105cb5:	ff 75 f0             	pushl  -0x10(%ebp)
80105cb8:	e8 a3 e9 ff ff       	call   80104660 <getProcInfo>
80105cbd:	83 c4 10             	add    $0x10,%esp
}	
80105cc0:	c9                   	leave  
80105cc1:	c3                   	ret    
80105cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cc8:	c9                   	leave  
		return -1;
80105cc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}	
80105cce:	c3                   	ret    
80105ccf:	90                   	nop

80105cd0 <sys_setprio>:

int
sys_setprio(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 20             	sub    $0x20,%esp
	int priority;
	if(argint(0, &priority) < 0)
80105cd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cd9:	50                   	push   %eax
80105cda:	6a 00                	push   $0x0
80105cdc:	e8 3f f0 ff ff       	call   80104d20 <argint>
80105ce1:	83 c4 10             	add    $0x10,%esp
80105ce4:	85 c0                	test   %eax,%eax
80105ce6:	78 18                	js     80105d00 <sys_setprio+0x30>
		return -1;
	return setprio(priority);
80105ce8:	83 ec 0c             	sub    $0xc,%esp
80105ceb:	ff 75 f4             	pushl  -0xc(%ebp)
80105cee:	e8 ed e9 ff ff       	call   801046e0 <setprio>
80105cf3:	83 c4 10             	add    $0x10,%esp
}
80105cf6:	c9                   	leave  
80105cf7:	c3                   	ret    
80105cf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cff:	90                   	nop
80105d00:	c9                   	leave  
		return -1;
80105d01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d06:	c3                   	ret    
80105d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d0e:	66 90                	xchg   %ax,%ax

80105d10 <sys_getprio>:

int
sys_getprio(void)
{
	return getprio();
80105d10:	e9 eb e9 ff ff       	jmp    80104700 <getprio>
80105d15:	66 90                	xchg   %ax,%ax
80105d17:	66 90                	xchg   %ax,%ax
80105d19:	66 90                	xchg   %ax,%ax
80105d1b:	66 90                	xchg   %ax,%ax
80105d1d:	66 90                	xchg   %ax,%ax
80105d1f:	90                   	nop

80105d20 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105d20:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d21:	b8 34 00 00 00       	mov    $0x34,%eax
80105d26:	ba 43 00 00 00       	mov    $0x43,%edx
80105d2b:	89 e5                	mov    %esp,%ebp
80105d2d:	83 ec 14             	sub    $0x14,%esp
80105d30:	ee                   	out    %al,(%dx)
80105d31:	ba 40 00 00 00       	mov    $0x40,%edx
80105d36:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105d3b:	ee                   	out    %al,(%dx)
80105d3c:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105d41:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80105d42:	6a 00                	push   $0x0
80105d44:	e8 a7 d8 ff ff       	call   801035f0 <picenable>
}
80105d49:	83 c4 10             	add    $0x10,%esp
80105d4c:	c9                   	leave  
80105d4d:	c3                   	ret    

80105d4e <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105d4e:	1e                   	push   %ds
  pushl %es
80105d4f:	06                   	push   %es
  pushl %fs
80105d50:	0f a0                	push   %fs
  pushl %gs
80105d52:	0f a8                	push   %gs
  pushal
80105d54:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105d55:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105d59:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105d5b:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80105d5d:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105d61:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105d63:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105d65:	54                   	push   %esp
  call trap
80105d66:	e8 c5 00 00 00       	call   80105e30 <trap>
  addl $4, %esp
80105d6b:	83 c4 04             	add    $0x4,%esp

80105d6e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105d6e:	61                   	popa   
  popl %gs
80105d6f:	0f a9                	pop    %gs
  popl %fs
80105d71:	0f a1                	pop    %fs
  popl %es
80105d73:	07                   	pop    %es
  popl %ds
80105d74:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105d75:	83 c4 08             	add    $0x8,%esp
  iret
80105d78:	cf                   	iret   
80105d79:	66 90                	xchg   %ax,%ax
80105d7b:	66 90                	xchg   %ax,%ax
80105d7d:	66 90                	xchg   %ax,%ax
80105d7f:	90                   	nop

80105d80 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d80:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105d81:	31 c0                	xor    %eax,%eax
{
80105d83:	89 e5                	mov    %esp,%ebp
80105d85:	83 ec 08             	sub    $0x8,%esp
80105d88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d8f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105d90:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80105d97:	c7 04 c5 c2 4a 11 80 	movl   $0x8e000008,-0x7feeb53e(,%eax,8)
80105d9e:	08 00 00 8e 
80105da2:	66 89 14 c5 c0 4a 11 	mov    %dx,-0x7feeb540(,%eax,8)
80105da9:	80 
80105daa:	c1 ea 10             	shr    $0x10,%edx
80105dad:	66 89 14 c5 c6 4a 11 	mov    %dx,-0x7feeb53a(,%eax,8)
80105db4:	80 
  for(i = 0; i < 256; i++)
80105db5:	83 c0 01             	add    $0x1,%eax
80105db8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105dbd:	75 d1                	jne    80105d90 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105dbf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105dc2:	a1 0c b1 10 80       	mov    0x8010b10c,%eax
80105dc7:	c7 05 c2 4c 11 80 08 	movl   $0xef000008,0x80114cc2
80105dce:	00 00 ef 
  initlock(&tickslock, "time");
80105dd1:	68 39 7e 10 80       	push   $0x80107e39
80105dd6:	68 80 4a 11 80       	push   $0x80114a80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ddb:	66 a3 c0 4c 11 80    	mov    %ax,0x80114cc0
80105de1:	c1 e8 10             	shr    $0x10,%eax
80105de4:	66 a3 c6 4c 11 80    	mov    %ax,0x80114cc6
  initlock(&tickslock, "time");
80105dea:	e8 31 ea ff ff       	call   80104820 <initlock>
}
80105def:	83 c4 10             	add    $0x10,%esp
80105df2:	c9                   	leave  
80105df3:	c3                   	ret    
80105df4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105dff:	90                   	nop

80105e00 <idtinit>:

void
idtinit(void)
{
80105e00:	55                   	push   %ebp
  pd[0] = size-1;
80105e01:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105e06:	89 e5                	mov    %esp,%ebp
80105e08:	83 ec 10             	sub    $0x10,%esp
80105e0b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105e0f:	b8 c0 4a 11 80       	mov    $0x80114ac0,%eax
80105e14:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105e18:	c1 e8 10             	shr    $0x10,%eax
80105e1b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105e1f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105e22:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105e25:	c9                   	leave  
80105e26:	c3                   	ret    
80105e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2e:	66 90                	xchg   %ax,%ax

80105e30 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	57                   	push   %edi
80105e34:	56                   	push   %esi
80105e35:	53                   	push   %ebx
80105e36:	83 ec 0c             	sub    $0xc,%esp
80105e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105e3c:	8b 43 30             	mov    0x30(%ebx),%eax
80105e3f:	83 f8 40             	cmp    $0x40,%eax
80105e42:	0f 84 e8 00 00 00    	je     80105f30 <trap+0x100>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105e48:	83 e8 20             	sub    $0x20,%eax
80105e4b:	83 f8 1f             	cmp    $0x1f,%eax
80105e4e:	77 60                	ja     80105eb0 <trap+0x80>
80105e50:	ff 24 85 e0 7e 10 80 	jmp    *-0x7fef8120(,%eax,4)
80105e57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e5e:	66 90                	xchg   %ax,%ax
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105e60:	e8 8b 03 00 00       	call   801061f0 <uartintr>
    lapiceoi();
80105e65:	e8 46 cc ff ff       	call   80102ab0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105e6a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e70:	85 c0                	test   %eax,%eax
80105e72:	74 2d                	je     80105ea1 <trap+0x71>
80105e74:	8b 50 24             	mov    0x24(%eax),%edx
80105e77:	85 d2                	test   %edx,%edx
80105e79:	0f 85 87 00 00 00    	jne    80105f06 <trap+0xd6>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105e7f:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105e83:	0f 84 7f 01 00 00    	je     80106008 <trap+0x1d8>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105e89:	8b 40 24             	mov    0x24(%eax),%eax
80105e8c:	85 c0                	test   %eax,%eax
80105e8e:	74 11                	je     80105ea1 <trap+0x71>
80105e90:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105e94:	83 e0 03             	and    $0x3,%eax
80105e97:	66 83 f8 03          	cmp    $0x3,%ax
80105e9b:	0f 84 b5 00 00 00    	je     80105f56 <trap+0x126>
    exit();
}
80105ea1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ea4:	5b                   	pop    %ebx
80105ea5:	5e                   	pop    %esi
80105ea6:	5f                   	pop    %edi
80105ea7:	5d                   	pop    %ebp
80105ea8:	c3                   	ret    
80105ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(proc == 0 || (tf->cs&3) == 0){
80105eb0:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105eb7:	8b 73 38             	mov    0x38(%ebx),%esi
    if(proc == 0 || (tf->cs&3) == 0){
80105eba:	85 c9                	test   %ecx,%ecx
80105ebc:	0f 84 68 01 00 00    	je     8010602a <trap+0x1fa>
80105ec2:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105ec6:	0f 84 5e 01 00 00    	je     8010602a <trap+0x1fa>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105ecc:	0f 20 d7             	mov    %cr2,%edi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ecf:	e8 4c cb ff ff       	call   80102a20 <cpunum>
80105ed4:	57                   	push   %edi
80105ed5:	89 c2                	mov    %eax,%edx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105ed7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105edd:	56                   	push   %esi
80105ede:	52                   	push   %edx
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105edf:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ee2:	ff 73 34             	pushl  0x34(%ebx)
80105ee5:	ff 73 30             	pushl  0x30(%ebx)
80105ee8:	52                   	push   %edx
80105ee9:	ff 70 10             	pushl  0x10(%eax)
80105eec:	68 9c 7e 10 80       	push   $0x80107e9c
80105ef1:	e8 8a a7 ff ff       	call   80100680 <cprintf>
    proc->killed = 1;
80105ef6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105efc:	83 c4 20             	add    $0x20,%esp
80105eff:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105f06:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105f0a:	83 e2 03             	and    $0x3,%edx
80105f0d:	66 83 fa 03          	cmp    $0x3,%dx
80105f11:	0f 85 68 ff ff ff    	jne    80105e7f <trap+0x4f>
    exit();
80105f17:	e8 44 e0 ff ff       	call   80103f60 <exit>
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105f1c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f22:	85 c0                	test   %eax,%eax
80105f24:	0f 85 55 ff ff ff    	jne    80105e7f <trap+0x4f>
80105f2a:	e9 72 ff ff ff       	jmp    80105ea1 <trap+0x71>
80105f2f:	90                   	nop
    if(proc->killed)
80105f30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f36:	8b 70 24             	mov    0x24(%eax),%esi
80105f39:	85 f6                	test   %esi,%esi
80105f3b:	75 2b                	jne    80105f68 <trap+0x138>
    proc->tf = tf;
80105f3d:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105f40:	e8 db ee ff ff       	call   80104e20 <syscall>
    if(proc->killed)
80105f45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f4b:	8b 58 24             	mov    0x24(%eax),%ebx
80105f4e:	85 db                	test   %ebx,%ebx
80105f50:	0f 84 4b ff ff ff    	je     80105ea1 <trap+0x71>
}
80105f56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f59:	5b                   	pop    %ebx
80105f5a:	5e                   	pop    %esi
80105f5b:	5f                   	pop    %edi
80105f5c:	5d                   	pop    %ebp
      exit();
80105f5d:	e9 fe df ff ff       	jmp    80103f60 <exit>
80105f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105f68:	e8 f3 df ff ff       	call   80103f60 <exit>
    proc->tf = tf;
80105f6d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105f73:	eb c8                	jmp    80105f3d <trap+0x10d>
80105f75:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f78:	8b 7b 38             	mov    0x38(%ebx),%edi
80105f7b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105f7f:	e8 9c ca ff ff       	call   80102a20 <cpunum>
80105f84:	57                   	push   %edi
80105f85:	56                   	push   %esi
80105f86:	50                   	push   %eax
80105f87:	68 44 7e 10 80       	push   $0x80107e44
80105f8c:	e8 ef a6 ff ff       	call   80100680 <cprintf>
    lapiceoi();
80105f91:	e8 1a cb ff ff       	call   80102ab0 <lapiceoi>
    break;
80105f96:	83 c4 10             	add    $0x10,%esp
80105f99:	e9 cc fe ff ff       	jmp    80105e6a <trap+0x3a>
80105f9e:	66 90                	xchg   %ax,%ax
    ideintr();
80105fa0:	e8 ab c3 ff ff       	call   80102350 <ideintr>
    lapiceoi();
80105fa5:	e8 06 cb ff ff       	call   80102ab0 <lapiceoi>
    break;
80105faa:	e9 bb fe ff ff       	jmp    80105e6a <trap+0x3a>
80105faf:	90                   	nop
    kbdintr();
80105fb0:	e8 4b c9 ff ff       	call   80102900 <kbdintr>
    lapiceoi();
80105fb5:	e8 f6 ca ff ff       	call   80102ab0 <lapiceoi>
    break;
80105fba:	e9 ab fe ff ff       	jmp    80105e6a <trap+0x3a>
80105fbf:	90                   	nop
    if(cpunum() == 0){
80105fc0:	e8 5b ca ff ff       	call   80102a20 <cpunum>
80105fc5:	85 c0                	test   %eax,%eax
80105fc7:	0f 85 98 fe ff ff    	jne    80105e65 <trap+0x35>
      acquire(&tickslock);
80105fcd:	83 ec 0c             	sub    $0xc,%esp
80105fd0:	68 80 4a 11 80       	push   $0x80114a80
80105fd5:	e8 66 e8 ff ff       	call   80104840 <acquire>
      wakeup(&ticks);
80105fda:	c7 04 24 60 4a 11 80 	movl   $0x80114a60,(%esp)
      ticks++;
80105fe1:	83 05 60 4a 11 80 01 	addl   $0x1,0x80114a60
      wakeup(&ticks);
80105fe8:	e8 b3 e2 ff ff       	call   801042a0 <wakeup>
      release(&tickslock);
80105fed:	c7 04 24 80 4a 11 80 	movl   $0x80114a80,(%esp)
80105ff4:	e8 27 ea ff ff       	call   80104a20 <release>
80105ff9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105ffc:	e9 64 fe ff ff       	jmp    80105e65 <trap+0x35>
80106001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106008:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
8010600c:	0f 85 77 fe ff ff    	jne    80105e89 <trap+0x59>
    yield();
80106012:	e8 89 e1 ff ff       	call   801041a0 <yield>
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106017:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010601d:	85 c0                	test   %eax,%eax
8010601f:	0f 85 64 fe ff ff    	jne    80105e89 <trap+0x59>
80106025:	e9 77 fe ff ff       	jmp    80105ea1 <trap+0x71>
8010602a:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010602d:	e8 ee c9 ff ff       	call   80102a20 <cpunum>
80106032:	83 ec 0c             	sub    $0xc,%esp
80106035:	57                   	push   %edi
80106036:	56                   	push   %esi
80106037:	50                   	push   %eax
80106038:	ff 73 30             	pushl  0x30(%ebx)
8010603b:	68 68 7e 10 80       	push   $0x80107e68
80106040:	e8 3b a6 ff ff       	call   80100680 <cprintf>
      panic("trap");
80106045:	83 c4 14             	add    $0x14,%esp
80106048:	68 3e 7e 10 80       	push   $0x80107e3e
8010604d:	e8 2e a3 ff ff       	call   80100380 <panic>
80106052:	66 90                	xchg   %ax,%ax
80106054:	66 90                	xchg   %ax,%ax
80106056:	66 90                	xchg   %ax,%ax
80106058:	66 90                	xchg   %ax,%ax
8010605a:	66 90                	xchg   %ax,%ax
8010605c:	66 90                	xchg   %ax,%ax
8010605e:	66 90                	xchg   %ax,%ax

80106060 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106060:	a1 c0 52 11 80       	mov    0x801152c0,%eax
80106065:	85 c0                	test   %eax,%eax
80106067:	74 17                	je     80106080 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106069:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010606e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010606f:	a8 01                	test   $0x1,%al
80106071:	74 0d                	je     80106080 <uartgetc+0x20>
80106073:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106078:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106079:	0f b6 c0             	movzbl %al,%eax
8010607c:	c3                   	ret    
8010607d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106085:	c3                   	ret    
80106086:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010608d:	8d 76 00             	lea    0x0(%esi),%esi

80106090 <uartinit>:
{
80106090:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106091:	31 c9                	xor    %ecx,%ecx
80106093:	89 c8                	mov    %ecx,%eax
80106095:	89 e5                	mov    %esp,%ebp
80106097:	57                   	push   %edi
80106098:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010609d:	56                   	push   %esi
8010609e:	89 fa                	mov    %edi,%edx
801060a0:	53                   	push   %ebx
801060a1:	83 ec 1c             	sub    $0x1c,%esp
801060a4:	ee                   	out    %al,(%dx)
801060a5:	be fb 03 00 00       	mov    $0x3fb,%esi
801060aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801060af:	89 f2                	mov    %esi,%edx
801060b1:	ee                   	out    %al,(%dx)
801060b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801060b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060bc:	ee                   	out    %al,(%dx)
801060bd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801060c2:	89 c8                	mov    %ecx,%eax
801060c4:	89 da                	mov    %ebx,%edx
801060c6:	ee                   	out    %al,(%dx)
801060c7:	b8 03 00 00 00       	mov    $0x3,%eax
801060cc:	89 f2                	mov    %esi,%edx
801060ce:	ee                   	out    %al,(%dx)
801060cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801060d4:	89 c8                	mov    %ecx,%eax
801060d6:	ee                   	out    %al,(%dx)
801060d7:	b8 01 00 00 00       	mov    $0x1,%eax
801060dc:	89 da                	mov    %ebx,%edx
801060de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801060df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801060e4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801060e5:	3c ff                	cmp    $0xff,%al
801060e7:	0f 84 93 00 00 00    	je     80106180 <uartinit+0xf0>
  uart = 1;
801060ed:	c7 05 c0 52 11 80 01 	movl   $0x1,0x801152c0
801060f4:	00 00 00 
801060f7:	89 fa                	mov    %edi,%edx
801060f9:	ec                   	in     (%dx),%al
801060fa:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ff:	ec                   	in     (%dx),%al
  picenable(IRQ_COM1);
80106100:	83 ec 0c             	sub    $0xc,%esp
  for(p="xv6...\n"; *p; p++)
80106103:	bf 60 7f 10 80       	mov    $0x80107f60,%edi
80106108:	be fd 03 00 00       	mov    $0x3fd,%esi
  picenable(IRQ_COM1);
8010610d:	6a 04                	push   $0x4
8010610f:	e8 dc d4 ff ff       	call   801035f0 <picenable>
  ioapicenable(IRQ_COM1, 0);
80106114:	5a                   	pop    %edx
80106115:	59                   	pop    %ecx
80106116:	6a 00                	push   $0x0
80106118:	6a 04                	push   $0x4
8010611a:	e8 91 c4 ff ff       	call   801025b0 <ioapicenable>
8010611f:	c6 45 e7 76          	movb   $0x76,-0x19(%ebp)
80106123:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106126:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
8010612a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(!uart)
80106130:	a1 c0 52 11 80       	mov    0x801152c0,%eax
80106135:	bb 80 00 00 00       	mov    $0x80,%ebx
8010613a:	85 c0                	test   %eax,%eax
8010613c:	75 14                	jne    80106152 <uartinit+0xc2>
8010613e:	eb 23                	jmp    80106163 <uartinit+0xd3>
    microdelay(10);
80106140:	83 ec 0c             	sub    $0xc,%esp
80106143:	6a 0a                	push   $0xa
80106145:	e8 86 c9 ff ff       	call   80102ad0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010614a:	83 c4 10             	add    $0x10,%esp
8010614d:	83 eb 01             	sub    $0x1,%ebx
80106150:	74 07                	je     80106159 <uartinit+0xc9>
80106152:	89 f2                	mov    %esi,%edx
80106154:	ec                   	in     (%dx),%al
80106155:	a8 20                	test   $0x20,%al
80106157:	74 e7                	je     80106140 <uartinit+0xb0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106159:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
8010615d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106162:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106163:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80106167:	83 c7 01             	add    $0x1,%edi
8010616a:	84 c0                	test   %al,%al
8010616c:	74 12                	je     80106180 <uartinit+0xf0>
8010616e:	88 45 e6             	mov    %al,-0x1a(%ebp)
80106171:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106175:	88 45 e7             	mov    %al,-0x19(%ebp)
80106178:	eb b6                	jmp    80106130 <uartinit+0xa0>
8010617a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80106180:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106183:	5b                   	pop    %ebx
80106184:	5e                   	pop    %esi
80106185:	5f                   	pop    %edi
80106186:	5d                   	pop    %ebp
80106187:	c3                   	ret    
80106188:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010618f:	90                   	nop

80106190 <uartputc>:
  if(!uart)
80106190:	a1 c0 52 11 80       	mov    0x801152c0,%eax
80106195:	85 c0                	test   %eax,%eax
80106197:	74 47                	je     801061e0 <uartputc+0x50>
{
80106199:	55                   	push   %ebp
8010619a:	89 e5                	mov    %esp,%ebp
8010619c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010619d:	be fd 03 00 00       	mov    $0x3fd,%esi
801061a2:	53                   	push   %ebx
801061a3:	bb 80 00 00 00       	mov    $0x80,%ebx
801061a8:	eb 18                	jmp    801061c2 <uartputc+0x32>
801061aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801061b0:	83 ec 0c             	sub    $0xc,%esp
801061b3:	6a 0a                	push   $0xa
801061b5:	e8 16 c9 ff ff       	call   80102ad0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801061ba:	83 c4 10             	add    $0x10,%esp
801061bd:	83 eb 01             	sub    $0x1,%ebx
801061c0:	74 07                	je     801061c9 <uartputc+0x39>
801061c2:	89 f2                	mov    %esi,%edx
801061c4:	ec                   	in     (%dx),%al
801061c5:	a8 20                	test   $0x20,%al
801061c7:	74 e7                	je     801061b0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801061c9:	8b 45 08             	mov    0x8(%ebp),%eax
801061cc:	ba f8 03 00 00       	mov    $0x3f8,%edx
801061d1:	ee                   	out    %al,(%dx)
}
801061d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801061d5:	5b                   	pop    %ebx
801061d6:	5e                   	pop    %esi
801061d7:	5d                   	pop    %ebp
801061d8:	c3                   	ret    
801061d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061e0:	c3                   	ret    
801061e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ef:	90                   	nop

801061f0 <uartintr>:

void
uartintr(void)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
801061f3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801061f6:	68 60 60 10 80       	push   $0x80106060
801061fb:	e8 f0 a6 ff ff       	call   801008f0 <consoleintr>
}
80106200:	83 c4 10             	add    $0x10,%esp
80106203:	c9                   	leave  
80106204:	c3                   	ret    

80106205 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106205:	6a 00                	push   $0x0
  pushl $0
80106207:	6a 00                	push   $0x0
  jmp alltraps
80106209:	e9 40 fb ff ff       	jmp    80105d4e <alltraps>

8010620e <vector1>:
.globl vector1
vector1:
  pushl $0
8010620e:	6a 00                	push   $0x0
  pushl $1
80106210:	6a 01                	push   $0x1
  jmp alltraps
80106212:	e9 37 fb ff ff       	jmp    80105d4e <alltraps>

80106217 <vector2>:
.globl vector2
vector2:
  pushl $0
80106217:	6a 00                	push   $0x0
  pushl $2
80106219:	6a 02                	push   $0x2
  jmp alltraps
8010621b:	e9 2e fb ff ff       	jmp    80105d4e <alltraps>

80106220 <vector3>:
.globl vector3
vector3:
  pushl $0
80106220:	6a 00                	push   $0x0
  pushl $3
80106222:	6a 03                	push   $0x3
  jmp alltraps
80106224:	e9 25 fb ff ff       	jmp    80105d4e <alltraps>

80106229 <vector4>:
.globl vector4
vector4:
  pushl $0
80106229:	6a 00                	push   $0x0
  pushl $4
8010622b:	6a 04                	push   $0x4
  jmp alltraps
8010622d:	e9 1c fb ff ff       	jmp    80105d4e <alltraps>

80106232 <vector5>:
.globl vector5
vector5:
  pushl $0
80106232:	6a 00                	push   $0x0
  pushl $5
80106234:	6a 05                	push   $0x5
  jmp alltraps
80106236:	e9 13 fb ff ff       	jmp    80105d4e <alltraps>

8010623b <vector6>:
.globl vector6
vector6:
  pushl $0
8010623b:	6a 00                	push   $0x0
  pushl $6
8010623d:	6a 06                	push   $0x6
  jmp alltraps
8010623f:	e9 0a fb ff ff       	jmp    80105d4e <alltraps>

80106244 <vector7>:
.globl vector7
vector7:
  pushl $0
80106244:	6a 00                	push   $0x0
  pushl $7
80106246:	6a 07                	push   $0x7
  jmp alltraps
80106248:	e9 01 fb ff ff       	jmp    80105d4e <alltraps>

8010624d <vector8>:
.globl vector8
vector8:
  pushl $8
8010624d:	6a 08                	push   $0x8
  jmp alltraps
8010624f:	e9 fa fa ff ff       	jmp    80105d4e <alltraps>

80106254 <vector9>:
.globl vector9
vector9:
  pushl $0
80106254:	6a 00                	push   $0x0
  pushl $9
80106256:	6a 09                	push   $0x9
  jmp alltraps
80106258:	e9 f1 fa ff ff       	jmp    80105d4e <alltraps>

8010625d <vector10>:
.globl vector10
vector10:
  pushl $10
8010625d:	6a 0a                	push   $0xa
  jmp alltraps
8010625f:	e9 ea fa ff ff       	jmp    80105d4e <alltraps>

80106264 <vector11>:
.globl vector11
vector11:
  pushl $11
80106264:	6a 0b                	push   $0xb
  jmp alltraps
80106266:	e9 e3 fa ff ff       	jmp    80105d4e <alltraps>

8010626b <vector12>:
.globl vector12
vector12:
  pushl $12
8010626b:	6a 0c                	push   $0xc
  jmp alltraps
8010626d:	e9 dc fa ff ff       	jmp    80105d4e <alltraps>

80106272 <vector13>:
.globl vector13
vector13:
  pushl $13
80106272:	6a 0d                	push   $0xd
  jmp alltraps
80106274:	e9 d5 fa ff ff       	jmp    80105d4e <alltraps>

80106279 <vector14>:
.globl vector14
vector14:
  pushl $14
80106279:	6a 0e                	push   $0xe
  jmp alltraps
8010627b:	e9 ce fa ff ff       	jmp    80105d4e <alltraps>

80106280 <vector15>:
.globl vector15
vector15:
  pushl $0
80106280:	6a 00                	push   $0x0
  pushl $15
80106282:	6a 0f                	push   $0xf
  jmp alltraps
80106284:	e9 c5 fa ff ff       	jmp    80105d4e <alltraps>

80106289 <vector16>:
.globl vector16
vector16:
  pushl $0
80106289:	6a 00                	push   $0x0
  pushl $16
8010628b:	6a 10                	push   $0x10
  jmp alltraps
8010628d:	e9 bc fa ff ff       	jmp    80105d4e <alltraps>

80106292 <vector17>:
.globl vector17
vector17:
  pushl $17
80106292:	6a 11                	push   $0x11
  jmp alltraps
80106294:	e9 b5 fa ff ff       	jmp    80105d4e <alltraps>

80106299 <vector18>:
.globl vector18
vector18:
  pushl $0
80106299:	6a 00                	push   $0x0
  pushl $18
8010629b:	6a 12                	push   $0x12
  jmp alltraps
8010629d:	e9 ac fa ff ff       	jmp    80105d4e <alltraps>

801062a2 <vector19>:
.globl vector19
vector19:
  pushl $0
801062a2:	6a 00                	push   $0x0
  pushl $19
801062a4:	6a 13                	push   $0x13
  jmp alltraps
801062a6:	e9 a3 fa ff ff       	jmp    80105d4e <alltraps>

801062ab <vector20>:
.globl vector20
vector20:
  pushl $0
801062ab:	6a 00                	push   $0x0
  pushl $20
801062ad:	6a 14                	push   $0x14
  jmp alltraps
801062af:	e9 9a fa ff ff       	jmp    80105d4e <alltraps>

801062b4 <vector21>:
.globl vector21
vector21:
  pushl $0
801062b4:	6a 00                	push   $0x0
  pushl $21
801062b6:	6a 15                	push   $0x15
  jmp alltraps
801062b8:	e9 91 fa ff ff       	jmp    80105d4e <alltraps>

801062bd <vector22>:
.globl vector22
vector22:
  pushl $0
801062bd:	6a 00                	push   $0x0
  pushl $22
801062bf:	6a 16                	push   $0x16
  jmp alltraps
801062c1:	e9 88 fa ff ff       	jmp    80105d4e <alltraps>

801062c6 <vector23>:
.globl vector23
vector23:
  pushl $0
801062c6:	6a 00                	push   $0x0
  pushl $23
801062c8:	6a 17                	push   $0x17
  jmp alltraps
801062ca:	e9 7f fa ff ff       	jmp    80105d4e <alltraps>

801062cf <vector24>:
.globl vector24
vector24:
  pushl $0
801062cf:	6a 00                	push   $0x0
  pushl $24
801062d1:	6a 18                	push   $0x18
  jmp alltraps
801062d3:	e9 76 fa ff ff       	jmp    80105d4e <alltraps>

801062d8 <vector25>:
.globl vector25
vector25:
  pushl $0
801062d8:	6a 00                	push   $0x0
  pushl $25
801062da:	6a 19                	push   $0x19
  jmp alltraps
801062dc:	e9 6d fa ff ff       	jmp    80105d4e <alltraps>

801062e1 <vector26>:
.globl vector26
vector26:
  pushl $0
801062e1:	6a 00                	push   $0x0
  pushl $26
801062e3:	6a 1a                	push   $0x1a
  jmp alltraps
801062e5:	e9 64 fa ff ff       	jmp    80105d4e <alltraps>

801062ea <vector27>:
.globl vector27
vector27:
  pushl $0
801062ea:	6a 00                	push   $0x0
  pushl $27
801062ec:	6a 1b                	push   $0x1b
  jmp alltraps
801062ee:	e9 5b fa ff ff       	jmp    80105d4e <alltraps>

801062f3 <vector28>:
.globl vector28
vector28:
  pushl $0
801062f3:	6a 00                	push   $0x0
  pushl $28
801062f5:	6a 1c                	push   $0x1c
  jmp alltraps
801062f7:	e9 52 fa ff ff       	jmp    80105d4e <alltraps>

801062fc <vector29>:
.globl vector29
vector29:
  pushl $0
801062fc:	6a 00                	push   $0x0
  pushl $29
801062fe:	6a 1d                	push   $0x1d
  jmp alltraps
80106300:	e9 49 fa ff ff       	jmp    80105d4e <alltraps>

80106305 <vector30>:
.globl vector30
vector30:
  pushl $0
80106305:	6a 00                	push   $0x0
  pushl $30
80106307:	6a 1e                	push   $0x1e
  jmp alltraps
80106309:	e9 40 fa ff ff       	jmp    80105d4e <alltraps>

8010630e <vector31>:
.globl vector31
vector31:
  pushl $0
8010630e:	6a 00                	push   $0x0
  pushl $31
80106310:	6a 1f                	push   $0x1f
  jmp alltraps
80106312:	e9 37 fa ff ff       	jmp    80105d4e <alltraps>

80106317 <vector32>:
.globl vector32
vector32:
  pushl $0
80106317:	6a 00                	push   $0x0
  pushl $32
80106319:	6a 20                	push   $0x20
  jmp alltraps
8010631b:	e9 2e fa ff ff       	jmp    80105d4e <alltraps>

80106320 <vector33>:
.globl vector33
vector33:
  pushl $0
80106320:	6a 00                	push   $0x0
  pushl $33
80106322:	6a 21                	push   $0x21
  jmp alltraps
80106324:	e9 25 fa ff ff       	jmp    80105d4e <alltraps>

80106329 <vector34>:
.globl vector34
vector34:
  pushl $0
80106329:	6a 00                	push   $0x0
  pushl $34
8010632b:	6a 22                	push   $0x22
  jmp alltraps
8010632d:	e9 1c fa ff ff       	jmp    80105d4e <alltraps>

80106332 <vector35>:
.globl vector35
vector35:
  pushl $0
80106332:	6a 00                	push   $0x0
  pushl $35
80106334:	6a 23                	push   $0x23
  jmp alltraps
80106336:	e9 13 fa ff ff       	jmp    80105d4e <alltraps>

8010633b <vector36>:
.globl vector36
vector36:
  pushl $0
8010633b:	6a 00                	push   $0x0
  pushl $36
8010633d:	6a 24                	push   $0x24
  jmp alltraps
8010633f:	e9 0a fa ff ff       	jmp    80105d4e <alltraps>

80106344 <vector37>:
.globl vector37
vector37:
  pushl $0
80106344:	6a 00                	push   $0x0
  pushl $37
80106346:	6a 25                	push   $0x25
  jmp alltraps
80106348:	e9 01 fa ff ff       	jmp    80105d4e <alltraps>

8010634d <vector38>:
.globl vector38
vector38:
  pushl $0
8010634d:	6a 00                	push   $0x0
  pushl $38
8010634f:	6a 26                	push   $0x26
  jmp alltraps
80106351:	e9 f8 f9 ff ff       	jmp    80105d4e <alltraps>

80106356 <vector39>:
.globl vector39
vector39:
  pushl $0
80106356:	6a 00                	push   $0x0
  pushl $39
80106358:	6a 27                	push   $0x27
  jmp alltraps
8010635a:	e9 ef f9 ff ff       	jmp    80105d4e <alltraps>

8010635f <vector40>:
.globl vector40
vector40:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $40
80106361:	6a 28                	push   $0x28
  jmp alltraps
80106363:	e9 e6 f9 ff ff       	jmp    80105d4e <alltraps>

80106368 <vector41>:
.globl vector41
vector41:
  pushl $0
80106368:	6a 00                	push   $0x0
  pushl $41
8010636a:	6a 29                	push   $0x29
  jmp alltraps
8010636c:	e9 dd f9 ff ff       	jmp    80105d4e <alltraps>

80106371 <vector42>:
.globl vector42
vector42:
  pushl $0
80106371:	6a 00                	push   $0x0
  pushl $42
80106373:	6a 2a                	push   $0x2a
  jmp alltraps
80106375:	e9 d4 f9 ff ff       	jmp    80105d4e <alltraps>

8010637a <vector43>:
.globl vector43
vector43:
  pushl $0
8010637a:	6a 00                	push   $0x0
  pushl $43
8010637c:	6a 2b                	push   $0x2b
  jmp alltraps
8010637e:	e9 cb f9 ff ff       	jmp    80105d4e <alltraps>

80106383 <vector44>:
.globl vector44
vector44:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $44
80106385:	6a 2c                	push   $0x2c
  jmp alltraps
80106387:	e9 c2 f9 ff ff       	jmp    80105d4e <alltraps>

8010638c <vector45>:
.globl vector45
vector45:
  pushl $0
8010638c:	6a 00                	push   $0x0
  pushl $45
8010638e:	6a 2d                	push   $0x2d
  jmp alltraps
80106390:	e9 b9 f9 ff ff       	jmp    80105d4e <alltraps>

80106395 <vector46>:
.globl vector46
vector46:
  pushl $0
80106395:	6a 00                	push   $0x0
  pushl $46
80106397:	6a 2e                	push   $0x2e
  jmp alltraps
80106399:	e9 b0 f9 ff ff       	jmp    80105d4e <alltraps>

8010639e <vector47>:
.globl vector47
vector47:
  pushl $0
8010639e:	6a 00                	push   $0x0
  pushl $47
801063a0:	6a 2f                	push   $0x2f
  jmp alltraps
801063a2:	e9 a7 f9 ff ff       	jmp    80105d4e <alltraps>

801063a7 <vector48>:
.globl vector48
vector48:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $48
801063a9:	6a 30                	push   $0x30
  jmp alltraps
801063ab:	e9 9e f9 ff ff       	jmp    80105d4e <alltraps>

801063b0 <vector49>:
.globl vector49
vector49:
  pushl $0
801063b0:	6a 00                	push   $0x0
  pushl $49
801063b2:	6a 31                	push   $0x31
  jmp alltraps
801063b4:	e9 95 f9 ff ff       	jmp    80105d4e <alltraps>

801063b9 <vector50>:
.globl vector50
vector50:
  pushl $0
801063b9:	6a 00                	push   $0x0
  pushl $50
801063bb:	6a 32                	push   $0x32
  jmp alltraps
801063bd:	e9 8c f9 ff ff       	jmp    80105d4e <alltraps>

801063c2 <vector51>:
.globl vector51
vector51:
  pushl $0
801063c2:	6a 00                	push   $0x0
  pushl $51
801063c4:	6a 33                	push   $0x33
  jmp alltraps
801063c6:	e9 83 f9 ff ff       	jmp    80105d4e <alltraps>

801063cb <vector52>:
.globl vector52
vector52:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $52
801063cd:	6a 34                	push   $0x34
  jmp alltraps
801063cf:	e9 7a f9 ff ff       	jmp    80105d4e <alltraps>

801063d4 <vector53>:
.globl vector53
vector53:
  pushl $0
801063d4:	6a 00                	push   $0x0
  pushl $53
801063d6:	6a 35                	push   $0x35
  jmp alltraps
801063d8:	e9 71 f9 ff ff       	jmp    80105d4e <alltraps>

801063dd <vector54>:
.globl vector54
vector54:
  pushl $0
801063dd:	6a 00                	push   $0x0
  pushl $54
801063df:	6a 36                	push   $0x36
  jmp alltraps
801063e1:	e9 68 f9 ff ff       	jmp    80105d4e <alltraps>

801063e6 <vector55>:
.globl vector55
vector55:
  pushl $0
801063e6:	6a 00                	push   $0x0
  pushl $55
801063e8:	6a 37                	push   $0x37
  jmp alltraps
801063ea:	e9 5f f9 ff ff       	jmp    80105d4e <alltraps>

801063ef <vector56>:
.globl vector56
vector56:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $56
801063f1:	6a 38                	push   $0x38
  jmp alltraps
801063f3:	e9 56 f9 ff ff       	jmp    80105d4e <alltraps>

801063f8 <vector57>:
.globl vector57
vector57:
  pushl $0
801063f8:	6a 00                	push   $0x0
  pushl $57
801063fa:	6a 39                	push   $0x39
  jmp alltraps
801063fc:	e9 4d f9 ff ff       	jmp    80105d4e <alltraps>

80106401 <vector58>:
.globl vector58
vector58:
  pushl $0
80106401:	6a 00                	push   $0x0
  pushl $58
80106403:	6a 3a                	push   $0x3a
  jmp alltraps
80106405:	e9 44 f9 ff ff       	jmp    80105d4e <alltraps>

8010640a <vector59>:
.globl vector59
vector59:
  pushl $0
8010640a:	6a 00                	push   $0x0
  pushl $59
8010640c:	6a 3b                	push   $0x3b
  jmp alltraps
8010640e:	e9 3b f9 ff ff       	jmp    80105d4e <alltraps>

80106413 <vector60>:
.globl vector60
vector60:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $60
80106415:	6a 3c                	push   $0x3c
  jmp alltraps
80106417:	e9 32 f9 ff ff       	jmp    80105d4e <alltraps>

8010641c <vector61>:
.globl vector61
vector61:
  pushl $0
8010641c:	6a 00                	push   $0x0
  pushl $61
8010641e:	6a 3d                	push   $0x3d
  jmp alltraps
80106420:	e9 29 f9 ff ff       	jmp    80105d4e <alltraps>

80106425 <vector62>:
.globl vector62
vector62:
  pushl $0
80106425:	6a 00                	push   $0x0
  pushl $62
80106427:	6a 3e                	push   $0x3e
  jmp alltraps
80106429:	e9 20 f9 ff ff       	jmp    80105d4e <alltraps>

8010642e <vector63>:
.globl vector63
vector63:
  pushl $0
8010642e:	6a 00                	push   $0x0
  pushl $63
80106430:	6a 3f                	push   $0x3f
  jmp alltraps
80106432:	e9 17 f9 ff ff       	jmp    80105d4e <alltraps>

80106437 <vector64>:
.globl vector64
vector64:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $64
80106439:	6a 40                	push   $0x40
  jmp alltraps
8010643b:	e9 0e f9 ff ff       	jmp    80105d4e <alltraps>

80106440 <vector65>:
.globl vector65
vector65:
  pushl $0
80106440:	6a 00                	push   $0x0
  pushl $65
80106442:	6a 41                	push   $0x41
  jmp alltraps
80106444:	e9 05 f9 ff ff       	jmp    80105d4e <alltraps>

80106449 <vector66>:
.globl vector66
vector66:
  pushl $0
80106449:	6a 00                	push   $0x0
  pushl $66
8010644b:	6a 42                	push   $0x42
  jmp alltraps
8010644d:	e9 fc f8 ff ff       	jmp    80105d4e <alltraps>

80106452 <vector67>:
.globl vector67
vector67:
  pushl $0
80106452:	6a 00                	push   $0x0
  pushl $67
80106454:	6a 43                	push   $0x43
  jmp alltraps
80106456:	e9 f3 f8 ff ff       	jmp    80105d4e <alltraps>

8010645b <vector68>:
.globl vector68
vector68:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $68
8010645d:	6a 44                	push   $0x44
  jmp alltraps
8010645f:	e9 ea f8 ff ff       	jmp    80105d4e <alltraps>

80106464 <vector69>:
.globl vector69
vector69:
  pushl $0
80106464:	6a 00                	push   $0x0
  pushl $69
80106466:	6a 45                	push   $0x45
  jmp alltraps
80106468:	e9 e1 f8 ff ff       	jmp    80105d4e <alltraps>

8010646d <vector70>:
.globl vector70
vector70:
  pushl $0
8010646d:	6a 00                	push   $0x0
  pushl $70
8010646f:	6a 46                	push   $0x46
  jmp alltraps
80106471:	e9 d8 f8 ff ff       	jmp    80105d4e <alltraps>

80106476 <vector71>:
.globl vector71
vector71:
  pushl $0
80106476:	6a 00                	push   $0x0
  pushl $71
80106478:	6a 47                	push   $0x47
  jmp alltraps
8010647a:	e9 cf f8 ff ff       	jmp    80105d4e <alltraps>

8010647f <vector72>:
.globl vector72
vector72:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $72
80106481:	6a 48                	push   $0x48
  jmp alltraps
80106483:	e9 c6 f8 ff ff       	jmp    80105d4e <alltraps>

80106488 <vector73>:
.globl vector73
vector73:
  pushl $0
80106488:	6a 00                	push   $0x0
  pushl $73
8010648a:	6a 49                	push   $0x49
  jmp alltraps
8010648c:	e9 bd f8 ff ff       	jmp    80105d4e <alltraps>

80106491 <vector74>:
.globl vector74
vector74:
  pushl $0
80106491:	6a 00                	push   $0x0
  pushl $74
80106493:	6a 4a                	push   $0x4a
  jmp alltraps
80106495:	e9 b4 f8 ff ff       	jmp    80105d4e <alltraps>

8010649a <vector75>:
.globl vector75
vector75:
  pushl $0
8010649a:	6a 00                	push   $0x0
  pushl $75
8010649c:	6a 4b                	push   $0x4b
  jmp alltraps
8010649e:	e9 ab f8 ff ff       	jmp    80105d4e <alltraps>

801064a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $76
801064a5:	6a 4c                	push   $0x4c
  jmp alltraps
801064a7:	e9 a2 f8 ff ff       	jmp    80105d4e <alltraps>

801064ac <vector77>:
.globl vector77
vector77:
  pushl $0
801064ac:	6a 00                	push   $0x0
  pushl $77
801064ae:	6a 4d                	push   $0x4d
  jmp alltraps
801064b0:	e9 99 f8 ff ff       	jmp    80105d4e <alltraps>

801064b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801064b5:	6a 00                	push   $0x0
  pushl $78
801064b7:	6a 4e                	push   $0x4e
  jmp alltraps
801064b9:	e9 90 f8 ff ff       	jmp    80105d4e <alltraps>

801064be <vector79>:
.globl vector79
vector79:
  pushl $0
801064be:	6a 00                	push   $0x0
  pushl $79
801064c0:	6a 4f                	push   $0x4f
  jmp alltraps
801064c2:	e9 87 f8 ff ff       	jmp    80105d4e <alltraps>

801064c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $80
801064c9:	6a 50                	push   $0x50
  jmp alltraps
801064cb:	e9 7e f8 ff ff       	jmp    80105d4e <alltraps>

801064d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801064d0:	6a 00                	push   $0x0
  pushl $81
801064d2:	6a 51                	push   $0x51
  jmp alltraps
801064d4:	e9 75 f8 ff ff       	jmp    80105d4e <alltraps>

801064d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801064d9:	6a 00                	push   $0x0
  pushl $82
801064db:	6a 52                	push   $0x52
  jmp alltraps
801064dd:	e9 6c f8 ff ff       	jmp    80105d4e <alltraps>

801064e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801064e2:	6a 00                	push   $0x0
  pushl $83
801064e4:	6a 53                	push   $0x53
  jmp alltraps
801064e6:	e9 63 f8 ff ff       	jmp    80105d4e <alltraps>

801064eb <vector84>:
.globl vector84
vector84:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $84
801064ed:	6a 54                	push   $0x54
  jmp alltraps
801064ef:	e9 5a f8 ff ff       	jmp    80105d4e <alltraps>

801064f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801064f4:	6a 00                	push   $0x0
  pushl $85
801064f6:	6a 55                	push   $0x55
  jmp alltraps
801064f8:	e9 51 f8 ff ff       	jmp    80105d4e <alltraps>

801064fd <vector86>:
.globl vector86
vector86:
  pushl $0
801064fd:	6a 00                	push   $0x0
  pushl $86
801064ff:	6a 56                	push   $0x56
  jmp alltraps
80106501:	e9 48 f8 ff ff       	jmp    80105d4e <alltraps>

80106506 <vector87>:
.globl vector87
vector87:
  pushl $0
80106506:	6a 00                	push   $0x0
  pushl $87
80106508:	6a 57                	push   $0x57
  jmp alltraps
8010650a:	e9 3f f8 ff ff       	jmp    80105d4e <alltraps>

8010650f <vector88>:
.globl vector88
vector88:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $88
80106511:	6a 58                	push   $0x58
  jmp alltraps
80106513:	e9 36 f8 ff ff       	jmp    80105d4e <alltraps>

80106518 <vector89>:
.globl vector89
vector89:
  pushl $0
80106518:	6a 00                	push   $0x0
  pushl $89
8010651a:	6a 59                	push   $0x59
  jmp alltraps
8010651c:	e9 2d f8 ff ff       	jmp    80105d4e <alltraps>

80106521 <vector90>:
.globl vector90
vector90:
  pushl $0
80106521:	6a 00                	push   $0x0
  pushl $90
80106523:	6a 5a                	push   $0x5a
  jmp alltraps
80106525:	e9 24 f8 ff ff       	jmp    80105d4e <alltraps>

8010652a <vector91>:
.globl vector91
vector91:
  pushl $0
8010652a:	6a 00                	push   $0x0
  pushl $91
8010652c:	6a 5b                	push   $0x5b
  jmp alltraps
8010652e:	e9 1b f8 ff ff       	jmp    80105d4e <alltraps>

80106533 <vector92>:
.globl vector92
vector92:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $92
80106535:	6a 5c                	push   $0x5c
  jmp alltraps
80106537:	e9 12 f8 ff ff       	jmp    80105d4e <alltraps>

8010653c <vector93>:
.globl vector93
vector93:
  pushl $0
8010653c:	6a 00                	push   $0x0
  pushl $93
8010653e:	6a 5d                	push   $0x5d
  jmp alltraps
80106540:	e9 09 f8 ff ff       	jmp    80105d4e <alltraps>

80106545 <vector94>:
.globl vector94
vector94:
  pushl $0
80106545:	6a 00                	push   $0x0
  pushl $94
80106547:	6a 5e                	push   $0x5e
  jmp alltraps
80106549:	e9 00 f8 ff ff       	jmp    80105d4e <alltraps>

8010654e <vector95>:
.globl vector95
vector95:
  pushl $0
8010654e:	6a 00                	push   $0x0
  pushl $95
80106550:	6a 5f                	push   $0x5f
  jmp alltraps
80106552:	e9 f7 f7 ff ff       	jmp    80105d4e <alltraps>

80106557 <vector96>:
.globl vector96
vector96:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $96
80106559:	6a 60                	push   $0x60
  jmp alltraps
8010655b:	e9 ee f7 ff ff       	jmp    80105d4e <alltraps>

80106560 <vector97>:
.globl vector97
vector97:
  pushl $0
80106560:	6a 00                	push   $0x0
  pushl $97
80106562:	6a 61                	push   $0x61
  jmp alltraps
80106564:	e9 e5 f7 ff ff       	jmp    80105d4e <alltraps>

80106569 <vector98>:
.globl vector98
vector98:
  pushl $0
80106569:	6a 00                	push   $0x0
  pushl $98
8010656b:	6a 62                	push   $0x62
  jmp alltraps
8010656d:	e9 dc f7 ff ff       	jmp    80105d4e <alltraps>

80106572 <vector99>:
.globl vector99
vector99:
  pushl $0
80106572:	6a 00                	push   $0x0
  pushl $99
80106574:	6a 63                	push   $0x63
  jmp alltraps
80106576:	e9 d3 f7 ff ff       	jmp    80105d4e <alltraps>

8010657b <vector100>:
.globl vector100
vector100:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $100
8010657d:	6a 64                	push   $0x64
  jmp alltraps
8010657f:	e9 ca f7 ff ff       	jmp    80105d4e <alltraps>

80106584 <vector101>:
.globl vector101
vector101:
  pushl $0
80106584:	6a 00                	push   $0x0
  pushl $101
80106586:	6a 65                	push   $0x65
  jmp alltraps
80106588:	e9 c1 f7 ff ff       	jmp    80105d4e <alltraps>

8010658d <vector102>:
.globl vector102
vector102:
  pushl $0
8010658d:	6a 00                	push   $0x0
  pushl $102
8010658f:	6a 66                	push   $0x66
  jmp alltraps
80106591:	e9 b8 f7 ff ff       	jmp    80105d4e <alltraps>

80106596 <vector103>:
.globl vector103
vector103:
  pushl $0
80106596:	6a 00                	push   $0x0
  pushl $103
80106598:	6a 67                	push   $0x67
  jmp alltraps
8010659a:	e9 af f7 ff ff       	jmp    80105d4e <alltraps>

8010659f <vector104>:
.globl vector104
vector104:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $104
801065a1:	6a 68                	push   $0x68
  jmp alltraps
801065a3:	e9 a6 f7 ff ff       	jmp    80105d4e <alltraps>

801065a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801065a8:	6a 00                	push   $0x0
  pushl $105
801065aa:	6a 69                	push   $0x69
  jmp alltraps
801065ac:	e9 9d f7 ff ff       	jmp    80105d4e <alltraps>

801065b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801065b1:	6a 00                	push   $0x0
  pushl $106
801065b3:	6a 6a                	push   $0x6a
  jmp alltraps
801065b5:	e9 94 f7 ff ff       	jmp    80105d4e <alltraps>

801065ba <vector107>:
.globl vector107
vector107:
  pushl $0
801065ba:	6a 00                	push   $0x0
  pushl $107
801065bc:	6a 6b                	push   $0x6b
  jmp alltraps
801065be:	e9 8b f7 ff ff       	jmp    80105d4e <alltraps>

801065c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $108
801065c5:	6a 6c                	push   $0x6c
  jmp alltraps
801065c7:	e9 82 f7 ff ff       	jmp    80105d4e <alltraps>

801065cc <vector109>:
.globl vector109
vector109:
  pushl $0
801065cc:	6a 00                	push   $0x0
  pushl $109
801065ce:	6a 6d                	push   $0x6d
  jmp alltraps
801065d0:	e9 79 f7 ff ff       	jmp    80105d4e <alltraps>

801065d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801065d5:	6a 00                	push   $0x0
  pushl $110
801065d7:	6a 6e                	push   $0x6e
  jmp alltraps
801065d9:	e9 70 f7 ff ff       	jmp    80105d4e <alltraps>

801065de <vector111>:
.globl vector111
vector111:
  pushl $0
801065de:	6a 00                	push   $0x0
  pushl $111
801065e0:	6a 6f                	push   $0x6f
  jmp alltraps
801065e2:	e9 67 f7 ff ff       	jmp    80105d4e <alltraps>

801065e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $112
801065e9:	6a 70                	push   $0x70
  jmp alltraps
801065eb:	e9 5e f7 ff ff       	jmp    80105d4e <alltraps>

801065f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801065f0:	6a 00                	push   $0x0
  pushl $113
801065f2:	6a 71                	push   $0x71
  jmp alltraps
801065f4:	e9 55 f7 ff ff       	jmp    80105d4e <alltraps>

801065f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801065f9:	6a 00                	push   $0x0
  pushl $114
801065fb:	6a 72                	push   $0x72
  jmp alltraps
801065fd:	e9 4c f7 ff ff       	jmp    80105d4e <alltraps>

80106602 <vector115>:
.globl vector115
vector115:
  pushl $0
80106602:	6a 00                	push   $0x0
  pushl $115
80106604:	6a 73                	push   $0x73
  jmp alltraps
80106606:	e9 43 f7 ff ff       	jmp    80105d4e <alltraps>

8010660b <vector116>:
.globl vector116
vector116:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $116
8010660d:	6a 74                	push   $0x74
  jmp alltraps
8010660f:	e9 3a f7 ff ff       	jmp    80105d4e <alltraps>

80106614 <vector117>:
.globl vector117
vector117:
  pushl $0
80106614:	6a 00                	push   $0x0
  pushl $117
80106616:	6a 75                	push   $0x75
  jmp alltraps
80106618:	e9 31 f7 ff ff       	jmp    80105d4e <alltraps>

8010661d <vector118>:
.globl vector118
vector118:
  pushl $0
8010661d:	6a 00                	push   $0x0
  pushl $118
8010661f:	6a 76                	push   $0x76
  jmp alltraps
80106621:	e9 28 f7 ff ff       	jmp    80105d4e <alltraps>

80106626 <vector119>:
.globl vector119
vector119:
  pushl $0
80106626:	6a 00                	push   $0x0
  pushl $119
80106628:	6a 77                	push   $0x77
  jmp alltraps
8010662a:	e9 1f f7 ff ff       	jmp    80105d4e <alltraps>

8010662f <vector120>:
.globl vector120
vector120:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $120
80106631:	6a 78                	push   $0x78
  jmp alltraps
80106633:	e9 16 f7 ff ff       	jmp    80105d4e <alltraps>

80106638 <vector121>:
.globl vector121
vector121:
  pushl $0
80106638:	6a 00                	push   $0x0
  pushl $121
8010663a:	6a 79                	push   $0x79
  jmp alltraps
8010663c:	e9 0d f7 ff ff       	jmp    80105d4e <alltraps>

80106641 <vector122>:
.globl vector122
vector122:
  pushl $0
80106641:	6a 00                	push   $0x0
  pushl $122
80106643:	6a 7a                	push   $0x7a
  jmp alltraps
80106645:	e9 04 f7 ff ff       	jmp    80105d4e <alltraps>

8010664a <vector123>:
.globl vector123
vector123:
  pushl $0
8010664a:	6a 00                	push   $0x0
  pushl $123
8010664c:	6a 7b                	push   $0x7b
  jmp alltraps
8010664e:	e9 fb f6 ff ff       	jmp    80105d4e <alltraps>

80106653 <vector124>:
.globl vector124
vector124:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $124
80106655:	6a 7c                	push   $0x7c
  jmp alltraps
80106657:	e9 f2 f6 ff ff       	jmp    80105d4e <alltraps>

8010665c <vector125>:
.globl vector125
vector125:
  pushl $0
8010665c:	6a 00                	push   $0x0
  pushl $125
8010665e:	6a 7d                	push   $0x7d
  jmp alltraps
80106660:	e9 e9 f6 ff ff       	jmp    80105d4e <alltraps>

80106665 <vector126>:
.globl vector126
vector126:
  pushl $0
80106665:	6a 00                	push   $0x0
  pushl $126
80106667:	6a 7e                	push   $0x7e
  jmp alltraps
80106669:	e9 e0 f6 ff ff       	jmp    80105d4e <alltraps>

8010666e <vector127>:
.globl vector127
vector127:
  pushl $0
8010666e:	6a 00                	push   $0x0
  pushl $127
80106670:	6a 7f                	push   $0x7f
  jmp alltraps
80106672:	e9 d7 f6 ff ff       	jmp    80105d4e <alltraps>

80106677 <vector128>:
.globl vector128
vector128:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $128
80106679:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010667e:	e9 cb f6 ff ff       	jmp    80105d4e <alltraps>

80106683 <vector129>:
.globl vector129
vector129:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $129
80106685:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010668a:	e9 bf f6 ff ff       	jmp    80105d4e <alltraps>

8010668f <vector130>:
.globl vector130
vector130:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $130
80106691:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106696:	e9 b3 f6 ff ff       	jmp    80105d4e <alltraps>

8010669b <vector131>:
.globl vector131
vector131:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $131
8010669d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801066a2:	e9 a7 f6 ff ff       	jmp    80105d4e <alltraps>

801066a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $132
801066a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801066ae:	e9 9b f6 ff ff       	jmp    80105d4e <alltraps>

801066b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $133
801066b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801066ba:	e9 8f f6 ff ff       	jmp    80105d4e <alltraps>

801066bf <vector134>:
.globl vector134
vector134:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $134
801066c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801066c6:	e9 83 f6 ff ff       	jmp    80105d4e <alltraps>

801066cb <vector135>:
.globl vector135
vector135:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $135
801066cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801066d2:	e9 77 f6 ff ff       	jmp    80105d4e <alltraps>

801066d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $136
801066d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801066de:	e9 6b f6 ff ff       	jmp    80105d4e <alltraps>

801066e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $137
801066e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801066ea:	e9 5f f6 ff ff       	jmp    80105d4e <alltraps>

801066ef <vector138>:
.globl vector138
vector138:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $138
801066f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801066f6:	e9 53 f6 ff ff       	jmp    80105d4e <alltraps>

801066fb <vector139>:
.globl vector139
vector139:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $139
801066fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106702:	e9 47 f6 ff ff       	jmp    80105d4e <alltraps>

80106707 <vector140>:
.globl vector140
vector140:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $140
80106709:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010670e:	e9 3b f6 ff ff       	jmp    80105d4e <alltraps>

80106713 <vector141>:
.globl vector141
vector141:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $141
80106715:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010671a:	e9 2f f6 ff ff       	jmp    80105d4e <alltraps>

8010671f <vector142>:
.globl vector142
vector142:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $142
80106721:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106726:	e9 23 f6 ff ff       	jmp    80105d4e <alltraps>

8010672b <vector143>:
.globl vector143
vector143:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $143
8010672d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106732:	e9 17 f6 ff ff       	jmp    80105d4e <alltraps>

80106737 <vector144>:
.globl vector144
vector144:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $144
80106739:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010673e:	e9 0b f6 ff ff       	jmp    80105d4e <alltraps>

80106743 <vector145>:
.globl vector145
vector145:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $145
80106745:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010674a:	e9 ff f5 ff ff       	jmp    80105d4e <alltraps>

8010674f <vector146>:
.globl vector146
vector146:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $146
80106751:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106756:	e9 f3 f5 ff ff       	jmp    80105d4e <alltraps>

8010675b <vector147>:
.globl vector147
vector147:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $147
8010675d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106762:	e9 e7 f5 ff ff       	jmp    80105d4e <alltraps>

80106767 <vector148>:
.globl vector148
vector148:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $148
80106769:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010676e:	e9 db f5 ff ff       	jmp    80105d4e <alltraps>

80106773 <vector149>:
.globl vector149
vector149:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $149
80106775:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010677a:	e9 cf f5 ff ff       	jmp    80105d4e <alltraps>

8010677f <vector150>:
.globl vector150
vector150:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $150
80106781:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106786:	e9 c3 f5 ff ff       	jmp    80105d4e <alltraps>

8010678b <vector151>:
.globl vector151
vector151:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $151
8010678d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106792:	e9 b7 f5 ff ff       	jmp    80105d4e <alltraps>

80106797 <vector152>:
.globl vector152
vector152:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $152
80106799:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010679e:	e9 ab f5 ff ff       	jmp    80105d4e <alltraps>

801067a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $153
801067a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801067aa:	e9 9f f5 ff ff       	jmp    80105d4e <alltraps>

801067af <vector154>:
.globl vector154
vector154:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $154
801067b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801067b6:	e9 93 f5 ff ff       	jmp    80105d4e <alltraps>

801067bb <vector155>:
.globl vector155
vector155:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $155
801067bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801067c2:	e9 87 f5 ff ff       	jmp    80105d4e <alltraps>

801067c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $156
801067c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801067ce:	e9 7b f5 ff ff       	jmp    80105d4e <alltraps>

801067d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $157
801067d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801067da:	e9 6f f5 ff ff       	jmp    80105d4e <alltraps>

801067df <vector158>:
.globl vector158
vector158:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $158
801067e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801067e6:	e9 63 f5 ff ff       	jmp    80105d4e <alltraps>

801067eb <vector159>:
.globl vector159
vector159:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $159
801067ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801067f2:	e9 57 f5 ff ff       	jmp    80105d4e <alltraps>

801067f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $160
801067f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801067fe:	e9 4b f5 ff ff       	jmp    80105d4e <alltraps>

80106803 <vector161>:
.globl vector161
vector161:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $161
80106805:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010680a:	e9 3f f5 ff ff       	jmp    80105d4e <alltraps>

8010680f <vector162>:
.globl vector162
vector162:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $162
80106811:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106816:	e9 33 f5 ff ff       	jmp    80105d4e <alltraps>

8010681b <vector163>:
.globl vector163
vector163:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $163
8010681d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106822:	e9 27 f5 ff ff       	jmp    80105d4e <alltraps>

80106827 <vector164>:
.globl vector164
vector164:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $164
80106829:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010682e:	e9 1b f5 ff ff       	jmp    80105d4e <alltraps>

80106833 <vector165>:
.globl vector165
vector165:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $165
80106835:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010683a:	e9 0f f5 ff ff       	jmp    80105d4e <alltraps>

8010683f <vector166>:
.globl vector166
vector166:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $166
80106841:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106846:	e9 03 f5 ff ff       	jmp    80105d4e <alltraps>

8010684b <vector167>:
.globl vector167
vector167:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $167
8010684d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106852:	e9 f7 f4 ff ff       	jmp    80105d4e <alltraps>

80106857 <vector168>:
.globl vector168
vector168:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $168
80106859:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010685e:	e9 eb f4 ff ff       	jmp    80105d4e <alltraps>

80106863 <vector169>:
.globl vector169
vector169:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $169
80106865:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010686a:	e9 df f4 ff ff       	jmp    80105d4e <alltraps>

8010686f <vector170>:
.globl vector170
vector170:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $170
80106871:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106876:	e9 d3 f4 ff ff       	jmp    80105d4e <alltraps>

8010687b <vector171>:
.globl vector171
vector171:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $171
8010687d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106882:	e9 c7 f4 ff ff       	jmp    80105d4e <alltraps>

80106887 <vector172>:
.globl vector172
vector172:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $172
80106889:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010688e:	e9 bb f4 ff ff       	jmp    80105d4e <alltraps>

80106893 <vector173>:
.globl vector173
vector173:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $173
80106895:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010689a:	e9 af f4 ff ff       	jmp    80105d4e <alltraps>

8010689f <vector174>:
.globl vector174
vector174:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $174
801068a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801068a6:	e9 a3 f4 ff ff       	jmp    80105d4e <alltraps>

801068ab <vector175>:
.globl vector175
vector175:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $175
801068ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801068b2:	e9 97 f4 ff ff       	jmp    80105d4e <alltraps>

801068b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $176
801068b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801068be:	e9 8b f4 ff ff       	jmp    80105d4e <alltraps>

801068c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $177
801068c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801068ca:	e9 7f f4 ff ff       	jmp    80105d4e <alltraps>

801068cf <vector178>:
.globl vector178
vector178:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $178
801068d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801068d6:	e9 73 f4 ff ff       	jmp    80105d4e <alltraps>

801068db <vector179>:
.globl vector179
vector179:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $179
801068dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801068e2:	e9 67 f4 ff ff       	jmp    80105d4e <alltraps>

801068e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $180
801068e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801068ee:	e9 5b f4 ff ff       	jmp    80105d4e <alltraps>

801068f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $181
801068f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801068fa:	e9 4f f4 ff ff       	jmp    80105d4e <alltraps>

801068ff <vector182>:
.globl vector182
vector182:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $182
80106901:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106906:	e9 43 f4 ff ff       	jmp    80105d4e <alltraps>

8010690b <vector183>:
.globl vector183
vector183:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $183
8010690d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106912:	e9 37 f4 ff ff       	jmp    80105d4e <alltraps>

80106917 <vector184>:
.globl vector184
vector184:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $184
80106919:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010691e:	e9 2b f4 ff ff       	jmp    80105d4e <alltraps>

80106923 <vector185>:
.globl vector185
vector185:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $185
80106925:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010692a:	e9 1f f4 ff ff       	jmp    80105d4e <alltraps>

8010692f <vector186>:
.globl vector186
vector186:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $186
80106931:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106936:	e9 13 f4 ff ff       	jmp    80105d4e <alltraps>

8010693b <vector187>:
.globl vector187
vector187:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $187
8010693d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106942:	e9 07 f4 ff ff       	jmp    80105d4e <alltraps>

80106947 <vector188>:
.globl vector188
vector188:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $188
80106949:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010694e:	e9 fb f3 ff ff       	jmp    80105d4e <alltraps>

80106953 <vector189>:
.globl vector189
vector189:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $189
80106955:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010695a:	e9 ef f3 ff ff       	jmp    80105d4e <alltraps>

8010695f <vector190>:
.globl vector190
vector190:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $190
80106961:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106966:	e9 e3 f3 ff ff       	jmp    80105d4e <alltraps>

8010696b <vector191>:
.globl vector191
vector191:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $191
8010696d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106972:	e9 d7 f3 ff ff       	jmp    80105d4e <alltraps>

80106977 <vector192>:
.globl vector192
vector192:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $192
80106979:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010697e:	e9 cb f3 ff ff       	jmp    80105d4e <alltraps>

80106983 <vector193>:
.globl vector193
vector193:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $193
80106985:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010698a:	e9 bf f3 ff ff       	jmp    80105d4e <alltraps>

8010698f <vector194>:
.globl vector194
vector194:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $194
80106991:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106996:	e9 b3 f3 ff ff       	jmp    80105d4e <alltraps>

8010699b <vector195>:
.globl vector195
vector195:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $195
8010699d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801069a2:	e9 a7 f3 ff ff       	jmp    80105d4e <alltraps>

801069a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $196
801069a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801069ae:	e9 9b f3 ff ff       	jmp    80105d4e <alltraps>

801069b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $197
801069b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801069ba:	e9 8f f3 ff ff       	jmp    80105d4e <alltraps>

801069bf <vector198>:
.globl vector198
vector198:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $198
801069c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801069c6:	e9 83 f3 ff ff       	jmp    80105d4e <alltraps>

801069cb <vector199>:
.globl vector199
vector199:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $199
801069cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801069d2:	e9 77 f3 ff ff       	jmp    80105d4e <alltraps>

801069d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $200
801069d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801069de:	e9 6b f3 ff ff       	jmp    80105d4e <alltraps>

801069e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $201
801069e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801069ea:	e9 5f f3 ff ff       	jmp    80105d4e <alltraps>

801069ef <vector202>:
.globl vector202
vector202:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $202
801069f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801069f6:	e9 53 f3 ff ff       	jmp    80105d4e <alltraps>

801069fb <vector203>:
.globl vector203
vector203:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $203
801069fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106a02:	e9 47 f3 ff ff       	jmp    80105d4e <alltraps>

80106a07 <vector204>:
.globl vector204
vector204:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $204
80106a09:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106a0e:	e9 3b f3 ff ff       	jmp    80105d4e <alltraps>

80106a13 <vector205>:
.globl vector205
vector205:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $205
80106a15:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106a1a:	e9 2f f3 ff ff       	jmp    80105d4e <alltraps>

80106a1f <vector206>:
.globl vector206
vector206:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $206
80106a21:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106a26:	e9 23 f3 ff ff       	jmp    80105d4e <alltraps>

80106a2b <vector207>:
.globl vector207
vector207:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $207
80106a2d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106a32:	e9 17 f3 ff ff       	jmp    80105d4e <alltraps>

80106a37 <vector208>:
.globl vector208
vector208:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $208
80106a39:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106a3e:	e9 0b f3 ff ff       	jmp    80105d4e <alltraps>

80106a43 <vector209>:
.globl vector209
vector209:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $209
80106a45:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106a4a:	e9 ff f2 ff ff       	jmp    80105d4e <alltraps>

80106a4f <vector210>:
.globl vector210
vector210:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $210
80106a51:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106a56:	e9 f3 f2 ff ff       	jmp    80105d4e <alltraps>

80106a5b <vector211>:
.globl vector211
vector211:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $211
80106a5d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106a62:	e9 e7 f2 ff ff       	jmp    80105d4e <alltraps>

80106a67 <vector212>:
.globl vector212
vector212:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $212
80106a69:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106a6e:	e9 db f2 ff ff       	jmp    80105d4e <alltraps>

80106a73 <vector213>:
.globl vector213
vector213:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $213
80106a75:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106a7a:	e9 cf f2 ff ff       	jmp    80105d4e <alltraps>

80106a7f <vector214>:
.globl vector214
vector214:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $214
80106a81:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106a86:	e9 c3 f2 ff ff       	jmp    80105d4e <alltraps>

80106a8b <vector215>:
.globl vector215
vector215:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $215
80106a8d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106a92:	e9 b7 f2 ff ff       	jmp    80105d4e <alltraps>

80106a97 <vector216>:
.globl vector216
vector216:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $216
80106a99:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106a9e:	e9 ab f2 ff ff       	jmp    80105d4e <alltraps>

80106aa3 <vector217>:
.globl vector217
vector217:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $217
80106aa5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106aaa:	e9 9f f2 ff ff       	jmp    80105d4e <alltraps>

80106aaf <vector218>:
.globl vector218
vector218:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $218
80106ab1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106ab6:	e9 93 f2 ff ff       	jmp    80105d4e <alltraps>

80106abb <vector219>:
.globl vector219
vector219:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $219
80106abd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106ac2:	e9 87 f2 ff ff       	jmp    80105d4e <alltraps>

80106ac7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $220
80106ac9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106ace:	e9 7b f2 ff ff       	jmp    80105d4e <alltraps>

80106ad3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $221
80106ad5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106ada:	e9 6f f2 ff ff       	jmp    80105d4e <alltraps>

80106adf <vector222>:
.globl vector222
vector222:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $222
80106ae1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106ae6:	e9 63 f2 ff ff       	jmp    80105d4e <alltraps>

80106aeb <vector223>:
.globl vector223
vector223:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $223
80106aed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106af2:	e9 57 f2 ff ff       	jmp    80105d4e <alltraps>

80106af7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $224
80106af9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106afe:	e9 4b f2 ff ff       	jmp    80105d4e <alltraps>

80106b03 <vector225>:
.globl vector225
vector225:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $225
80106b05:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106b0a:	e9 3f f2 ff ff       	jmp    80105d4e <alltraps>

80106b0f <vector226>:
.globl vector226
vector226:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $226
80106b11:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106b16:	e9 33 f2 ff ff       	jmp    80105d4e <alltraps>

80106b1b <vector227>:
.globl vector227
vector227:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $227
80106b1d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106b22:	e9 27 f2 ff ff       	jmp    80105d4e <alltraps>

80106b27 <vector228>:
.globl vector228
vector228:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $228
80106b29:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106b2e:	e9 1b f2 ff ff       	jmp    80105d4e <alltraps>

80106b33 <vector229>:
.globl vector229
vector229:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $229
80106b35:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106b3a:	e9 0f f2 ff ff       	jmp    80105d4e <alltraps>

80106b3f <vector230>:
.globl vector230
vector230:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $230
80106b41:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106b46:	e9 03 f2 ff ff       	jmp    80105d4e <alltraps>

80106b4b <vector231>:
.globl vector231
vector231:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $231
80106b4d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106b52:	e9 f7 f1 ff ff       	jmp    80105d4e <alltraps>

80106b57 <vector232>:
.globl vector232
vector232:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $232
80106b59:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106b5e:	e9 eb f1 ff ff       	jmp    80105d4e <alltraps>

80106b63 <vector233>:
.globl vector233
vector233:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $233
80106b65:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106b6a:	e9 df f1 ff ff       	jmp    80105d4e <alltraps>

80106b6f <vector234>:
.globl vector234
vector234:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $234
80106b71:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106b76:	e9 d3 f1 ff ff       	jmp    80105d4e <alltraps>

80106b7b <vector235>:
.globl vector235
vector235:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $235
80106b7d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106b82:	e9 c7 f1 ff ff       	jmp    80105d4e <alltraps>

80106b87 <vector236>:
.globl vector236
vector236:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $236
80106b89:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106b8e:	e9 bb f1 ff ff       	jmp    80105d4e <alltraps>

80106b93 <vector237>:
.globl vector237
vector237:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $237
80106b95:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106b9a:	e9 af f1 ff ff       	jmp    80105d4e <alltraps>

80106b9f <vector238>:
.globl vector238
vector238:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $238
80106ba1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106ba6:	e9 a3 f1 ff ff       	jmp    80105d4e <alltraps>

80106bab <vector239>:
.globl vector239
vector239:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $239
80106bad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106bb2:	e9 97 f1 ff ff       	jmp    80105d4e <alltraps>

80106bb7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $240
80106bb9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106bbe:	e9 8b f1 ff ff       	jmp    80105d4e <alltraps>

80106bc3 <vector241>:
.globl vector241
vector241:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $241
80106bc5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106bca:	e9 7f f1 ff ff       	jmp    80105d4e <alltraps>

80106bcf <vector242>:
.globl vector242
vector242:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $242
80106bd1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106bd6:	e9 73 f1 ff ff       	jmp    80105d4e <alltraps>

80106bdb <vector243>:
.globl vector243
vector243:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $243
80106bdd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106be2:	e9 67 f1 ff ff       	jmp    80105d4e <alltraps>

80106be7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $244
80106be9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106bee:	e9 5b f1 ff ff       	jmp    80105d4e <alltraps>

80106bf3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $245
80106bf5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106bfa:	e9 4f f1 ff ff       	jmp    80105d4e <alltraps>

80106bff <vector246>:
.globl vector246
vector246:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $246
80106c01:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106c06:	e9 43 f1 ff ff       	jmp    80105d4e <alltraps>

80106c0b <vector247>:
.globl vector247
vector247:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $247
80106c0d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106c12:	e9 37 f1 ff ff       	jmp    80105d4e <alltraps>

80106c17 <vector248>:
.globl vector248
vector248:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $248
80106c19:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106c1e:	e9 2b f1 ff ff       	jmp    80105d4e <alltraps>

80106c23 <vector249>:
.globl vector249
vector249:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $249
80106c25:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106c2a:	e9 1f f1 ff ff       	jmp    80105d4e <alltraps>

80106c2f <vector250>:
.globl vector250
vector250:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $250
80106c31:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106c36:	e9 13 f1 ff ff       	jmp    80105d4e <alltraps>

80106c3b <vector251>:
.globl vector251
vector251:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $251
80106c3d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106c42:	e9 07 f1 ff ff       	jmp    80105d4e <alltraps>

80106c47 <vector252>:
.globl vector252
vector252:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $252
80106c49:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106c4e:	e9 fb f0 ff ff       	jmp    80105d4e <alltraps>

80106c53 <vector253>:
.globl vector253
vector253:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $253
80106c55:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106c5a:	e9 ef f0 ff ff       	jmp    80105d4e <alltraps>

80106c5f <vector254>:
.globl vector254
vector254:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $254
80106c61:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106c66:	e9 e3 f0 ff ff       	jmp    80105d4e <alltraps>

80106c6b <vector255>:
.globl vector255
vector255:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $255
80106c6d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106c72:	e9 d7 f0 ff ff       	jmp    80105d4e <alltraps>
80106c77:	66 90                	xchg   %ax,%ax
80106c79:	66 90                	xchg   %ax,%ax
80106c7b:	66 90                	xchg   %ax,%ax
80106c7d:	66 90                	xchg   %ax,%ax
80106c7f:	90                   	nop

80106c80 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	57                   	push   %edi
80106c84:	89 c7                	mov    %eax,%edi
80106c86:	56                   	push   %esi
80106c87:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106c88:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106c8e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106c94:	83 ec 1c             	sub    $0x1c,%esp
80106c97:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106c9a:	39 d3                	cmp    %edx,%ebx
80106c9c:	73 75                	jae    80106d13 <deallocuvm.part.0+0x93>
80106c9e:	89 d6                	mov    %edx,%esi
80106ca0:	eb 16                	jmp    80106cb8 <deallocuvm.part.0+0x38>
80106ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
80106ca8:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106cae:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106cb4:	39 f3                	cmp    %esi,%ebx
80106cb6:	73 5b                	jae    80106d13 <deallocuvm.part.0+0x93>
  pde = &pgdir[PDX(va)];
80106cb8:	89 d8                	mov    %ebx,%eax
80106cba:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106cbd:	8b 04 87             	mov    (%edi,%eax,4),%eax
80106cc0:	a8 01                	test   $0x1,%al
80106cc2:	74 e4                	je     80106ca8 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106cc4:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106cc6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106ccb:	c1 e9 0a             	shr    $0xa,%ecx
80106cce:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106cd4:	8d 8c 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%ecx
    if(!pte)
80106cdb:	85 c9                	test   %ecx,%ecx
80106cdd:	74 c9                	je     80106ca8 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106cdf:	8b 01                	mov    (%ecx),%eax
80106ce1:	a8 01                	test   $0x1,%al
80106ce3:	74 c9                	je     80106cae <deallocuvm.part.0+0x2e>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106ce5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cea:	74 32                	je     80106d1e <deallocuvm.part.0+0x9e>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106cec:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106cef:	05 00 00 00 80       	add    $0x80000000,%eax
80106cf4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106cf7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106cfd:	50                   	push   %eax
80106cfe:	e8 ed b8 ff ff       	call   801025f0 <kfree>
      *pte = 0;
80106d03:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106d06:	83 c4 10             	add    $0x10,%esp
80106d09:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
  for(; a  < oldsz; a += PGSIZE){
80106d0f:	39 f3                	cmp    %esi,%ebx
80106d11:	72 a5                	jb     80106cb8 <deallocuvm.part.0+0x38>
    }
  }
  return newsz;
}
80106d13:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106d16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d19:	5b                   	pop    %ebx
80106d1a:	5e                   	pop    %esi
80106d1b:	5f                   	pop    %edi
80106d1c:	5d                   	pop    %ebp
80106d1d:	c3                   	ret    
        panic("kfree");
80106d1e:	83 ec 0c             	sub    $0xc,%esp
80106d21:	68 92 78 10 80       	push   $0x80107892
80106d26:	e8 55 96 ff ff       	call   80100380 <panic>
80106d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106d2f:	90                   	nop

80106d30 <mappages>:
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	57                   	push   %edi
80106d34:	56                   	push   %esi
80106d35:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106d36:	89 d3                	mov    %edx,%ebx
80106d38:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106d3e:	83 ec 1c             	sub    $0x1c,%esp
80106d41:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106d44:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106d48:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d4d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106d50:	8b 45 08             	mov    0x8(%ebp),%eax
80106d53:	29 d8                	sub    %ebx,%eax
80106d55:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d58:	eb 3d                	jmp    80106d97 <mappages+0x67>
80106d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106d60:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d62:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106d67:	c1 ea 0a             	shr    $0xa,%edx
80106d6a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106d70:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106d77:	85 d2                	test   %edx,%edx
80106d79:	74 75                	je     80106df0 <mappages+0xc0>
    if(*pte & PTE_P)
80106d7b:	f6 02 01             	testb  $0x1,(%edx)
80106d7e:	0f 85 86 00 00 00    	jne    80106e0a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106d84:	0b 75 0c             	or     0xc(%ebp),%esi
80106d87:	83 ce 01             	or     $0x1,%esi
80106d8a:	89 32                	mov    %esi,(%edx)
    if(a == last)
80106d8c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80106d8f:	74 6f                	je     80106e00 <mappages+0xd0>
    a += PGSIZE;
80106d91:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106d97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106d9a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106d9d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80106da0:	89 d8                	mov    %ebx,%eax
80106da2:	c1 e8 16             	shr    $0x16,%eax
80106da5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106da8:	8b 07                	mov    (%edi),%eax
80106daa:	a8 01                	test   $0x1,%al
80106dac:	75 b2                	jne    80106d60 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106dae:	e8 fd b9 ff ff       	call   801027b0 <kalloc>
80106db3:	85 c0                	test   %eax,%eax
80106db5:	74 39                	je     80106df0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106db7:	83 ec 04             	sub    $0x4,%esp
80106dba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106dbd:	68 00 10 00 00       	push   $0x1000
80106dc2:	6a 00                	push   $0x0
80106dc4:	50                   	push   %eax
80106dc5:	e8 a6 dc ff ff       	call   80104a70 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106dca:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106dcd:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106dd0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106dd6:	83 c8 07             	or     $0x7,%eax
80106dd9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106ddb:	89 d8                	mov    %ebx,%eax
80106ddd:	c1 e8 0a             	shr    $0xa,%eax
80106de0:	25 fc 0f 00 00       	and    $0xffc,%eax
80106de5:	01 c2                	add    %eax,%edx
80106de7:	eb 92                	jmp    80106d7b <mappages+0x4b>
80106de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80106df0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106df3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106df8:	5b                   	pop    %ebx
80106df9:	5e                   	pop    %esi
80106dfa:	5f                   	pop    %edi
80106dfb:	5d                   	pop    %ebp
80106dfc:	c3                   	ret    
80106dfd:	8d 76 00             	lea    0x0(%esi),%esi
80106e00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e03:	31 c0                	xor    %eax,%eax
}
80106e05:	5b                   	pop    %ebx
80106e06:	5e                   	pop    %esi
80106e07:	5f                   	pop    %edi
80106e08:	5d                   	pop    %ebp
80106e09:	c3                   	ret    
      panic("remap");
80106e0a:	83 ec 0c             	sub    $0xc,%esp
80106e0d:	68 68 7f 10 80       	push   $0x80107f68
80106e12:	e8 69 95 ff ff       	call   80100380 <panic>
80106e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e1e:	66 90                	xchg   %ax,%ax

80106e20 <seginit>:
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	53                   	push   %ebx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106e24:	31 db                	xor    %ebx,%ebx
{
80106e26:	83 ec 14             	sub    $0x14,%esp
  c = &cpus[cpunum()];
80106e29:	e8 f2 bb ff ff       	call   80102a20 <cpunum>
80106e2e:	69 d0 bc 00 00 00    	imul   $0xbc,%eax,%edx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106e34:	8d 82 a0 27 11 80    	lea    -0x7feed860(%edx),%eax
80106e3a:	8d 8a 54 28 11 80    	lea    -0x7feed7ac(%edx),%ecx
  lgdt(c->gdt, sizeof(c->gdt));
80106e40:	81 c2 10 28 11 80    	add    $0x80112810,%edx
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106e46:	66 89 98 88 00 00 00 	mov    %bx,0x88(%eax)
80106e4d:	89 cb                	mov    %ecx,%ebx
80106e4f:	66 89 88 8a 00 00 00 	mov    %cx,0x8a(%eax)
80106e56:	c1 e9 18             	shr    $0x18,%ecx
80106e59:	c1 eb 10             	shr    $0x10,%ebx
80106e5c:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)
  pd[0] = size-1;
80106e62:	b9 37 00 00 00       	mov    $0x37,%ecx
80106e67:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
80106e6b:	88 98 8c 00 00 00    	mov    %bl,0x8c(%eax)
80106e71:	bb 92 c0 ff ff       	mov    $0xffffc092,%ebx
  pd[1] = (uint)p;
80106e76:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106e7a:	c1 ea 10             	shr    $0x10,%edx
80106e7d:	66 89 55 f6          	mov    %dx,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106e81:	8d 55 f2             	lea    -0xe(%ebp),%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e84:	c7 40 78 ff ff 00 00 	movl   $0xffff,0x78(%eax)
80106e8b:	c7 40 7c 00 9a cf 00 	movl   $0xcf9a00,0x7c(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e92:	c7 80 80 00 00 00 ff 	movl   $0xffff,0x80(%eax)
80106e99:	ff 00 00 
80106e9c:	c7 80 84 00 00 00 00 	movl   $0xcf9200,0x84(%eax)
80106ea3:	92 cf 00 
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106ea6:	66 89 98 8d 00 00 00 	mov    %bx,0x8d(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ead:	c7 80 90 00 00 00 ff 	movl   $0xffff,0x90(%eax)
80106eb4:	ff 00 00 
80106eb7:	c7 80 94 00 00 00 00 	movl   $0xcffa00,0x94(%eax)
80106ebe:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ec1:	c7 80 98 00 00 00 ff 	movl   $0xffff,0x98(%eax)
80106ec8:	ff 00 00 
80106ecb:	c7 80 9c 00 00 00 00 	movl   $0xcff200,0x9c(%eax)
80106ed2:	f2 cf 00 
80106ed5:	0f 01 12             	lgdtl  (%edx)
  asm volatile("movw %0, %%gs" : : "r" (v));
80106ed8:	ba 18 00 00 00       	mov    $0x18,%edx
80106edd:	8e ea                	mov    %edx,%gs
  proc = 0;
80106edf:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106ee6:	00 00 00 00 
}
80106eea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c = &cpus[cpunum()];
80106eed:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
}
80106ef3:	c9                   	leave  
80106ef4:	c3                   	ret    
80106ef5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106f00 <setupkvm>:
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	56                   	push   %esi
80106f04:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106f05:	e8 a6 b8 ff ff       	call   801027b0 <kalloc>
80106f0a:	85 c0                	test   %eax,%eax
80106f0c:	74 52                	je     80106f60 <setupkvm+0x60>
  memset(pgdir, 0, PGSIZE);
80106f0e:	83 ec 04             	sub    $0x4,%esp
80106f11:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f13:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80106f18:	68 00 10 00 00       	push   $0x1000
80106f1d:	6a 00                	push   $0x0
80106f1f:	50                   	push   %eax
80106f20:	e8 4b db ff ff       	call   80104a70 <memset>
80106f25:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0)
80106f28:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f2b:	83 ec 08             	sub    $0x8,%esp
80106f2e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f31:	ff 73 0c             	pushl  0xc(%ebx)
80106f34:	8b 13                	mov    (%ebx),%edx
80106f36:	50                   	push   %eax
80106f37:	29 c1                	sub    %eax,%ecx
80106f39:	89 f0                	mov    %esi,%eax
80106f3b:	e8 f0 fd ff ff       	call   80106d30 <mappages>
80106f40:	83 c4 10             	add    $0x10,%esp
80106f43:	85 c0                	test   %eax,%eax
80106f45:	78 19                	js     80106f60 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f47:	83 c3 10             	add    $0x10,%ebx
80106f4a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80106f50:	75 d6                	jne    80106f28 <setupkvm+0x28>
}
80106f52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f55:	89 f0                	mov    %esi,%eax
80106f57:	5b                   	pop    %ebx
80106f58:	5e                   	pop    %esi
80106f59:	5d                   	pop    %ebp
80106f5a:	c3                   	ret    
80106f5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f5f:	90                   	nop
80106f60:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106f63:	31 f6                	xor    %esi,%esi
}
80106f65:	89 f0                	mov    %esi,%eax
80106f67:	5b                   	pop    %ebx
80106f68:	5e                   	pop    %esi
80106f69:	5d                   	pop    %ebp
80106f6a:	c3                   	ret    
80106f6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f6f:	90                   	nop

80106f70 <kvmalloc>:
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f76:	e8 85 ff ff ff       	call   80106f00 <setupkvm>
80106f7b:	a3 c4 52 11 80       	mov    %eax,0x801152c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f80:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106f85:	0f 22 d8             	mov    %eax,%cr3
}
80106f88:	c9                   	leave  
80106f89:	c3                   	ret    
80106f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f90 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f90:	a1 c4 52 11 80       	mov    0x801152c4,%eax
80106f95:	05 00 00 00 80       	add    $0x80000000,%eax
80106f9a:	0f 22 d8             	mov    %eax,%cr3
}
80106f9d:	c3                   	ret    
80106f9e:	66 90                	xchg   %ax,%ax

80106fa0 <switchuvm>:
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	53                   	push   %ebx
80106fa4:	83 ec 04             	sub    $0x4,%esp
80106fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80106faa:	e8 f1 d9 ff ff       	call   801049a0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106faf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106fb5:	b9 67 00 00 00       	mov    $0x67,%ecx
80106fba:	8d 50 08             	lea    0x8(%eax),%edx
80106fbd:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106fc4:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106fcb:	89 d1                	mov    %edx,%ecx
80106fcd:	c1 ea 18             	shr    $0x18,%edx
80106fd0:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106fd6:	ba 89 40 00 00       	mov    $0x4089,%edx
80106fdb:	c1 e9 10             	shr    $0x10,%ecx
80106fde:	66 89 90 a5 00 00 00 	mov    %dx,0xa5(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106fe5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106fec:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80106ff2:	b9 10 00 00 00       	mov    $0x10,%ecx
80106ff7:	66 89 48 10          	mov    %cx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106ffb:	8b 52 08             	mov    0x8(%edx),%edx
80106ffe:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107004:	89 50 0c             	mov    %edx,0xc(%eax)
  cpu->ts.iomb = (ushort) 0xFFFF;
80107007:	ba ff ff ff ff       	mov    $0xffffffff,%edx
8010700c:	66 89 50 6e          	mov    %dx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107010:	b8 30 00 00 00       	mov    $0x30,%eax
80107015:	0f 00 d8             	ltr    %ax
  if(p->pgdir == 0)
80107018:	8b 43 04             	mov    0x4(%ebx),%eax
8010701b:	85 c0                	test   %eax,%eax
8010701d:	74 11                	je     80107030 <switchuvm+0x90>
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010701f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107024:	0f 22 d8             	mov    %eax,%cr3
}
80107027:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010702a:	c9                   	leave  
  popcli();
8010702b:	e9 a0 d9 ff ff       	jmp    801049d0 <popcli>
    panic("switchuvm: no pgdir");
80107030:	83 ec 0c             	sub    $0xc,%esp
80107033:	68 6e 7f 10 80       	push   $0x80107f6e
80107038:	e8 43 93 ff ff       	call   80100380 <panic>
8010703d:	8d 76 00             	lea    0x0(%esi),%esi

80107040 <inituvm>:
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	57                   	push   %edi
80107044:	56                   	push   %esi
80107045:	53                   	push   %ebx
80107046:	83 ec 1c             	sub    $0x1c,%esp
80107049:	8b 45 0c             	mov    0xc(%ebp),%eax
8010704c:	8b 75 10             	mov    0x10(%ebp),%esi
8010704f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107052:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107055:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010705b:	77 4b                	ja     801070a8 <inituvm+0x68>
  mem = kalloc();
8010705d:	e8 4e b7 ff ff       	call   801027b0 <kalloc>
  memset(mem, 0, PGSIZE);
80107062:	83 ec 04             	sub    $0x4,%esp
80107065:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010706a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010706c:	6a 00                	push   $0x0
8010706e:	50                   	push   %eax
8010706f:	e8 fc d9 ff ff       	call   80104a70 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107074:	58                   	pop    %eax
80107075:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010707b:	5a                   	pop    %edx
8010707c:	6a 06                	push   $0x6
8010707e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107083:	31 d2                	xor    %edx,%edx
80107085:	50                   	push   %eax
80107086:	89 f8                	mov    %edi,%eax
80107088:	e8 a3 fc ff ff       	call   80106d30 <mappages>
  memmove(mem, init, sz);
8010708d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107090:	89 75 10             	mov    %esi,0x10(%ebp)
80107093:	83 c4 10             	add    $0x10,%esp
80107096:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107099:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010709c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010709f:	5b                   	pop    %ebx
801070a0:	5e                   	pop    %esi
801070a1:	5f                   	pop    %edi
801070a2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801070a3:	e9 68 da ff ff       	jmp    80104b10 <memmove>
    panic("inituvm: more than a page");
801070a8:	83 ec 0c             	sub    $0xc,%esp
801070ab:	68 82 7f 10 80       	push   $0x80107f82
801070b0:	e8 cb 92 ff ff       	call   80100380 <panic>
801070b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801070c0 <loaduvm>:
{
801070c0:	55                   	push   %ebp
801070c1:	89 e5                	mov    %esp,%ebp
801070c3:	57                   	push   %edi
801070c4:	56                   	push   %esi
801070c5:	53                   	push   %ebx
801070c6:	83 ec 1c             	sub    $0x1c,%esp
801070c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801070cc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801070cf:	a9 ff 0f 00 00       	test   $0xfff,%eax
801070d4:	0f 85 bb 00 00 00    	jne    80107195 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
801070da:	01 f0                	add    %esi,%eax
801070dc:	89 f3                	mov    %esi,%ebx
801070de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070e1:	8b 45 14             	mov    0x14(%ebp),%eax
801070e4:	01 f0                	add    %esi,%eax
801070e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801070e9:	85 f6                	test   %esi,%esi
801070eb:	0f 84 87 00 00 00    	je     80107178 <loaduvm+0xb8>
801070f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801070f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801070fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801070fe:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107100:	89 c2                	mov    %eax,%edx
80107102:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107105:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107108:	f6 c2 01             	test   $0x1,%dl
8010710b:	75 13                	jne    80107120 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010710d:	83 ec 0c             	sub    $0xc,%esp
80107110:	68 9c 7f 10 80       	push   $0x80107f9c
80107115:	e8 66 92 ff ff       	call   80100380 <panic>
8010711a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107120:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107123:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107129:	25 fc 0f 00 00       	and    $0xffc,%eax
8010712e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107135:	85 c0                	test   %eax,%eax
80107137:	74 d4                	je     8010710d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107139:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010713b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010713e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107143:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107148:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010714e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107151:	29 d9                	sub    %ebx,%ecx
80107153:	05 00 00 00 80       	add    $0x80000000,%eax
80107158:	57                   	push   %edi
80107159:	51                   	push   %ecx
8010715a:	50                   	push   %eax
8010715b:	ff 75 10             	pushl  0x10(%ebp)
8010715e:	e8 2d aa ff ff       	call   80101b90 <readi>
80107163:	83 c4 10             	add    $0x10,%esp
80107166:	39 f8                	cmp    %edi,%eax
80107168:	75 1e                	jne    80107188 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010716a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107170:	89 f0                	mov    %esi,%eax
80107172:	29 d8                	sub    %ebx,%eax
80107174:	39 c6                	cmp    %eax,%esi
80107176:	77 80                	ja     801070f8 <loaduvm+0x38>
}
80107178:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010717b:	31 c0                	xor    %eax,%eax
}
8010717d:	5b                   	pop    %ebx
8010717e:	5e                   	pop    %esi
8010717f:	5f                   	pop    %edi
80107180:	5d                   	pop    %ebp
80107181:	c3                   	ret    
80107182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107188:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010718b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107190:	5b                   	pop    %ebx
80107191:	5e                   	pop    %esi
80107192:	5f                   	pop    %edi
80107193:	5d                   	pop    %ebp
80107194:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107195:	83 ec 0c             	sub    $0xc,%esp
80107198:	68 40 80 10 80       	push   $0x80108040
8010719d:	e8 de 91 ff ff       	call   80100380 <panic>
801071a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801071b0 <allocuvm>:
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	57                   	push   %edi
801071b4:	56                   	push   %esi
801071b5:	53                   	push   %ebx
801071b6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801071b9:	8b 45 10             	mov    0x10(%ebp),%eax
{
801071bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801071bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071c2:	85 c0                	test   %eax,%eax
801071c4:	0f 88 b6 00 00 00    	js     80107280 <allocuvm+0xd0>
  if(newsz < oldsz)
801071ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
801071cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801071d0:	0f 82 9a 00 00 00    	jb     80107270 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801071d6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801071dc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801071e2:	39 75 10             	cmp    %esi,0x10(%ebp)
801071e5:	77 44                	ja     8010722b <allocuvm+0x7b>
801071e7:	e9 87 00 00 00       	jmp    80107273 <allocuvm+0xc3>
801071ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801071f0:	83 ec 04             	sub    $0x4,%esp
801071f3:	68 00 10 00 00       	push   $0x1000
801071f8:	6a 00                	push   $0x0
801071fa:	50                   	push   %eax
801071fb:	e8 70 d8 ff ff       	call   80104a70 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107200:	58                   	pop    %eax
80107201:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107207:	5a                   	pop    %edx
80107208:	6a 06                	push   $0x6
8010720a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010720f:	89 f2                	mov    %esi,%edx
80107211:	50                   	push   %eax
80107212:	89 f8                	mov    %edi,%eax
80107214:	e8 17 fb ff ff       	call   80106d30 <mappages>
80107219:	83 c4 10             	add    $0x10,%esp
8010721c:	85 c0                	test   %eax,%eax
8010721e:	78 78                	js     80107298 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107220:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107226:	39 75 10             	cmp    %esi,0x10(%ebp)
80107229:	76 48                	jbe    80107273 <allocuvm+0xc3>
    mem = kalloc();
8010722b:	e8 80 b5 ff ff       	call   801027b0 <kalloc>
80107230:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107232:	85 c0                	test   %eax,%eax
80107234:	75 ba                	jne    801071f0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107236:	83 ec 0c             	sub    $0xc,%esp
80107239:	68 ba 7f 10 80       	push   $0x80107fba
8010723e:	e8 3d 94 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
80107243:	8b 45 0c             	mov    0xc(%ebp),%eax
80107246:	83 c4 10             	add    $0x10,%esp
80107249:	39 45 10             	cmp    %eax,0x10(%ebp)
8010724c:	74 32                	je     80107280 <allocuvm+0xd0>
8010724e:	8b 55 10             	mov    0x10(%ebp),%edx
80107251:	89 c1                	mov    %eax,%ecx
80107253:	89 f8                	mov    %edi,%eax
80107255:	e8 26 fa ff ff       	call   80106c80 <deallocuvm.part.0>
      return 0;
8010725a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107261:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107264:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107267:	5b                   	pop    %ebx
80107268:	5e                   	pop    %esi
80107269:	5f                   	pop    %edi
8010726a:	5d                   	pop    %ebp
8010726b:	c3                   	ret    
8010726c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107270:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107273:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107276:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107279:	5b                   	pop    %ebx
8010727a:	5e                   	pop    %esi
8010727b:	5f                   	pop    %edi
8010727c:	5d                   	pop    %ebp
8010727d:	c3                   	ret    
8010727e:	66 90                	xchg   %ax,%ax
    return 0;
80107280:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107287:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010728a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010728d:	5b                   	pop    %ebx
8010728e:	5e                   	pop    %esi
8010728f:	5f                   	pop    %edi
80107290:	5d                   	pop    %ebp
80107291:	c3                   	ret    
80107292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107298:	83 ec 0c             	sub    $0xc,%esp
8010729b:	68 d2 7f 10 80       	push   $0x80107fd2
801072a0:	e8 db 93 ff ff       	call   80100680 <cprintf>
  if(newsz >= oldsz)
801072a5:	8b 45 0c             	mov    0xc(%ebp),%eax
801072a8:	83 c4 10             	add    $0x10,%esp
801072ab:	39 45 10             	cmp    %eax,0x10(%ebp)
801072ae:	74 0c                	je     801072bc <allocuvm+0x10c>
801072b0:	8b 55 10             	mov    0x10(%ebp),%edx
801072b3:	89 c1                	mov    %eax,%ecx
801072b5:	89 f8                	mov    %edi,%eax
801072b7:	e8 c4 f9 ff ff       	call   80106c80 <deallocuvm.part.0>
      kfree(mem);
801072bc:	83 ec 0c             	sub    $0xc,%esp
801072bf:	53                   	push   %ebx
801072c0:	e8 2b b3 ff ff       	call   801025f0 <kfree>
      return 0;
801072c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801072cc:	83 c4 10             	add    $0x10,%esp
}
801072cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072d5:	5b                   	pop    %ebx
801072d6:	5e                   	pop    %esi
801072d7:	5f                   	pop    %edi
801072d8:	5d                   	pop    %ebp
801072d9:	c3                   	ret    
801072da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801072e0 <deallocuvm>:
{
801072e0:	55                   	push   %ebp
801072e1:	89 e5                	mov    %esp,%ebp
801072e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801072e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801072e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801072ec:	39 d1                	cmp    %edx,%ecx
801072ee:	73 10                	jae    80107300 <deallocuvm+0x20>
}
801072f0:	5d                   	pop    %ebp
801072f1:	e9 8a f9 ff ff       	jmp    80106c80 <deallocuvm.part.0>
801072f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072fd:	8d 76 00             	lea    0x0(%esi),%esi
80107300:	89 d0                	mov    %edx,%eax
80107302:	5d                   	pop    %ebp
80107303:	c3                   	ret    
80107304:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010730b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010730f:	90                   	nop

80107310 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	57                   	push   %edi
80107314:	56                   	push   %esi
80107315:	53                   	push   %ebx
80107316:	83 ec 0c             	sub    $0xc,%esp
80107319:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010731c:	85 f6                	test   %esi,%esi
8010731e:	74 59                	je     80107379 <freevm+0x69>
  if(newsz >= oldsz)
80107320:	31 c9                	xor    %ecx,%ecx
80107322:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107327:	89 f0                	mov    %esi,%eax
80107329:	89 f3                	mov    %esi,%ebx
8010732b:	e8 50 f9 ff ff       	call   80106c80 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107330:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107336:	eb 0f                	jmp    80107347 <freevm+0x37>
80107338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010733f:	90                   	nop
80107340:	83 c3 04             	add    $0x4,%ebx
80107343:	39 df                	cmp    %ebx,%edi
80107345:	74 23                	je     8010736a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107347:	8b 03                	mov    (%ebx),%eax
80107349:	a8 01                	test   $0x1,%al
8010734b:	74 f3                	je     80107340 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010734d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107352:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107355:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107358:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010735d:	50                   	push   %eax
8010735e:	e8 8d b2 ff ff       	call   801025f0 <kfree>
80107363:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107366:	39 df                	cmp    %ebx,%edi
80107368:	75 dd                	jne    80107347 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010736a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010736d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107370:	5b                   	pop    %ebx
80107371:	5e                   	pop    %esi
80107372:	5f                   	pop    %edi
80107373:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107374:	e9 77 b2 ff ff       	jmp    801025f0 <kfree>
    panic("freevm: no pgdir");
80107379:	83 ec 0c             	sub    $0xc,%esp
8010737c:	68 ee 7f 10 80       	push   $0x80107fee
80107381:	e8 fa 8f ff ff       	call   80100380 <panic>
80107386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010738d:	8d 76 00             	lea    0x0(%esi),%esi

80107390 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107390:	55                   	push   %ebp
80107391:	89 e5                	mov    %esp,%ebp
80107393:	83 ec 08             	sub    $0x8,%esp
80107396:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107399:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010739c:	89 c1                	mov    %eax,%ecx
8010739e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801073a1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801073a4:	f6 c2 01             	test   $0x1,%dl
801073a7:	75 17                	jne    801073c0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801073a9:	83 ec 0c             	sub    $0xc,%esp
801073ac:	68 ff 7f 10 80       	push   $0x80107fff
801073b1:	e8 ca 8f ff ff       	call   80100380 <panic>
801073b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073bd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801073c0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801073c3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801073c9:	25 fc 0f 00 00       	and    $0xffc,%eax
801073ce:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801073d5:	85 c0                	test   %eax,%eax
801073d7:	74 d0                	je     801073a9 <clearpteu+0x19>
  *pte &= ~PTE_U;
801073d9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801073dc:	c9                   	leave  
801073dd:	c3                   	ret    
801073de:	66 90                	xchg   %ax,%ax

801073e0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801073e0:	55                   	push   %ebp
801073e1:	89 e5                	mov    %esp,%ebp
801073e3:	57                   	push   %edi
801073e4:	56                   	push   %esi
801073e5:	53                   	push   %ebx
801073e6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801073e9:	e8 12 fb ff ff       	call   80106f00 <setupkvm>
801073ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
801073f1:	85 c0                	test   %eax,%eax
801073f3:	0f 84 be 00 00 00    	je     801074b7 <copyuvm+0xd7>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801073f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801073fc:	85 c9                	test   %ecx,%ecx
801073fe:	0f 84 b3 00 00 00    	je     801074b7 <copyuvm+0xd7>
80107404:	31 f6                	xor    %esi,%esi
80107406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010740d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107410:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107413:	89 f0                	mov    %esi,%eax
80107415:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107418:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010741b:	a8 01                	test   $0x1,%al
8010741d:	75 11                	jne    80107430 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010741f:	83 ec 0c             	sub    $0xc,%esp
80107422:	68 09 80 10 80       	push   $0x80108009
80107427:	e8 54 8f ff ff       	call   80100380 <panic>
8010742c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107430:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107432:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107437:	c1 ea 0a             	shr    $0xa,%edx
8010743a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107440:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107447:	85 c0                	test   %eax,%eax
80107449:	74 d4                	je     8010741f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010744b:	8b 18                	mov    (%eax),%ebx
8010744d:	f6 c3 01             	test   $0x1,%bl
80107450:	0f 84 92 00 00 00    	je     801074e8 <copyuvm+0x108>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107456:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80107458:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
8010745e:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107464:	e8 47 b3 ff ff       	call   801027b0 <kalloc>
80107469:	85 c0                	test   %eax,%eax
8010746b:	74 5b                	je     801074c8 <copyuvm+0xe8>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
8010746d:	83 ec 04             	sub    $0x4,%esp
80107470:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107476:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107479:	68 00 10 00 00       	push   $0x1000
8010747e:	57                   	push   %edi
8010747f:	50                   	push   %eax
80107480:	e8 8b d6 ff ff       	call   80104b10 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107485:	58                   	pop    %eax
80107486:	5a                   	pop    %edx
80107487:	53                   	push   %ebx
80107488:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010748b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010748e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107493:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107499:	52                   	push   %edx
8010749a:	89 f2                	mov    %esi,%edx
8010749c:	e8 8f f8 ff ff       	call   80106d30 <mappages>
801074a1:	83 c4 10             	add    $0x10,%esp
801074a4:	85 c0                	test   %eax,%eax
801074a6:	78 20                	js     801074c8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801074a8:	81 c6 00 10 00 00    	add    $0x1000,%esi
801074ae:	39 75 0c             	cmp    %esi,0xc(%ebp)
801074b1:	0f 87 59 ff ff ff    	ja     80107410 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801074b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074bd:	5b                   	pop    %ebx
801074be:	5e                   	pop    %esi
801074bf:	5f                   	pop    %edi
801074c0:	5d                   	pop    %ebp
801074c1:	c3                   	ret    
801074c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(d);
801074c8:	83 ec 0c             	sub    $0xc,%esp
801074cb:	ff 75 e0             	pushl  -0x20(%ebp)
801074ce:	e8 3d fe ff ff       	call   80107310 <freevm>
  return 0;
801074d3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801074da:	83 c4 10             	add    $0x10,%esp
}
801074dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
801074e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074e3:	5b                   	pop    %ebx
801074e4:	5e                   	pop    %esi
801074e5:	5f                   	pop    %edi
801074e6:	5d                   	pop    %ebp
801074e7:	c3                   	ret    
      panic("copyuvm: page not present");
801074e8:	83 ec 0c             	sub    $0xc,%esp
801074eb:	68 23 80 10 80       	push   $0x80108023
801074f0:	e8 8b 8e ff ff       	call   80100380 <panic>
801074f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107500 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107506:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107509:	89 c1                	mov    %eax,%ecx
8010750b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010750e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107511:	f6 c2 01             	test   $0x1,%dl
80107514:	0f 84 00 01 00 00    	je     8010761a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010751a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010751d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107523:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107524:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107529:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107530:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107532:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107537:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
8010753a:	05 00 00 00 80       	add    $0x80000000,%eax
8010753f:	83 fa 05             	cmp    $0x5,%edx
80107542:	ba 00 00 00 00       	mov    $0x0,%edx
80107547:	0f 45 c2             	cmovne %edx,%eax
}
8010754a:	c3                   	ret    
8010754b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010754f:	90                   	nop

80107550 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	53                   	push   %ebx
80107556:	83 ec 0c             	sub    $0xc,%esp
80107559:	8b 75 14             	mov    0x14(%ebp),%esi
8010755c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010755f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107562:	85 f6                	test   %esi,%esi
80107564:	75 51                	jne    801075b7 <copyout+0x67>
80107566:	e9 a5 00 00 00       	jmp    80107610 <copyout+0xc0>
8010756b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010756f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107570:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107576:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010757c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107582:	74 75                	je     801075f9 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107584:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107586:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107589:	29 c3                	sub    %eax,%ebx
8010758b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107591:	39 f3                	cmp    %esi,%ebx
80107593:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107596:	29 f8                	sub    %edi,%eax
80107598:	83 ec 04             	sub    $0x4,%esp
8010759b:	01 c8                	add    %ecx,%eax
8010759d:	53                   	push   %ebx
8010759e:	52                   	push   %edx
8010759f:	50                   	push   %eax
801075a0:	e8 6b d5 ff ff       	call   80104b10 <memmove>
    len -= n;
    buf += n;
801075a5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801075a8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801075ae:	83 c4 10             	add    $0x10,%esp
    buf += n;
801075b1:	01 da                	add    %ebx,%edx
  while(len > 0){
801075b3:	29 de                	sub    %ebx,%esi
801075b5:	74 59                	je     80107610 <copyout+0xc0>
  if(*pde & PTE_P){
801075b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801075ba:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801075bc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801075be:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801075c1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801075c7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801075ca:	f6 c1 01             	test   $0x1,%cl
801075cd:	0f 84 4e 00 00 00    	je     80107621 <copyout.cold>
  return &pgtab[PTX(va)];
801075d3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075d5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801075db:	c1 eb 0c             	shr    $0xc,%ebx
801075de:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801075e4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801075eb:	89 d9                	mov    %ebx,%ecx
801075ed:	83 e1 05             	and    $0x5,%ecx
801075f0:	83 f9 05             	cmp    $0x5,%ecx
801075f3:	0f 84 77 ff ff ff    	je     80107570 <copyout+0x20>
  }
  return 0;
}
801075f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801075fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107601:	5b                   	pop    %ebx
80107602:	5e                   	pop    %esi
80107603:	5f                   	pop    %edi
80107604:	5d                   	pop    %ebp
80107605:	c3                   	ret    
80107606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010760d:	8d 76 00             	lea    0x0(%esi),%esi
80107610:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107613:	31 c0                	xor    %eax,%eax
}
80107615:	5b                   	pop    %ebx
80107616:	5e                   	pop    %esi
80107617:	5f                   	pop    %edi
80107618:	5d                   	pop    %ebp
80107619:	c3                   	ret    

8010761a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010761a:	a1 00 00 00 00       	mov    0x0,%eax
8010761f:	0f 0b                	ud2    

80107621 <copyout.cold>:
80107621:	a1 00 00 00 00       	mov    0x0,%eax
80107626:	0f 0b                	ud2    

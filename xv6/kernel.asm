
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
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
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
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 d0 2e 10 80       	mov    $0x80102ed0,%eax
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
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 40 6f 10 80       	push   $0x80106f40
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 e5 41 00 00       	call   80104240 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 6f 10 80       	push   $0x80106f47
80100097:	50                   	push   %eax
80100098:	e8 93 40 00 00       	call   80104130 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 77 41 00 00       	call   80104260 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
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
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 d9 42 00 00       	call   80104440 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 3f 00 00       	call   80104170 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 4d 1f 00 00       	call   801020d0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 4e 6f 10 80       	push   $0x80106f4e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 40 00 00       	call   80104210 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 07 1f 00 00       	jmp    801020d0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 5f 6f 10 80       	push   $0x80106f5f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 40 00 00       	call   80104210 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 3f 00 00       	call   801041d0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 50 40 00 00       	call   80104260 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 df 41 00 00       	jmp    80104440 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 6f 10 80       	push   $0x80106f66
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 bb 14 00 00       	call   80101740 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 cf 3f 00 00       	call   80104260 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002a6:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 c0 ff 10 80       	push   $0x8010ffc0
801002bd:	e8 1e 3b 00 00       	call   80103de0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(proc->killed){
801002d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002d8:	8b 40 24             	mov    0x24(%eax),%eax
801002db:	85 c0                	test   %eax,%eax
801002dd:	74 d1                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002df:	83 ec 0c             	sub    $0xc,%esp
801002e2:	68 20 a5 10 80       	push   $0x8010a520
801002e7:	e8 54 41 00 00       	call   80104440 <release>
        ilock(ip);
801002ec:	89 3c 24             	mov    %edi,(%esp)
801002ef:	e8 6c 13 00 00       	call   80101660 <ilock>
        return -1;
801002f4:	83 c4 10             	add    $0x10,%esp
801002f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002ff:	5b                   	pop    %ebx
80100300:	5e                   	pop    %esi
80100301:	5f                   	pop    %edi
80100302:	5d                   	pop    %ebp
80100303:	c3                   	ret    
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 40 ff 10 80 	movsbl -0x7fef00c0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 f5 40 00 00       	call   80104440 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 0d 13 00 00       	call   80101660 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a1                	jmp    801002fc <consoleread+0x8c>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100379:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
8010037f:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100386:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100389:	8d 5d d0             	lea    -0x30(%ebp),%ebx
8010038c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010038f:	0f b6 00             	movzbl (%eax),%eax
80100392:	50                   	push   %eax
80100393:	68 6d 6f 10 80       	push   $0x80106f6d
80100398:	e8 c3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039d:	58                   	pop    %eax
8010039e:	ff 75 08             	pushl  0x8(%ebp)
801003a1:	e8 ba 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a6:	c7 04 24 66 74 10 80 	movl   $0x80107466,(%esp)
801003ad:	e8 ae 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b2:	5a                   	pop    %edx
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	59                   	pop    %ecx
801003b7:	53                   	push   %ebx
801003b8:	50                   	push   %eax
801003b9:	e8 72 3f 00 00       	call   80104330 <getcallerpcs>
801003be:	83 c4 10             	add    $0x10,%esp
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c8:	83 ec 08             	sub    $0x8,%esp
801003cb:	ff 33                	pushl  (%ebx)
801003cd:	83 c3 04             	add    $0x4,%ebx
801003d0:	68 89 6f 10 80       	push   $0x80106f89
801003d5:	e8 86 02 00 00       	call   80100660 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003da:	83 c4 10             	add    $0x10,%esp
801003dd:	39 f3                	cmp    %esi,%ebx
801003df:	75 e7                	jne    801003c8 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003e1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e8:	00 00 00 
801003eb:	eb fe                	jmp    801003eb <panic+0x7b>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 21 57 00 00       	call   80105b40 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 68 56 00 00       	call   80105b40 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 5c 56 00 00       	call   80105b40 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 50 56 00 00       	call   80105b40 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 27 40 00 00       	call   80104540 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 62 3f 00 00       	call   80104490 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 8d 6f 10 80       	push   $0x80106f8d
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 b8 6f 10 80 	movzbl -0x7fef9048(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 2c 11 00 00       	call   80101740 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 40 3c 00 00       	call   80104260 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 f4 3d 00 00       	call   80104440 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 0b 10 00 00       	call   80101660 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 a5 10 80       	push   $0x8010a520
8010070d:	e8 2e 3d 00 00       	call   80104440 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 a0 6f 10 80       	mov    $0x80106fa0,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 a5 10 80       	push   $0x8010a520
801007c8:	e8 93 3a 00 00       	call   80104260 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 a7 6f 10 80       	push   $0x80106fa7
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 20 a5 10 80       	push   $0x8010a520
80100803:	e8 58 3a 00 00       	call   80104260 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100836:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 a5 10 80       	push   $0x8010a520
80100868:	e8 d3 3b 00 00       	call   80104440 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801008f1:	68 c0 ff 10 80       	push   $0x8010ffc0
801008f6:	e8 85 36 00 00       	call   80103f80 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010090d:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100934:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 f4 36 00 00       	jmp    80104070 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 b0 6f 10 80       	push   $0x80106fb0
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 8b 38 00 00       	call   80104240 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bc:	c7 05 8c 09 11 80 00 	movl   $0x80100600,0x8011098c
801009c3:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c6:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009cd:	02 10 80 
  cons.locking = 1;
801009d0:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009d7:	00 00 00 

  picenable(IRQ_KBD);
801009da:	e8 b1 28 00 00       	call   80103290 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009df:	58                   	pop    %eax
801009e0:	5a                   	pop    %edx
801009e1:	6a 00                	push   $0x0
801009e3:	6a 01                	push   $0x1
801009e5:	e8 a6 18 00 00       	call   80102290 <ioapicenable>
}
801009ea:	83 c4 10             	add    $0x10,%esp
801009ed:	c9                   	leave  
801009ee:	c3                   	ret    
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801009fc:	e8 bf 21 00 00       	call   80102bc0 <begin_op>

  if((ip = namei(path)) == 0){
80100a01:	83 ec 0c             	sub    $0xc,%esp
80100a04:	ff 75 08             	pushl  0x8(%ebp)
80100a07:	e8 84 14 00 00       	call   80101e90 <namei>
80100a0c:	83 c4 10             	add    $0x10,%esp
80100a0f:	85 c0                	test   %eax,%eax
80100a11:	0f 84 a3 01 00 00    	je     80100bba <exec+0x1ca>
    end_op();
    return -1;
  }
  ilock(ip);
80100a17:	83 ec 0c             	sub    $0xc,%esp
80100a1a:	89 c3                	mov    %eax,%ebx
80100a1c:	50                   	push   %eax
80100a1d:	e8 3e 0c 00 00       	call   80101660 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100a22:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a28:	6a 34                	push   $0x34
80100a2a:	6a 00                	push   $0x0
80100a2c:	50                   	push   %eax
80100a2d:	53                   	push   %ebx
80100a2e:	e8 ed 0e 00 00       	call   80101920 <readi>
80100a33:	83 c4 20             	add    $0x20,%esp
80100a36:	83 f8 33             	cmp    $0x33,%eax
80100a39:	77 25                	ja     80100a60 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a3b:	83 ec 0c             	sub    $0xc,%esp
80100a3e:	53                   	push   %ebx
80100a3f:	e8 8c 0e 00 00       	call   801018d0 <iunlockput>
    end_op();
80100a44:	e8 e7 21 00 00       	call   80102c30 <end_op>
80100a49:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a54:	5b                   	pop    %ebx
80100a55:	5e                   	pop    %esi
80100a56:	5f                   	pop    %edi
80100a57:	5d                   	pop    %ebp
80100a58:	c3                   	ret    
80100a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a60:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a67:	45 4c 46 
80100a6a:	75 cf                	jne    80100a3b <exec+0x4b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a6c:	e8 8f 5e 00 00       	call   80106900 <setupkvm>
80100a71:	85 c0                	test   %eax,%eax
80100a73:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a79:	74 c0                	je     80100a3b <exec+0x4b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a7b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a82:	00 
80100a83:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a89:	0f 84 a1 02 00 00    	je     80100d30 <exec+0x340>
80100a8f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a96:	00 00 00 
80100a99:	31 ff                	xor    %edi,%edi
80100a9b:	eb 18                	jmp    80100ab5 <exec+0xc5>
80100a9d:	8d 76 00             	lea    0x0(%esi),%esi
80100aa0:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aa7:	83 c7 01             	add    $0x1,%edi
80100aaa:	83 c6 20             	add    $0x20,%esi
80100aad:	39 f8                	cmp    %edi,%eax
80100aaf:	0f 8e ab 00 00 00    	jle    80100b60 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100ab5:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100abb:	6a 20                	push   $0x20
80100abd:	56                   	push   %esi
80100abe:	50                   	push   %eax
80100abf:	53                   	push   %ebx
80100ac0:	e8 5b 0e 00 00       	call   80101920 <readi>
80100ac5:	83 c4 10             	add    $0x10,%esp
80100ac8:	83 f8 20             	cmp    $0x20,%eax
80100acb:	75 7b                	jne    80100b48 <exec+0x158>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100acd:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ad4:	75 ca                	jne    80100aa0 <exec+0xb0>
      continue;
    if(ph.memsz < ph.filesz)
80100ad6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100adc:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ae2:	72 64                	jb     80100b48 <exec+0x158>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ae4:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100aea:	72 5c                	jb     80100b48 <exec+0x158>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aec:	83 ec 04             	sub    $0x4,%esp
80100aef:	50                   	push   %eax
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100afc:	e8 8f 60 00 00       	call   80106b90 <allocuvm>
80100b01:	83 c4 10             	add    $0x10,%esp
80100b04:	85 c0                	test   %eax,%eax
80100b06:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b0c:	74 3a                	je     80100b48 <exec+0x158>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b0e:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b14:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b19:	75 2d                	jne    80100b48 <exec+0x158>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b1b:	83 ec 0c             	sub    $0xc,%esp
80100b1e:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b24:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b2a:	53                   	push   %ebx
80100b2b:	50                   	push   %eax
80100b2c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b32:	e8 99 5f 00 00       	call   80106ad0 <loaduvm>
80100b37:	83 c4 20             	add    $0x20,%esp
80100b3a:	85 c0                	test   %eax,%eax
80100b3c:	0f 89 5e ff ff ff    	jns    80100aa0 <exec+0xb0>
80100b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b48:	83 ec 0c             	sub    $0xc,%esp
80100b4b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b51:	e8 6a 61 00 00       	call   80106cc0 <freevm>
80100b56:	83 c4 10             	add    $0x10,%esp
80100b59:	e9 dd fe ff ff       	jmp    80100a3b <exec+0x4b>
80100b5e:	66 90                	xchg   %ax,%ax
80100b60:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100b66:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100b6c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100b72:	8d be 00 20 00 00    	lea    0x2000(%esi),%edi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b78:	83 ec 0c             	sub    $0xc,%esp
80100b7b:	53                   	push   %ebx
80100b7c:	e8 4f 0d 00 00       	call   801018d0 <iunlockput>
  end_op();
80100b81:	e8 aa 20 00 00       	call   80102c30 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b86:	83 c4 0c             	add    $0xc,%esp
80100b89:	57                   	push   %edi
80100b8a:	56                   	push   %esi
80100b8b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b91:	e8 fa 5f 00 00       	call   80106b90 <allocuvm>
80100b96:	83 c4 10             	add    $0x10,%esp
80100b99:	85 c0                	test   %eax,%eax
80100b9b:	89 c6                	mov    %eax,%esi
80100b9d:	75 2a                	jne    80100bc9 <exec+0x1d9>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b9f:	83 ec 0c             	sub    $0xc,%esp
80100ba2:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba8:	e8 13 61 00 00       	call   80106cc0 <freevm>
80100bad:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb5:	e9 97 fe ff ff       	jmp    80100a51 <exec+0x61>
  pde_t *pgdir, *oldpgdir;

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bba:	e8 71 20 00 00       	call   80102c30 <end_op>
    return -1;
80100bbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc4:	e9 88 fe ff ff       	jmp    80100a51 <exec+0x61>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bc9:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bcf:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bd2:	31 ff                	xor    %edi,%edi
80100bd4:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd6:	50                   	push   %eax
80100bd7:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bdd:	e8 5e 61 00 00       	call   80106d40 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bee:	8b 00                	mov    (%eax),%eax
80100bf0:	85 c0                	test   %eax,%eax
80100bf2:	74 71                	je     80100c65 <exec+0x275>
80100bf4:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100bfa:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c00:	eb 0b                	jmp    80100c0d <exec+0x21d>
80100c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100c08:	83 ff 20             	cmp    $0x20,%edi
80100c0b:	74 92                	je     80100b9f <exec+0x1af>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c0d:	83 ec 0c             	sub    $0xc,%esp
80100c10:	50                   	push   %eax
80100c11:	e8 ba 3a 00 00       	call   801046d0 <strlen>
80100c16:	f7 d0                	not    %eax
80100c18:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c1a:	58                   	pop    %eax
80100c1b:	8b 45 0c             	mov    0xc(%ebp),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c1e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c21:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c24:	e8 a7 3a 00 00       	call   801046d0 <strlen>
80100c29:	83 c0 01             	add    $0x1,%eax
80100c2c:	50                   	push   %eax
80100c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c30:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c33:	53                   	push   %ebx
80100c34:	56                   	push   %esi
80100c35:	e8 66 62 00 00       	call   80106ea0 <copyout>
80100c3a:	83 c4 20             	add    $0x20,%esp
80100c3d:	85 c0                	test   %eax,%eax
80100c3f:	0f 88 5a ff ff ff    	js     80100b9f <exec+0x1af>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c45:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c48:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c4f:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c52:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c58:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c5b:	85 c0                	test   %eax,%eax
80100c5d:	75 a9                	jne    80100c08 <exec+0x218>
80100c5f:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c65:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c6c:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c6e:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c75:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c79:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c80:	ff ff ff 
  ustack[1] = argc;
80100c83:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c89:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c8b:	83 c0 0c             	add    $0xc,%eax
80100c8e:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c90:	50                   	push   %eax
80100c91:	52                   	push   %edx
80100c92:	53                   	push   %ebx
80100c93:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c99:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9f:	e8 fc 61 00 00       	call   80106ea0 <copyout>
80100ca4:	83 c4 10             	add    $0x10,%esp
80100ca7:	85 c0                	test   %eax,%eax
80100ca9:	0f 88 f0 fe ff ff    	js     80100b9f <exec+0x1af>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100caf:	8b 45 08             	mov    0x8(%ebp),%eax
80100cb2:	0f b6 10             	movzbl (%eax),%edx
80100cb5:	84 d2                	test   %dl,%dl
80100cb7:	74 1a                	je     80100cd3 <exec+0x2e3>
80100cb9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cbc:	83 c0 01             	add    $0x1,%eax
80100cbf:	90                   	nop
    if(*s == '/')
      last = s+1;
80100cc0:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cc3:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100cc6:	0f 44 c8             	cmove  %eax,%ecx
80100cc9:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ccc:	84 d2                	test   %dl,%dl
80100cce:	75 f0                	jne    80100cc0 <exec+0x2d0>
80100cd0:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100cd3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cd9:	83 ec 04             	sub    $0x4,%esp
80100cdc:	6a 10                	push   $0x10
80100cde:	ff 75 08             	pushl  0x8(%ebp)
80100ce1:	83 c0 6c             	add    $0x6c,%eax
80100ce4:	50                   	push   %eax
80100ce5:	e8 a6 39 00 00       	call   80104690 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100cf0:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cf6:	8b 78 04             	mov    0x4(%eax),%edi
  proc->pgdir = pgdir;
  proc->sz = sz;
80100cf9:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  proc->pgdir = pgdir;
80100cfb:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->sz = sz;
  proc->tf->eip = elf.entry;  // main
80100cfe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d04:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100d0a:	8b 50 18             	mov    0x18(%eax),%edx
80100d0d:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100d10:	8b 50 18             	mov    0x18(%eax),%edx
80100d13:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100d16:	89 04 24             	mov    %eax,(%esp)
80100d19:	e8 92 5c 00 00       	call   801069b0 <switchuvm>
  freevm(oldpgdir);
80100d1e:	89 3c 24             	mov    %edi,(%esp)
80100d21:	e8 9a 5f 00 00       	call   80106cc0 <freevm>
  return 0;
80100d26:	83 c4 10             	add    $0x10,%esp
80100d29:	31 c0                	xor    %eax,%eax
80100d2b:	e9 21 fd ff ff       	jmp    80100a51 <exec+0x61>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d30:	bf 00 20 00 00       	mov    $0x2000,%edi
80100d35:	31 f6                	xor    %esi,%esi
80100d37:	e9 3c fe ff ff       	jmp    80100b78 <exec+0x188>
80100d3c:	66 90                	xchg   %ax,%ax
80100d3e:	66 90                	xchg   %ax,%ax

80100d40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d46:	68 c9 6f 10 80       	push   $0x80106fc9
80100d4b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d50:	e8 eb 34 00 00       	call   80104240 <initlock>
}
80100d55:	83 c4 10             	add    $0x10,%esp
80100d58:	c9                   	leave  
80100d59:	c3                   	ret    
80100d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d64:	bb 14 00 11 80       	mov    $0x80110014,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d69:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d6c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d71:	e8 ea 34 00 00       	call   80104260 <acquire>
80100d76:	83 c4 10             	add    $0x10,%esp
80100d79:	eb 10                	jmp    80100d8b <filealloc+0x2b>
80100d7b:	90                   	nop
80100d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d80:	83 c3 18             	add    $0x18,%ebx
80100d83:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100d89:	74 25                	je     80100db0 <filealloc+0x50>
    if(f->ref == 0){
80100d8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d8e:	85 c0                	test   %eax,%eax
80100d90:	75 ee                	jne    80100d80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d92:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100d95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d9c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100da1:	e8 9a 36 00 00       	call   80104440 <release>
      return f;
80100da6:	89 d8                	mov    %ebx,%eax
80100da8:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dae:	c9                   	leave  
80100daf:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100db0:	83 ec 0c             	sub    $0xc,%esp
80100db3:	68 e0 ff 10 80       	push   $0x8010ffe0
80100db8:	e8 83 36 00 00       	call   80104440 <release>
  return 0;
80100dbd:	83 c4 10             	add    $0x10,%esp
80100dc0:	31 c0                	xor    %eax,%eax
}
80100dc2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dc5:	c9                   	leave  
80100dc6:	c3                   	ret    
80100dc7:	89 f6                	mov    %esi,%esi
80100dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100dd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	53                   	push   %ebx
80100dd4:	83 ec 10             	sub    $0x10,%esp
80100dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dda:	68 e0 ff 10 80       	push   $0x8010ffe0
80100ddf:	e8 7c 34 00 00       	call   80104260 <acquire>
  if(f->ref < 1)
80100de4:	8b 43 04             	mov    0x4(%ebx),%eax
80100de7:	83 c4 10             	add    $0x10,%esp
80100dea:	85 c0                	test   %eax,%eax
80100dec:	7e 1a                	jle    80100e08 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100df1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100df4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100df7:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dfc:	e8 3f 36 00 00       	call   80104440 <release>
  return f;
}
80100e01:	89 d8                	mov    %ebx,%eax
80100e03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e06:	c9                   	leave  
80100e07:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e08:	83 ec 0c             	sub    $0xc,%esp
80100e0b:	68 d0 6f 10 80       	push   $0x80106fd0
80100e10:	e8 5b f5 ff ff       	call   80100370 <panic>
80100e15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e20 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	57                   	push   %edi
80100e24:	56                   	push   %esi
80100e25:	53                   	push   %ebx
80100e26:	83 ec 28             	sub    $0x28,%esp
80100e29:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e2c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e31:	e8 2a 34 00 00       	call   80104260 <acquire>
  if(f->ref < 1)
80100e36:	8b 47 04             	mov    0x4(%edi),%eax
80100e39:	83 c4 10             	add    $0x10,%esp
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	0f 8e 9b 00 00 00    	jle    80100edf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e44:	83 e8 01             	sub    $0x1,%eax
80100e47:	85 c0                	test   %eax,%eax
80100e49:	89 47 04             	mov    %eax,0x4(%edi)
80100e4c:	74 1a                	je     80100e68 <fileclose+0x48>
    release(&ftable.lock);
80100e4e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e58:	5b                   	pop    %ebx
80100e59:	5e                   	pop    %esi
80100e5a:	5f                   	pop    %edi
80100e5b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e5c:	e9 df 35 00 00       	jmp    80104440 <release>
80100e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e68:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e6c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e6e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e71:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e74:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e7a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e7d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e80:	68 e0 ff 10 80       	push   $0x8010ffe0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e85:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e88:	e8 b3 35 00 00       	call   80104440 <release>

  if(ff.type == FD_PIPE)
80100e8d:	83 c4 10             	add    $0x10,%esp
80100e90:	83 fb 01             	cmp    $0x1,%ebx
80100e93:	74 13                	je     80100ea8 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e95:	83 fb 02             	cmp    $0x2,%ebx
80100e98:	74 26                	je     80100ec0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e9d:	5b                   	pop    %ebx
80100e9e:	5e                   	pop    %esi
80100e9f:	5f                   	pop    %edi
80100ea0:	5d                   	pop    %ebp
80100ea1:	c3                   	ret    
80100ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100ea8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100eac:	83 ec 08             	sub    $0x8,%esp
80100eaf:	53                   	push   %ebx
80100eb0:	56                   	push   %esi
80100eb1:	e8 aa 25 00 00       	call   80103460 <pipeclose>
80100eb6:	83 c4 10             	add    $0x10,%esp
80100eb9:	eb df                	jmp    80100e9a <fileclose+0x7a>
80100ebb:	90                   	nop
80100ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100ec0:	e8 fb 1c 00 00       	call   80102bc0 <begin_op>
    iput(ff.ip);
80100ec5:	83 ec 0c             	sub    $0xc,%esp
80100ec8:	ff 75 e0             	pushl  -0x20(%ebp)
80100ecb:	e8 c0 08 00 00       	call   80101790 <iput>
    end_op();
80100ed0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ed3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ed6:	5b                   	pop    %ebx
80100ed7:	5e                   	pop    %esi
80100ed8:	5f                   	pop    %edi
80100ed9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eda:	e9 51 1d 00 00       	jmp    80102c30 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100edf:	83 ec 0c             	sub    $0xc,%esp
80100ee2:	68 d8 6f 10 80       	push   $0x80106fd8
80100ee7:	e8 84 f4 ff ff       	call   80100370 <panic>
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 04             	sub    $0x4,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100efa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100efd:	75 31                	jne    80100f30 <filestat+0x40>
    ilock(f->ip);
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	ff 73 10             	pushl  0x10(%ebx)
80100f05:	e8 56 07 00 00       	call   80101660 <ilock>
    stati(f->ip, st);
80100f0a:	58                   	pop    %eax
80100f0b:	5a                   	pop    %edx
80100f0c:	ff 75 0c             	pushl  0xc(%ebp)
80100f0f:	ff 73 10             	pushl  0x10(%ebx)
80100f12:	e8 d9 09 00 00       	call   801018f0 <stati>
    iunlock(f->ip);
80100f17:	59                   	pop    %ecx
80100f18:	ff 73 10             	pushl  0x10(%ebx)
80100f1b:	e8 20 08 00 00       	call   80101740 <iunlock>
    return 0;
80100f20:	83 c4 10             	add    $0x10,%esp
80100f23:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f38:	c9                   	leave  
80100f39:	c3                   	ret    
80100f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 0c             	sub    $0xc,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f4f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f56:	74 60                	je     80100fb8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f58:	8b 03                	mov    (%ebx),%eax
80100f5a:	83 f8 01             	cmp    $0x1,%eax
80100f5d:	74 41                	je     80100fa0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f5f:	83 f8 02             	cmp    $0x2,%eax
80100f62:	75 5b                	jne    80100fbf <fileread+0x7f>
    ilock(f->ip);
80100f64:	83 ec 0c             	sub    $0xc,%esp
80100f67:	ff 73 10             	pushl  0x10(%ebx)
80100f6a:	e8 f1 06 00 00       	call   80101660 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f6f:	57                   	push   %edi
80100f70:	ff 73 14             	pushl  0x14(%ebx)
80100f73:	56                   	push   %esi
80100f74:	ff 73 10             	pushl  0x10(%ebx)
80100f77:	e8 a4 09 00 00       	call   80101920 <readi>
80100f7c:	83 c4 20             	add    $0x20,%esp
80100f7f:	85 c0                	test   %eax,%eax
80100f81:	89 c6                	mov    %eax,%esi
80100f83:	7e 03                	jle    80100f88 <fileread+0x48>
      f->off += r;
80100f85:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f88:	83 ec 0c             	sub    $0xc,%esp
80100f8b:	ff 73 10             	pushl  0x10(%ebx)
80100f8e:	e8 ad 07 00 00       	call   80101740 <iunlock>
    return r;
80100f93:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f96:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f9b:	5b                   	pop    %ebx
80100f9c:	5e                   	pop    %esi
80100f9d:	5f                   	pop    %edi
80100f9e:	5d                   	pop    %ebp
80100f9f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fa0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fa3:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fa6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa9:	5b                   	pop    %ebx
80100faa:	5e                   	pop    %esi
80100fab:	5f                   	pop    %edi
80100fac:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fad:	e9 7e 26 00 00       	jmp    80103630 <piperead>
80100fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fbd:	eb d9                	jmp    80100f98 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fbf:	83 ec 0c             	sub    $0xc,%esp
80100fc2:	68 e2 6f 10 80       	push   $0x80106fe2
80100fc7:	e8 a4 f3 ff ff       	call   80100370 <panic>
80100fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fd0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	57                   	push   %edi
80100fd4:	56                   	push   %esi
80100fd5:	53                   	push   %ebx
80100fd6:	83 ec 1c             	sub    $0x1c,%esp
80100fd9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fdf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fe6:	8b 45 10             	mov    0x10(%ebp),%eax
80100fe9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fec:	0f 84 aa 00 00 00    	je     8010109c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100ff2:	8b 06                	mov    (%esi),%eax
80100ff4:	83 f8 01             	cmp    $0x1,%eax
80100ff7:	0f 84 c2 00 00 00    	je     801010bf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100ffd:	83 f8 02             	cmp    $0x2,%eax
80101000:	0f 85 d8 00 00 00    	jne    801010de <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101006:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101009:	31 ff                	xor    %edi,%edi
8010100b:	85 c0                	test   %eax,%eax
8010100d:	7f 34                	jg     80101043 <filewrite+0x73>
8010100f:	e9 9c 00 00 00       	jmp    801010b0 <filewrite+0xe0>
80101014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101018:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010101b:	83 ec 0c             	sub    $0xc,%esp
8010101e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101021:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101024:	e8 17 07 00 00       	call   80101740 <iunlock>
      end_op();
80101029:	e8 02 1c 00 00       	call   80102c30 <end_op>
8010102e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101031:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101034:	39 d8                	cmp    %ebx,%eax
80101036:	0f 85 95 00 00 00    	jne    801010d1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010103c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010103e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101041:	7e 6d                	jle    801010b0 <filewrite+0xe0>
      int n1 = n - i;
80101043:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101046:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010104b:	29 fb                	sub    %edi,%ebx
8010104d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101053:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101056:	e8 65 1b 00 00       	call   80102bc0 <begin_op>
      ilock(f->ip);
8010105b:	83 ec 0c             	sub    $0xc,%esp
8010105e:	ff 76 10             	pushl  0x10(%esi)
80101061:	e8 fa 05 00 00       	call   80101660 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101066:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101069:	53                   	push   %ebx
8010106a:	ff 76 14             	pushl  0x14(%esi)
8010106d:	01 f8                	add    %edi,%eax
8010106f:	50                   	push   %eax
80101070:	ff 76 10             	pushl  0x10(%esi)
80101073:	e8 a8 09 00 00       	call   80101a20 <writei>
80101078:	83 c4 20             	add    $0x20,%esp
8010107b:	85 c0                	test   %eax,%eax
8010107d:	7f 99                	jg     80101018 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010107f:	83 ec 0c             	sub    $0xc,%esp
80101082:	ff 76 10             	pushl  0x10(%esi)
80101085:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101088:	e8 b3 06 00 00       	call   80101740 <iunlock>
      end_op();
8010108d:	e8 9e 1b 00 00       	call   80102c30 <end_op>

      if(r < 0)
80101092:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101095:	83 c4 10             	add    $0x10,%esp
80101098:	85 c0                	test   %eax,%eax
8010109a:	74 98                	je     80101034 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010109c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010109f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
801010a4:	5b                   	pop    %ebx
801010a5:	5e                   	pop    %esi
801010a6:	5f                   	pop    %edi
801010a7:	5d                   	pop    %ebp
801010a8:	c3                   	ret    
801010a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010b0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010b3:	75 e7                	jne    8010109c <filewrite+0xcc>
  }
  panic("filewrite");
}
801010b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010b8:	89 f8                	mov    %edi,%eax
801010ba:	5b                   	pop    %ebx
801010bb:	5e                   	pop    %esi
801010bc:	5f                   	pop    %edi
801010bd:	5d                   	pop    %ebp
801010be:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010bf:	8b 46 0c             	mov    0xc(%esi),%eax
801010c2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c8:	5b                   	pop    %ebx
801010c9:	5e                   	pop    %esi
801010ca:	5f                   	pop    %edi
801010cb:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010cc:	e9 2f 24 00 00       	jmp    80103500 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010d1:	83 ec 0c             	sub    $0xc,%esp
801010d4:	68 eb 6f 10 80       	push   $0x80106feb
801010d9:	e8 92 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010de:	83 ec 0c             	sub    $0xc,%esp
801010e1:	68 f1 6f 10 80       	push   $0x80106ff1
801010e6:	e8 85 f2 ff ff       	call   80100370 <panic>
801010eb:	66 90                	xchg   %ax,%ax
801010ed:	66 90                	xchg   %ax,%ax
801010ef:	90                   	nop

801010f0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010f0:	55                   	push   %ebp
801010f1:	89 e5                	mov    %esp,%ebp
801010f3:	57                   	push   %edi
801010f4:	56                   	push   %esi
801010f5:	53                   	push   %ebx
801010f6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010f9:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101102:	85 c9                	test   %ecx,%ecx
80101104:	0f 84 85 00 00 00    	je     8010118f <balloc+0x9f>
8010110a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101111:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101114:	83 ec 08             	sub    $0x8,%esp
80101117:	89 f0                	mov    %esi,%eax
80101119:	c1 f8 0c             	sar    $0xc,%eax
8010111c:	03 05 f8 09 11 80    	add    0x801109f8,%eax
80101122:	50                   	push   %eax
80101123:	ff 75 d8             	pushl  -0x28(%ebp)
80101126:	e8 a5 ef ff ff       	call   801000d0 <bread>
8010112b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010112e:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101133:	83 c4 10             	add    $0x10,%esp
80101136:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101139:	31 c0                	xor    %eax,%eax
8010113b:	eb 2d                	jmp    8010116a <balloc+0x7a>
8010113d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101140:	89 c1                	mov    %eax,%ecx
80101142:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101147:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010114a:	83 e1 07             	and    $0x7,%ecx
8010114d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010114f:	89 c1                	mov    %eax,%ecx
80101151:	c1 f9 03             	sar    $0x3,%ecx
80101154:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101159:	85 d7                	test   %edx,%edi
8010115b:	74 43                	je     801011a0 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010115d:	83 c0 01             	add    $0x1,%eax
80101160:	83 c6 01             	add    $0x1,%esi
80101163:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101168:	74 05                	je     8010116f <balloc+0x7f>
8010116a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010116d:	72 d1                	jb     80101140 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010116f:	83 ec 0c             	sub    $0xc,%esp
80101172:	ff 75 e4             	pushl  -0x1c(%ebp)
80101175:	e8 66 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010117a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101181:	83 c4 10             	add    $0x10,%esp
80101184:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101187:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010118d:	77 82                	ja     80101111 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	68 fb 6f 10 80       	push   $0x80106ffb
80101197:	e8 d4 f1 ff ff       	call   80100370 <panic>
8010119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011a0:	09 fa                	or     %edi,%edx
801011a2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011a5:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
801011a8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011ac:	57                   	push   %edi
801011ad:	e8 ee 1b 00 00       	call   80102da0 <log_write>
        brelse(bp);
801011b2:	89 3c 24             	mov    %edi,(%esp)
801011b5:	e8 26 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011ba:	58                   	pop    %eax
801011bb:	5a                   	pop    %edx
801011bc:	56                   	push   %esi
801011bd:	ff 75 d8             	pushl  -0x28(%ebp)
801011c0:	e8 0b ef ff ff       	call   801000d0 <bread>
801011c5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ca:	83 c4 0c             	add    $0xc,%esp
801011cd:	68 00 02 00 00       	push   $0x200
801011d2:	6a 00                	push   $0x0
801011d4:	50                   	push   %eax
801011d5:	e8 b6 32 00 00       	call   80104490 <memset>
  log_write(bp);
801011da:	89 1c 24             	mov    %ebx,(%esp)
801011dd:	e8 be 1b 00 00       	call   80102da0 <log_write>
  brelse(bp);
801011e2:	89 1c 24             	mov    %ebx,(%esp)
801011e5:	e8 f6 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011ed:	89 f0                	mov    %esi,%eax
801011ef:	5b                   	pop    %ebx
801011f0:	5e                   	pop    %esi
801011f1:	5f                   	pop    %edi
801011f2:	5d                   	pop    %ebp
801011f3:	c3                   	ret    
801011f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801011fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101200 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101200:	55                   	push   %ebp
80101201:	89 e5                	mov    %esp,%ebp
80101203:	57                   	push   %edi
80101204:	56                   	push   %esi
80101205:	53                   	push   %ebx
80101206:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101208:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010120a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010120f:	83 ec 28             	sub    $0x28,%esp
80101212:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101215:	68 00 0a 11 80       	push   $0x80110a00
8010121a:	e8 41 30 00 00       	call   80104260 <acquire>
8010121f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101222:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101225:	eb 1b                	jmp    80101242 <iget+0x42>
80101227:	89 f6                	mov    %esi,%esi
80101229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101230:	85 f6                	test   %esi,%esi
80101232:	74 44                	je     80101278 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101234:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010123a:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101240:	74 4e                	je     80101290 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101242:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101245:	85 c9                	test   %ecx,%ecx
80101247:	7e e7                	jle    80101230 <iget+0x30>
80101249:	39 3b                	cmp    %edi,(%ebx)
8010124b:	75 e3                	jne    80101230 <iget+0x30>
8010124d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101250:	75 de                	jne    80101230 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101252:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101255:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101258:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010125a:	68 00 0a 11 80       	push   $0x80110a00

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010125f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101262:	e8 d9 31 00 00       	call   80104440 <release>
      return ip;
80101267:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
8010126a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010126d:	89 f0                	mov    %esi,%eax
8010126f:	5b                   	pop    %ebx
80101270:	5e                   	pop    %esi
80101271:	5f                   	pop    %edi
80101272:	5d                   	pop    %ebp
80101273:	c3                   	ret    
80101274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101278:	85 c9                	test   %ecx,%ecx
8010127a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010127d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101283:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101289:	75 b7                	jne    80101242 <iget+0x42>
8010128b:	90                   	nop
8010128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101290:	85 f6                	test   %esi,%esi
80101292:	74 2d                	je     801012c1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101294:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101297:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101299:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010129c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
801012a3:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012aa:	68 00 0a 11 80       	push   $0x80110a00
801012af:	e8 8c 31 00 00       	call   80104440 <release>

  return ip;
801012b4:	83 c4 10             	add    $0x10,%esp
}
801012b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ba:	89 f0                	mov    %esi,%eax
801012bc:	5b                   	pop    %ebx
801012bd:	5e                   	pop    %esi
801012be:	5f                   	pop    %edi
801012bf:	5d                   	pop    %ebp
801012c0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	68 11 70 10 80       	push   $0x80107011
801012c9:	e8 a2 f0 ff ff       	call   80100370 <panic>
801012ce:	66 90                	xchg   %ax,%ax

801012d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	57                   	push   %edi
801012d4:	56                   	push   %esi
801012d5:	53                   	push   %ebx
801012d6:	89 c6                	mov    %eax,%esi
801012d8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012db:	83 fa 0b             	cmp    $0xb,%edx
801012de:	77 18                	ja     801012f8 <bmap+0x28>
801012e0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801012e3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801012e6:	85 c0                	test   %eax,%eax
801012e8:	74 76                	je     80101360 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ed:	5b                   	pop    %ebx
801012ee:	5e                   	pop    %esi
801012ef:	5f                   	pop    %edi
801012f0:	5d                   	pop    %ebp
801012f1:	c3                   	ret    
801012f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801012f8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801012fb:	83 fb 7f             	cmp    $0x7f,%ebx
801012fe:	0f 87 83 00 00 00    	ja     80101387 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101304:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010130a:	85 c0                	test   %eax,%eax
8010130c:	74 6a                	je     80101378 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010130e:	83 ec 08             	sub    $0x8,%esp
80101311:	50                   	push   %eax
80101312:	ff 36                	pushl  (%esi)
80101314:	e8 b7 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101319:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010131d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101320:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101322:	8b 1a                	mov    (%edx),%ebx
80101324:	85 db                	test   %ebx,%ebx
80101326:	75 1d                	jne    80101345 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101328:	8b 06                	mov    (%esi),%eax
8010132a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010132d:	e8 be fd ff ff       	call   801010f0 <balloc>
80101332:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101335:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101338:	89 c3                	mov    %eax,%ebx
8010133a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010133c:	57                   	push   %edi
8010133d:	e8 5e 1a 00 00       	call   80102da0 <log_write>
80101342:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101345:	83 ec 0c             	sub    $0xc,%esp
80101348:	57                   	push   %edi
80101349:	e8 92 ee ff ff       	call   801001e0 <brelse>
8010134e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101351:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101354:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101356:	5b                   	pop    %ebx
80101357:	5e                   	pop    %esi
80101358:	5f                   	pop    %edi
80101359:	5d                   	pop    %ebp
8010135a:	c3                   	ret    
8010135b:	90                   	nop
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101360:	8b 06                	mov    (%esi),%eax
80101362:	e8 89 fd ff ff       	call   801010f0 <balloc>
80101367:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010136a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010136d:	5b                   	pop    %ebx
8010136e:	5e                   	pop    %esi
8010136f:	5f                   	pop    %edi
80101370:	5d                   	pop    %ebp
80101371:	c3                   	ret    
80101372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101378:	8b 06                	mov    (%esi),%eax
8010137a:	e8 71 fd ff ff       	call   801010f0 <balloc>
8010137f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101385:	eb 87                	jmp    8010130e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101387:	83 ec 0c             	sub    $0xc,%esp
8010138a:	68 21 70 10 80       	push   $0x80107021
8010138f:	e8 dc ef ff ff       	call   80100370 <panic>
80101394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010139a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013a0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	56                   	push   %esi
801013a4:	53                   	push   %ebx
801013a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013a8:	83 ec 08             	sub    $0x8,%esp
801013ab:	6a 01                	push   $0x1
801013ad:	ff 75 08             	pushl  0x8(%ebp)
801013b0:	e8 1b ed ff ff       	call   801000d0 <bread>
801013b5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ba:	83 c4 0c             	add    $0xc,%esp
801013bd:	6a 1c                	push   $0x1c
801013bf:	50                   	push   %eax
801013c0:	56                   	push   %esi
801013c1:	e8 7a 31 00 00       	call   80104540 <memmove>
  brelse(bp);
801013c6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013c9:	83 c4 10             	add    $0x10,%esp
}
801013cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013cf:	5b                   	pop    %ebx
801013d0:	5e                   	pop    %esi
801013d1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013d2:	e9 09 ee ff ff       	jmp    801001e0 <brelse>
801013d7:	89 f6                	mov    %esi,%esi
801013d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013e0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	56                   	push   %esi
801013e4:	53                   	push   %ebx
801013e5:	89 d3                	mov    %edx,%ebx
801013e7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013e9:	83 ec 08             	sub    $0x8,%esp
801013ec:	68 e0 09 11 80       	push   $0x801109e0
801013f1:	50                   	push   %eax
801013f2:	e8 a9 ff ff ff       	call   801013a0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801013f7:	58                   	pop    %eax
801013f8:	5a                   	pop    %edx
801013f9:	89 da                	mov    %ebx,%edx
801013fb:	c1 ea 0c             	shr    $0xc,%edx
801013fe:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101404:	52                   	push   %edx
80101405:	56                   	push   %esi
80101406:	e8 c5 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010140b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010140d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101413:	ba 01 00 00 00       	mov    $0x1,%edx
80101418:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010141b:	c1 fb 03             	sar    $0x3,%ebx
8010141e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101421:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101423:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101428:	85 d1                	test   %edx,%ecx
8010142a:	74 27                	je     80101453 <bfree+0x73>
8010142c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010142e:	f7 d2                	not    %edx
80101430:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101432:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101435:	21 d0                	and    %edx,%eax
80101437:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010143b:	56                   	push   %esi
8010143c:	e8 5f 19 00 00       	call   80102da0 <log_write>
  brelse(bp);
80101441:	89 34 24             	mov    %esi,(%esp)
80101444:	e8 97 ed ff ff       	call   801001e0 <brelse>
}
80101449:	83 c4 10             	add    $0x10,%esp
8010144c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010144f:	5b                   	pop    %ebx
80101450:	5e                   	pop    %esi
80101451:	5d                   	pop    %ebp
80101452:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101453:	83 ec 0c             	sub    $0xc,%esp
80101456:	68 34 70 10 80       	push   $0x80107034
8010145b:	e8 10 ef ff ff       	call   80100370 <panic>

80101460 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101460:	55                   	push   %ebp
80101461:	89 e5                	mov    %esp,%ebp
80101463:	53                   	push   %ebx
80101464:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101469:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010146c:	68 47 70 10 80       	push   $0x80107047
80101471:	68 00 0a 11 80       	push   $0x80110a00
80101476:	e8 c5 2d 00 00       	call   80104240 <initlock>
8010147b:	83 c4 10             	add    $0x10,%esp
8010147e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101480:	83 ec 08             	sub    $0x8,%esp
80101483:	68 4e 70 10 80       	push   $0x8010704e
80101488:	53                   	push   %ebx
80101489:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010148f:	e8 9c 2c 00 00       	call   80104130 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101494:	83 c4 10             	add    $0x10,%esp
80101497:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
8010149d:	75 e1                	jne    80101480 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }
  
  readsb(dev, &sb);
8010149f:	83 ec 08             	sub    $0x8,%esp
801014a2:	68 e0 09 11 80       	push   $0x801109e0
801014a7:	ff 75 08             	pushl  0x8(%ebp)
801014aa:	e8 f1 fe ff ff       	call   801013a0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014af:	ff 35 f8 09 11 80    	pushl  0x801109f8
801014b5:	ff 35 f4 09 11 80    	pushl  0x801109f4
801014bb:	ff 35 f0 09 11 80    	pushl  0x801109f0
801014c1:	ff 35 ec 09 11 80    	pushl  0x801109ec
801014c7:	ff 35 e8 09 11 80    	pushl  0x801109e8
801014cd:	ff 35 e4 09 11 80    	pushl  0x801109e4
801014d3:	ff 35 e0 09 11 80    	pushl  0x801109e0
801014d9:	68 a4 70 10 80       	push   $0x801070a4
801014de:	e8 7d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014e3:	83 c4 30             	add    $0x30,%esp
801014e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014e9:	c9                   	leave  
801014ea:	c3                   	ret    
801014eb:	90                   	nop
801014ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014f0 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	53                   	push   %ebx
801014f6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014f9:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101500:	8b 45 0c             	mov    0xc(%ebp),%eax
80101503:	8b 75 08             	mov    0x8(%ebp),%esi
80101506:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101509:	0f 86 91 00 00 00    	jbe    801015a0 <ialloc+0xb0>
8010150f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101514:	eb 21                	jmp    80101537 <ialloc+0x47>
80101516:	8d 76 00             	lea    0x0(%esi),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101520:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101523:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101526:	57                   	push   %edi
80101527:	e8 b4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010152c:	83 c4 10             	add    $0x10,%esp
8010152f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101535:	76 69                	jbe    801015a0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101537:	89 d8                	mov    %ebx,%eax
80101539:	83 ec 08             	sub    $0x8,%esp
8010153c:	c1 e8 03             	shr    $0x3,%eax
8010153f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101545:	50                   	push   %eax
80101546:	56                   	push   %esi
80101547:	e8 84 eb ff ff       	call   801000d0 <bread>
8010154c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010154e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101550:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101553:	83 e0 07             	and    $0x7,%eax
80101556:	c1 e0 06             	shl    $0x6,%eax
80101559:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010155d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101561:	75 bd                	jne    80101520 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101563:	83 ec 04             	sub    $0x4,%esp
80101566:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101569:	6a 40                	push   $0x40
8010156b:	6a 00                	push   $0x0
8010156d:	51                   	push   %ecx
8010156e:	e8 1d 2f 00 00       	call   80104490 <memset>
      dip->type = type;
80101573:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101577:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010157a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010157d:	89 3c 24             	mov    %edi,(%esp)
80101580:	e8 1b 18 00 00       	call   80102da0 <log_write>
      brelse(bp);
80101585:	89 3c 24             	mov    %edi,(%esp)
80101588:	e8 53 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010158d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101590:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101593:	89 da                	mov    %ebx,%edx
80101595:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101597:	5b                   	pop    %ebx
80101598:	5e                   	pop    %esi
80101599:	5f                   	pop    %edi
8010159a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010159b:	e9 60 fc ff ff       	jmp    80101200 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015a0:	83 ec 0c             	sub    $0xc,%esp
801015a3:	68 54 70 10 80       	push   $0x80107054
801015a8:	e8 c3 ed ff ff       	call   80100370 <panic>
801015ad:	8d 76 00             	lea    0x0(%esi),%esi

801015b0 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801015b0:	55                   	push   %ebp
801015b1:	89 e5                	mov    %esp,%ebp
801015b3:	56                   	push   %esi
801015b4:	53                   	push   %ebx
801015b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015b8:	83 ec 08             	sub    $0x8,%esp
801015bb:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015be:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015c1:	c1 e8 03             	shr    $0x3,%eax
801015c4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801015ca:	50                   	push   %eax
801015cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015ce:	e8 fd ea ff ff       	call   801000d0 <bread>
801015d3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015d5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015d8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015dc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015df:	83 e0 07             	and    $0x7,%eax
801015e2:	c1 e0 06             	shl    $0x6,%eax
801015e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015e9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015ec:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015f0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801015f3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801015f7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801015fb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801015ff:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101603:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101607:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010160a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160d:	6a 34                	push   $0x34
8010160f:	53                   	push   %ebx
80101610:	50                   	push   %eax
80101611:	e8 2a 2f 00 00       	call   80104540 <memmove>
  log_write(bp);
80101616:	89 34 24             	mov    %esi,(%esp)
80101619:	e8 82 17 00 00       	call   80102da0 <log_write>
  brelse(bp);
8010161e:	89 75 08             	mov    %esi,0x8(%ebp)
80101621:	83 c4 10             	add    $0x10,%esp
}
80101624:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101627:	5b                   	pop    %ebx
80101628:	5e                   	pop    %esi
80101629:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010162a:	e9 b1 eb ff ff       	jmp    801001e0 <brelse>
8010162f:	90                   	nop

80101630 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101630:	55                   	push   %ebp
80101631:	89 e5                	mov    %esp,%ebp
80101633:	53                   	push   %ebx
80101634:	83 ec 10             	sub    $0x10,%esp
80101637:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010163a:	68 00 0a 11 80       	push   $0x80110a00
8010163f:	e8 1c 2c 00 00       	call   80104260 <acquire>
  ip->ref++;
80101644:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101648:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010164f:	e8 ec 2d 00 00       	call   80104440 <release>
  return ip;
}
80101654:	89 d8                	mov    %ebx,%eax
80101656:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101659:	c9                   	leave  
8010165a:	c3                   	ret    
8010165b:	90                   	nop
8010165c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101660 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	56                   	push   %esi
80101664:	53                   	push   %ebx
80101665:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101668:	85 db                	test   %ebx,%ebx
8010166a:	0f 84 b4 00 00 00    	je     80101724 <ilock+0xc4>
80101670:	8b 43 08             	mov    0x8(%ebx),%eax
80101673:	85 c0                	test   %eax,%eax
80101675:	0f 8e a9 00 00 00    	jle    80101724 <ilock+0xc4>
    panic("ilock");

  acquiresleep(&ip->lock);
8010167b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010167e:	83 ec 0c             	sub    $0xc,%esp
80101681:	50                   	push   %eax
80101682:	e8 e9 2a 00 00       	call   80104170 <acquiresleep>

  if(!(ip->flags & I_VALID)){
80101687:	83 c4 10             	add    $0x10,%esp
8010168a:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
8010168e:	74 10                	je     801016a0 <ilock+0x40>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101690:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101693:	5b                   	pop    %ebx
80101694:	5e                   	pop    %esi
80101695:	5d                   	pop    %ebp
80101696:	c3                   	ret    
80101697:	89 f6                	mov    %esi,%esi
80101699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016a0:	8b 43 04             	mov    0x4(%ebx),%eax
801016a3:	83 ec 08             	sub    $0x8,%esp
801016a6:	c1 e8 03             	shr    $0x3,%eax
801016a9:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801016af:	50                   	push   %eax
801016b0:	ff 33                	pushl  (%ebx)
801016b2:	e8 19 ea ff ff       	call   801000d0 <bread>
801016b7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016b9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016bc:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016bf:	83 e0 07             	and    $0x7,%eax
801016c2:	c1 e0 06             	shl    $0x6,%eax
801016c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016c9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016cc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016cf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016d3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016d7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016db:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016df:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016e3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016e7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016eb:	8b 50 fc             	mov    -0x4(%eax),%edx
801016ee:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016f1:	6a 34                	push   $0x34
801016f3:	50                   	push   %eax
801016f4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801016f7:	50                   	push   %eax
801016f8:	e8 43 2e 00 00       	call   80104540 <memmove>
    brelse(bp);
801016fd:	89 34 24             	mov    %esi,(%esp)
80101700:	e8 db ea ff ff       	call   801001e0 <brelse>
    ip->flags |= I_VALID;
80101705:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
80101709:	83 c4 10             	add    $0x10,%esp
8010170c:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101711:	0f 85 79 ff ff ff    	jne    80101690 <ilock+0x30>
      panic("ilock: no type");
80101717:	83 ec 0c             	sub    $0xc,%esp
8010171a:	68 6c 70 10 80       	push   $0x8010706c
8010171f:	e8 4c ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101724:	83 ec 0c             	sub    $0xc,%esp
80101727:	68 66 70 10 80       	push   $0x80107066
8010172c:	e8 3f ec ff ff       	call   80100370 <panic>
80101731:	eb 0d                	jmp    80101740 <iunlock>
80101733:	90                   	nop
80101734:	90                   	nop
80101735:	90                   	nop
80101736:	90                   	nop
80101737:	90                   	nop
80101738:	90                   	nop
80101739:	90                   	nop
8010173a:	90                   	nop
8010173b:	90                   	nop
8010173c:	90                   	nop
8010173d:	90                   	nop
8010173e:	90                   	nop
8010173f:	90                   	nop

80101740 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101748:	85 db                	test   %ebx,%ebx
8010174a:	74 28                	je     80101774 <iunlock+0x34>
8010174c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010174f:	83 ec 0c             	sub    $0xc,%esp
80101752:	56                   	push   %esi
80101753:	e8 b8 2a 00 00       	call   80104210 <holdingsleep>
80101758:	83 c4 10             	add    $0x10,%esp
8010175b:	85 c0                	test   %eax,%eax
8010175d:	74 15                	je     80101774 <iunlock+0x34>
8010175f:	8b 43 08             	mov    0x8(%ebx),%eax
80101762:	85 c0                	test   %eax,%eax
80101764:	7e 0e                	jle    80101774 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101766:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101769:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010176c:	5b                   	pop    %ebx
8010176d:	5e                   	pop    %esi
8010176e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010176f:	e9 5c 2a 00 00       	jmp    801041d0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101774:	83 ec 0c             	sub    $0xc,%esp
80101777:	68 7b 70 10 80       	push   $0x8010707b
8010177c:	e8 ef eb ff ff       	call   80100370 <panic>
80101781:	eb 0d                	jmp    80101790 <iput>
80101783:	90                   	nop
80101784:	90                   	nop
80101785:	90                   	nop
80101786:	90                   	nop
80101787:	90                   	nop
80101788:	90                   	nop
80101789:	90                   	nop
8010178a:	90                   	nop
8010178b:	90                   	nop
8010178c:	90                   	nop
8010178d:	90                   	nop
8010178e:	90                   	nop
8010178f:	90                   	nop

80101790 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	57                   	push   %edi
80101794:	56                   	push   %esi
80101795:	53                   	push   %ebx
80101796:	83 ec 28             	sub    $0x28,%esp
80101799:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
8010179c:	68 00 0a 11 80       	push   $0x80110a00
801017a1:	e8 ba 2a 00 00       	call   80104260 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017a6:	8b 46 08             	mov    0x8(%esi),%eax
801017a9:	83 c4 10             	add    $0x10,%esp
801017ac:	83 f8 01             	cmp    $0x1,%eax
801017af:	74 1f                	je     801017d0 <iput+0x40>
    ip->type = 0;
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
801017b1:	83 e8 01             	sub    $0x1,%eax
801017b4:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801017b7:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
801017be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017c1:	5b                   	pop    %ebx
801017c2:	5e                   	pop    %esi
801017c3:	5f                   	pop    %edi
801017c4:	5d                   	pop    %ebp
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
  release(&icache.lock);
801017c5:	e9 76 2c 00 00       	jmp    80104440 <release>
801017ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// case it has to free the inode.
void
iput(struct inode *ip)
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017d0:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
801017d4:	74 db                	je     801017b1 <iput+0x21>
801017d6:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017db:	75 d4                	jne    801017b1 <iput+0x21>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
801017dd:	83 ec 0c             	sub    $0xc,%esp
801017e0:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801017e3:	8d be 8c 00 00 00    	lea    0x8c(%esi),%edi
801017e9:	68 00 0a 11 80       	push   $0x80110a00
801017ee:	e8 4d 2c 00 00       	call   80104440 <release>
801017f3:	83 c4 10             	add    $0x10,%esp
801017f6:	eb 0f                	jmp    80101807 <iput+0x77>
801017f8:	90                   	nop
801017f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101800:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101803:	39 fb                	cmp    %edi,%ebx
80101805:	74 19                	je     80101820 <iput+0x90>
    if(ip->addrs[i]){
80101807:	8b 13                	mov    (%ebx),%edx
80101809:	85 d2                	test   %edx,%edx
8010180b:	74 f3                	je     80101800 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
8010180d:	8b 06                	mov    (%esi),%eax
8010180f:	e8 cc fb ff ff       	call   801013e0 <bfree>
      ip->addrs[i] = 0;
80101814:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010181a:	eb e4                	jmp    80101800 <iput+0x70>
8010181c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101820:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101826:	85 c0                	test   %eax,%eax
80101828:	75 46                	jne    80101870 <iput+0xe0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010182a:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010182d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101834:	56                   	push   %esi
80101835:	e8 76 fd ff ff       	call   801015b0 <iupdate>
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
8010183a:	31 c0                	xor    %eax,%eax
8010183c:	66 89 46 50          	mov    %ax,0x50(%esi)
    iupdate(ip);
80101840:	89 34 24             	mov    %esi,(%esp)
80101843:	e8 68 fd ff ff       	call   801015b0 <iupdate>
    acquire(&icache.lock);
80101848:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010184f:	e8 0c 2a 00 00       	call   80104260 <acquire>
    ip->flags = 0;
80101854:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010185b:	8b 46 08             	mov    0x8(%esi),%eax
8010185e:	83 c4 10             	add    $0x10,%esp
80101861:	e9 4b ff ff ff       	jmp    801017b1 <iput+0x21>
80101866:	8d 76 00             	lea    0x0(%esi),%esi
80101869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101870:	83 ec 08             	sub    $0x8,%esp
80101873:	50                   	push   %eax
80101874:	ff 36                	pushl  (%esi)
80101876:	e8 55 e8 ff ff       	call   801000d0 <bread>
8010187b:	83 c4 10             	add    $0x10,%esp
8010187e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101881:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101884:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
8010188a:	eb 0b                	jmp    80101897 <iput+0x107>
8010188c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101890:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101893:	39 df                	cmp    %ebx,%edi
80101895:	74 0f                	je     801018a6 <iput+0x116>
      if(a[j])
80101897:	8b 13                	mov    (%ebx),%edx
80101899:	85 d2                	test   %edx,%edx
8010189b:	74 f3                	je     80101890 <iput+0x100>
        bfree(ip->dev, a[j]);
8010189d:	8b 06                	mov    (%esi),%eax
8010189f:	e8 3c fb ff ff       	call   801013e0 <bfree>
801018a4:	eb ea                	jmp    80101890 <iput+0x100>
    }
    brelse(bp);
801018a6:	83 ec 0c             	sub    $0xc,%esp
801018a9:	ff 75 e4             	pushl  -0x1c(%ebp)
801018ac:	e8 2f e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018b1:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018b7:	8b 06                	mov    (%esi),%eax
801018b9:	e8 22 fb ff ff       	call   801013e0 <bfree>
    ip->addrs[NDIRECT] = 0;
801018be:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018c5:	00 00 00 
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	e9 5a ff ff ff       	jmp    8010182a <iput+0x9a>

801018d0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	53                   	push   %ebx
801018d4:	83 ec 10             	sub    $0x10,%esp
801018d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018da:	53                   	push   %ebx
801018db:	e8 60 fe ff ff       	call   80101740 <iunlock>
  iput(ip);
801018e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801018e3:	83 c4 10             	add    $0x10,%esp
}
801018e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018e9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801018ea:	e9 a1 fe ff ff       	jmp    80101790 <iput>
801018ef:	90                   	nop

801018f0 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	8b 55 08             	mov    0x8(%ebp),%edx
801018f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801018f9:	8b 0a                	mov    (%edx),%ecx
801018fb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801018fe:	8b 4a 04             	mov    0x4(%edx),%ecx
80101901:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101904:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101908:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010190b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010190f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101913:	8b 52 58             	mov    0x58(%edx),%edx
80101916:	89 50 10             	mov    %edx,0x10(%eax)
}
80101919:	5d                   	pop    %ebp
8010191a:	c3                   	ret    
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 1c             	sub    $0x1c,%esp
80101929:	8b 45 08             	mov    0x8(%ebp),%eax
8010192c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010192f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101932:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101937:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010193a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010193d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101940:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101943:	0f 84 a7 00 00 00    	je     801019f0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101949:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010194c:	8b 40 58             	mov    0x58(%eax),%eax
8010194f:	39 f0                	cmp    %esi,%eax
80101951:	0f 82 c1 00 00 00    	jb     80101a18 <readi+0xf8>
80101957:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010195a:	89 fa                	mov    %edi,%edx
8010195c:	01 f2                	add    %esi,%edx
8010195e:	0f 82 b4 00 00 00    	jb     80101a18 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101964:	89 c1                	mov    %eax,%ecx
80101966:	29 f1                	sub    %esi,%ecx
80101968:	39 d0                	cmp    %edx,%eax
8010196a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010196d:	31 ff                	xor    %edi,%edi
8010196f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101971:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101974:	74 6d                	je     801019e3 <readi+0xc3>
80101976:	8d 76 00             	lea    0x0(%esi),%esi
80101979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101980:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101983:	89 f2                	mov    %esi,%edx
80101985:	c1 ea 09             	shr    $0x9,%edx
80101988:	89 d8                	mov    %ebx,%eax
8010198a:	e8 41 f9 ff ff       	call   801012d0 <bmap>
8010198f:	83 ec 08             	sub    $0x8,%esp
80101992:	50                   	push   %eax
80101993:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101995:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010199a:	e8 31 e7 ff ff       	call   801000d0 <bread>
8010199f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801019a4:	89 f1                	mov    %esi,%ecx
801019a6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019ac:	83 c4 0c             	add    $0xc,%esp
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019af:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801019b2:	29 cb                	sub    %ecx,%ebx
801019b4:	29 f8                	sub    %edi,%eax
801019b6:	39 c3                	cmp    %eax,%ebx
801019b8:	0f 47 d8             	cmova  %eax,%ebx
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019bb:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019bf:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c0:	01 df                	add    %ebx,%edi
801019c2:	01 de                	add    %ebx,%esi
    for (int j = 0; j < min(m, 10); j++) {
      cprintf("%x ", bp->data[off%BSIZE+j]);
    }
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
801019c4:	50                   	push   %eax
801019c5:	ff 75 e0             	pushl  -0x20(%ebp)
801019c8:	e8 73 2b 00 00       	call   80104540 <memmove>
    brelse(bp);
801019cd:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019d0:	89 14 24             	mov    %edx,(%esp)
801019d3:	e8 08 e8 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d8:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019db:	83 c4 10             	add    $0x10,%esp
801019de:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801019e1:	77 9d                	ja     80101980 <readi+0x60>
    cprintf("\n");
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801019e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801019e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019e9:	5b                   	pop    %ebx
801019ea:	5e                   	pop    %esi
801019eb:	5f                   	pop    %edi
801019ec:	5d                   	pop    %ebp
801019ed:	c3                   	ret    
801019ee:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801019f0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801019f4:	66 83 f8 09          	cmp    $0x9,%ax
801019f8:	77 1e                	ja     80101a18 <readi+0xf8>
801019fa:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a01:	85 c0                	test   %eax,%eax
80101a03:	74 13                	je     80101a18 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a05:	89 7d 10             	mov    %edi,0x10(%ebp)
    */
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a0b:	5b                   	pop    %ebx
80101a0c:	5e                   	pop    %esi
80101a0d:	5f                   	pop    %edi
80101a0e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a0f:	ff e0                	jmp    *%eax
80101a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a1d:	eb c7                	jmp    801019e6 <readi+0xc6>
80101a1f:	90                   	nop

80101a20 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	57                   	push   %edi
80101a24:	56                   	push   %esi
80101a25:	53                   	push   %ebx
80101a26:	83 ec 1c             	sub    $0x1c,%esp
80101a29:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a2f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a32:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a37:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a3a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a3d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a40:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a43:	0f 84 b7 00 00 00    	je     80101b00 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a4c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a4f:	0f 82 eb 00 00 00    	jb     80101b40 <writei+0x120>
80101a55:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a58:	89 f8                	mov    %edi,%eax
80101a5a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a5c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101a61:	0f 87 d9 00 00 00    	ja     80101b40 <writei+0x120>
80101a67:	39 c6                	cmp    %eax,%esi
80101a69:	0f 87 d1 00 00 00    	ja     80101b40 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a6f:	85 ff                	test   %edi,%edi
80101a71:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a78:	74 78                	je     80101af2 <writei+0xd2>
80101a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a80:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a83:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a85:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a8a:	c1 ea 09             	shr    $0x9,%edx
80101a8d:	89 f8                	mov    %edi,%eax
80101a8f:	e8 3c f8 ff ff       	call   801012d0 <bmap>
80101a94:	83 ec 08             	sub    $0x8,%esp
80101a97:	50                   	push   %eax
80101a98:	ff 37                	pushl  (%edi)
80101a9a:	e8 31 e6 ff ff       	call   801000d0 <bread>
80101a9f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101aa1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101aa4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101aa7:	89 f1                	mov    %esi,%ecx
80101aa9:	83 c4 0c             	add    $0xc,%esp
80101aac:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101ab2:	29 cb                	sub    %ecx,%ebx
80101ab4:	39 c3                	cmp    %eax,%ebx
80101ab6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ab9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101abd:	53                   	push   %ebx
80101abe:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101ac3:	50                   	push   %eax
80101ac4:	e8 77 2a 00 00       	call   80104540 <memmove>
    log_write(bp);
80101ac9:	89 3c 24             	mov    %edi,(%esp)
80101acc:	e8 cf 12 00 00       	call   80102da0 <log_write>
    brelse(bp);
80101ad1:	89 3c 24             	mov    %edi,(%esp)
80101ad4:	e8 07 e7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ad9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101adc:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101adf:	83 c4 10             	add    $0x10,%esp
80101ae2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ae5:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101ae8:	77 96                	ja     80101a80 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101aea:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aed:	3b 70 58             	cmp    0x58(%eax),%esi
80101af0:	77 36                	ja     80101b28 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101af2:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101af5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101af8:	5b                   	pop    %ebx
80101af9:	5e                   	pop    %esi
80101afa:	5f                   	pop    %edi
80101afb:	5d                   	pop    %ebp
80101afc:	c3                   	ret    
80101afd:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b00:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b04:	66 83 f8 09          	cmp    $0x9,%ax
80101b08:	77 36                	ja     80101b40 <writei+0x120>
80101b0a:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b11:	85 c0                	test   %eax,%eax
80101b13:	74 2b                	je     80101b40 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b15:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b1b:	5b                   	pop    %ebx
80101b1c:	5e                   	pop    %esi
80101b1d:	5f                   	pop    %edi
80101b1e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b1f:	ff e0                	jmp    *%eax
80101b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b28:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b2b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b2e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b31:	50                   	push   %eax
80101b32:	e8 79 fa ff ff       	call   801015b0 <iupdate>
80101b37:	83 c4 10             	add    $0x10,%esp
80101b3a:	eb b6                	jmp    80101af2 <writei+0xd2>
80101b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b45:	eb ae                	jmp    80101af5 <writei+0xd5>
80101b47:	89 f6                	mov    %esi,%esi
80101b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b50 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101b56:	6a 0e                	push   $0xe
80101b58:	ff 75 0c             	pushl  0xc(%ebp)
80101b5b:	ff 75 08             	pushl  0x8(%ebp)
80101b5e:	e8 5d 2a 00 00       	call   801045c0 <strncmp>
}
80101b63:	c9                   	leave  
80101b64:	c3                   	ret    
80101b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b70 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 1c             	sub    $0x1c,%esp
80101b79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101b7c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101b81:	0f 85 80 00 00 00    	jne    80101c07 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101b87:	8b 53 58             	mov    0x58(%ebx),%edx
80101b8a:	31 ff                	xor    %edi,%edi
80101b8c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101b8f:	85 d2                	test   %edx,%edx
80101b91:	75 0d                	jne    80101ba0 <dirlookup+0x30>
80101b93:	eb 5b                	jmp    80101bf0 <dirlookup+0x80>
80101b95:	8d 76 00             	lea    0x0(%esi),%esi
80101b98:	83 c7 10             	add    $0x10,%edi
80101b9b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101b9e:	76 50                	jbe    80101bf0 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ba0:	6a 10                	push   $0x10
80101ba2:	57                   	push   %edi
80101ba3:	56                   	push   %esi
80101ba4:	53                   	push   %ebx
80101ba5:	e8 76 fd ff ff       	call   80101920 <readi>
80101baa:	83 c4 10             	add    $0x10,%esp
80101bad:	83 f8 10             	cmp    $0x10,%eax
80101bb0:	75 48                	jne    80101bfa <dirlookup+0x8a>
      panic("dirlink read");
    if(de.inum == 0)
80101bb2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bb7:	74 df                	je     80101b98 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101bb9:	8d 45 da             	lea    -0x26(%ebp),%eax
80101bbc:	83 ec 04             	sub    $0x4,%esp
80101bbf:	6a 0e                	push   $0xe
80101bc1:	50                   	push   %eax
80101bc2:	ff 75 0c             	pushl  0xc(%ebp)
80101bc5:	e8 f6 29 00 00       	call   801045c0 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101bca:	83 c4 10             	add    $0x10,%esp
80101bcd:	85 c0                	test   %eax,%eax
80101bcf:	75 c7                	jne    80101b98 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101bd1:	8b 45 10             	mov    0x10(%ebp),%eax
80101bd4:	85 c0                	test   %eax,%eax
80101bd6:	74 05                	je     80101bdd <dirlookup+0x6d>
        *poff = off;
80101bd8:	8b 45 10             	mov    0x10(%ebp),%eax
80101bdb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101bdd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101be1:	8b 03                	mov    (%ebx),%eax
80101be3:	e8 18 f6 ff ff       	call   80101200 <iget>
    }
  }

  return 0;
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
80101bef:	c3                   	ret    
80101bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101bf3:	31 c0                	xor    %eax,%eax
}
80101bf5:	5b                   	pop    %ebx
80101bf6:	5e                   	pop    %esi
80101bf7:	5f                   	pop    %edi
80101bf8:	5d                   	pop    %ebp
80101bf9:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101bfa:	83 ec 0c             	sub    $0xc,%esp
80101bfd:	68 95 70 10 80       	push   $0x80107095
80101c02:	e8 69 e7 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c07:	83 ec 0c             	sub    $0xc,%esp
80101c0a:	68 83 70 10 80       	push   $0x80107083
80101c0f:	e8 5c e7 ff ff       	call   80100370 <panic>
80101c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c20 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c20:	55                   	push   %ebp
80101c21:	89 e5                	mov    %esp,%ebp
80101c23:	57                   	push   %edi
80101c24:	56                   	push   %esi
80101c25:	53                   	push   %ebx
80101c26:	89 cf                	mov    %ecx,%edi
80101c28:	89 c3                	mov    %eax,%ebx
80101c2a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c2d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c30:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101c33:	0f 84 53 01 00 00    	je     80101d8c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101c39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c3f:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101c42:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101c45:	68 00 0a 11 80       	push   $0x80110a00
80101c4a:	e8 11 26 00 00       	call   80104260 <acquire>
  ip->ref++;
80101c4f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101c53:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c5a:	e8 e1 27 00 00       	call   80104440 <release>
80101c5f:	83 c4 10             	add    $0x10,%esp
80101c62:	eb 07                	jmp    80101c6b <namex+0x4b>
80101c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101c68:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101c6b:	0f b6 03             	movzbl (%ebx),%eax
80101c6e:	3c 2f                	cmp    $0x2f,%al
80101c70:	74 f6                	je     80101c68 <namex+0x48>
    path++;
  if(*path == 0)
80101c72:	84 c0                	test   %al,%al
80101c74:	0f 84 e3 00 00 00    	je     80101d5d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c7a:	0f b6 03             	movzbl (%ebx),%eax
80101c7d:	89 da                	mov    %ebx,%edx
80101c7f:	84 c0                	test   %al,%al
80101c81:	0f 84 ac 00 00 00    	je     80101d33 <namex+0x113>
80101c87:	3c 2f                	cmp    $0x2f,%al
80101c89:	75 09                	jne    80101c94 <namex+0x74>
80101c8b:	e9 a3 00 00 00       	jmp    80101d33 <namex+0x113>
80101c90:	84 c0                	test   %al,%al
80101c92:	74 0a                	je     80101c9e <namex+0x7e>
    path++;
80101c94:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101c97:	0f b6 02             	movzbl (%edx),%eax
80101c9a:	3c 2f                	cmp    $0x2f,%al
80101c9c:	75 f2                	jne    80101c90 <namex+0x70>
80101c9e:	89 d1                	mov    %edx,%ecx
80101ca0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101ca2:	83 f9 0d             	cmp    $0xd,%ecx
80101ca5:	0f 8e 8d 00 00 00    	jle    80101d38 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101cab:	83 ec 04             	sub    $0x4,%esp
80101cae:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101cb1:	6a 0e                	push   $0xe
80101cb3:	53                   	push   %ebx
80101cb4:	57                   	push   %edi
80101cb5:	e8 86 28 00 00       	call   80104540 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101cbd:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101cc0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cc2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101cc5:	75 11                	jne    80101cd8 <namex+0xb8>
80101cc7:	89 f6                	mov    %esi,%esi
80101cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cd0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101cd3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101cd6:	74 f8                	je     80101cd0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101cd8:	83 ec 0c             	sub    $0xc,%esp
80101cdb:	56                   	push   %esi
80101cdc:	e8 7f f9 ff ff       	call   80101660 <ilock>
    if(ip->type != T_DIR){
80101ce1:	83 c4 10             	add    $0x10,%esp
80101ce4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ce9:	0f 85 7f 00 00 00    	jne    80101d6e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101cef:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101cf2:	85 d2                	test   %edx,%edx
80101cf4:	74 09                	je     80101cff <namex+0xdf>
80101cf6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101cf9:	0f 84 a3 00 00 00    	je     80101da2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101cff:	83 ec 04             	sub    $0x4,%esp
80101d02:	6a 00                	push   $0x0
80101d04:	57                   	push   %edi
80101d05:	56                   	push   %esi
80101d06:	e8 65 fe ff ff       	call   80101b70 <dirlookup>
80101d0b:	83 c4 10             	add    $0x10,%esp
80101d0e:	85 c0                	test   %eax,%eax
80101d10:	74 5c                	je     80101d6e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d12:	83 ec 0c             	sub    $0xc,%esp
80101d15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d18:	56                   	push   %esi
80101d19:	e8 22 fa ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d1e:	89 34 24             	mov    %esi,(%esp)
80101d21:	e8 6a fa ff ff       	call   80101790 <iput>
80101d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d29:	83 c4 10             	add    $0x10,%esp
80101d2c:	89 c6                	mov    %eax,%esi
80101d2e:	e9 38 ff ff ff       	jmp    80101c6b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d33:	31 c9                	xor    %ecx,%ecx
80101d35:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101d38:	83 ec 04             	sub    $0x4,%esp
80101d3b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d3e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101d41:	51                   	push   %ecx
80101d42:	53                   	push   %ebx
80101d43:	57                   	push   %edi
80101d44:	e8 f7 27 00 00       	call   80104540 <memmove>
    name[len] = 0;
80101d49:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101d4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d4f:	83 c4 10             	add    $0x10,%esp
80101d52:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101d56:	89 d3                	mov    %edx,%ebx
80101d58:	e9 65 ff ff ff       	jmp    80101cc2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101d5d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101d60:	85 c0                	test   %eax,%eax
80101d62:	75 54                	jne    80101db8 <namex+0x198>
80101d64:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101d66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d69:	5b                   	pop    %ebx
80101d6a:	5e                   	pop    %esi
80101d6b:	5f                   	pop    %edi
80101d6c:	5d                   	pop    %ebp
80101d6d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d6e:	83 ec 0c             	sub    $0xc,%esp
80101d71:	56                   	push   %esi
80101d72:	e8 c9 f9 ff ff       	call   80101740 <iunlock>
  iput(ip);
80101d77:	89 34 24             	mov    %esi,(%esp)
80101d7a:	e8 11 fa ff ff       	call   80101790 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d7f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d82:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101d85:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101d87:	5b                   	pop    %ebx
80101d88:	5e                   	pop    %esi
80101d89:	5f                   	pop    %edi
80101d8a:	5d                   	pop    %ebp
80101d8b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101d8c:	ba 01 00 00 00       	mov    $0x1,%edx
80101d91:	b8 01 00 00 00       	mov    $0x1,%eax
80101d96:	e8 65 f4 ff ff       	call   80101200 <iget>
80101d9b:	89 c6                	mov    %eax,%esi
80101d9d:	e9 c9 fe ff ff       	jmp    80101c6b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101da2:	83 ec 0c             	sub    $0xc,%esp
80101da5:	56                   	push   %esi
80101da6:	e8 95 f9 ff ff       	call   80101740 <iunlock>
      return ip;
80101dab:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dae:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101db1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101db3:	5b                   	pop    %ebx
80101db4:	5e                   	pop    %esi
80101db5:	5f                   	pop    %edi
80101db6:	5d                   	pop    %ebp
80101db7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101db8:	83 ec 0c             	sub    $0xc,%esp
80101dbb:	56                   	push   %esi
80101dbc:	e8 cf f9 ff ff       	call   80101790 <iput>
    return 0;
80101dc1:	83 c4 10             	add    $0x10,%esp
80101dc4:	31 c0                	xor    %eax,%eax
80101dc6:	eb 9e                	jmp    80101d66 <namex+0x146>
80101dc8:	90                   	nop
80101dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101dd0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101dd0:	55                   	push   %ebp
80101dd1:	89 e5                	mov    %esp,%ebp
80101dd3:	57                   	push   %edi
80101dd4:	56                   	push   %esi
80101dd5:	53                   	push   %ebx
80101dd6:	83 ec 20             	sub    $0x20,%esp
80101dd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101ddc:	6a 00                	push   $0x0
80101dde:	ff 75 0c             	pushl  0xc(%ebp)
80101de1:	53                   	push   %ebx
80101de2:	e8 89 fd ff ff       	call   80101b70 <dirlookup>
80101de7:	83 c4 10             	add    $0x10,%esp
80101dea:	85 c0                	test   %eax,%eax
80101dec:	75 67                	jne    80101e55 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101dee:	8b 7b 58             	mov    0x58(%ebx),%edi
80101df1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101df4:	85 ff                	test   %edi,%edi
80101df6:	74 29                	je     80101e21 <dirlink+0x51>
80101df8:	31 ff                	xor    %edi,%edi
80101dfa:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101dfd:	eb 09                	jmp    80101e08 <dirlink+0x38>
80101dff:	90                   	nop
80101e00:	83 c7 10             	add    $0x10,%edi
80101e03:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e06:	76 19                	jbe    80101e21 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e08:	6a 10                	push   $0x10
80101e0a:	57                   	push   %edi
80101e0b:	56                   	push   %esi
80101e0c:	53                   	push   %ebx
80101e0d:	e8 0e fb ff ff       	call   80101920 <readi>
80101e12:	83 c4 10             	add    $0x10,%esp
80101e15:	83 f8 10             	cmp    $0x10,%eax
80101e18:	75 4e                	jne    80101e68 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e1f:	75 df                	jne    80101e00 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e21:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e24:	83 ec 04             	sub    $0x4,%esp
80101e27:	6a 0e                	push   $0xe
80101e29:	ff 75 0c             	pushl  0xc(%ebp)
80101e2c:	50                   	push   %eax
80101e2d:	e8 fe 27 00 00       	call   80104630 <strncpy>
  de.inum = inum;
80101e32:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e35:	6a 10                	push   $0x10
80101e37:	57                   	push   %edi
80101e38:	56                   	push   %esi
80101e39:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101e3a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e3e:	e8 dd fb ff ff       	call   80101a20 <writei>
80101e43:	83 c4 20             	add    $0x20,%esp
80101e46:	83 f8 10             	cmp    $0x10,%eax
80101e49:	75 2a                	jne    80101e75 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101e4b:	31 c0                	xor    %eax,%eax
}
80101e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e50:	5b                   	pop    %ebx
80101e51:	5e                   	pop    %esi
80101e52:	5f                   	pop    %edi
80101e53:	5d                   	pop    %ebp
80101e54:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101e55:	83 ec 0c             	sub    $0xc,%esp
80101e58:	50                   	push   %eax
80101e59:	e8 32 f9 ff ff       	call   80101790 <iput>
    return -1;
80101e5e:	83 c4 10             	add    $0x10,%esp
80101e61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e66:	eb e5                	jmp    80101e4d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101e68:	83 ec 0c             	sub    $0xc,%esp
80101e6b:	68 95 70 10 80       	push   $0x80107095
80101e70:	e8 fb e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101e75:	83 ec 0c             	sub    $0xc,%esp
80101e78:	68 5e 76 10 80       	push   $0x8010765e
80101e7d:	e8 ee e4 ff ff       	call   80100370 <panic>
80101e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e90 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101e90:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e91:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101e93:	89 e5                	mov    %esp,%ebp
80101e95:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101e98:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101e9e:	e8 7d fd ff ff       	call   80101c20 <namex>
}
80101ea3:	c9                   	leave  
80101ea4:	c3                   	ret    
80101ea5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101eb0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101eb0:	55                   	push   %ebp
  return namex(path, 1, name);
80101eb1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101eb6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101eb8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101ebb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101ebe:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101ebf:	e9 5c fd ff ff       	jmp    80101c20 <namex>
80101ec4:	66 90                	xchg   %ax,%ax
80101ec6:	66 90                	xchg   %ax,%ax
80101ec8:	66 90                	xchg   %ax,%ax
80101eca:	66 90                	xchg   %ax,%ax
80101ecc:	66 90                	xchg   %ax,%ax
80101ece:	66 90                	xchg   %ax,%ax

80101ed0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ed0:	55                   	push   %ebp
  if(b == 0)
80101ed1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101ed3:	89 e5                	mov    %esp,%ebp
80101ed5:	56                   	push   %esi
80101ed6:	53                   	push   %ebx
  if(b == 0)
80101ed7:	0f 84 ad 00 00 00    	je     80101f8a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101edd:	8b 58 08             	mov    0x8(%eax),%ebx
80101ee0:	89 c1                	mov    %eax,%ecx
80101ee2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101ee8:	0f 87 8f 00 00 00    	ja     80101f7d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101eee:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ef3:	90                   	nop
80101ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ef8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101ef9:	83 e0 c0             	and    $0xffffffc0,%eax
80101efc:	3c 40                	cmp    $0x40,%al
80101efe:	75 f8                	jne    80101ef8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f00:	31 f6                	xor    %esi,%esi
80101f02:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f07:	89 f0                	mov    %esi,%eax
80101f09:	ee                   	out    %al,(%dx)
80101f0a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f0f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f14:	ee                   	out    %al,(%dx)
80101f15:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f1a:	89 d8                	mov    %ebx,%eax
80101f1c:	ee                   	out    %al,(%dx)
80101f1d:	89 d8                	mov    %ebx,%eax
80101f1f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f24:	c1 f8 08             	sar    $0x8,%eax
80101f27:	ee                   	out    %al,(%dx)
80101f28:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f2d:	89 f0                	mov    %esi,%eax
80101f2f:	ee                   	out    %al,(%dx)
80101f30:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101f34:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101f39:	83 e0 01             	and    $0x1,%eax
80101f3c:	c1 e0 04             	shl    $0x4,%eax
80101f3f:	83 c8 e0             	or     $0xffffffe0,%eax
80101f42:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101f43:	f6 01 04             	testb  $0x4,(%ecx)
80101f46:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f4b:	75 13                	jne    80101f60 <idestart+0x90>
80101f4d:	b8 20 00 00 00       	mov    $0x20,%eax
80101f52:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f53:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f56:	5b                   	pop    %ebx
80101f57:	5e                   	pop    %esi
80101f58:	5d                   	pop    %ebp
80101f59:	c3                   	ret    
80101f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f60:	b8 30 00 00 00       	mov    $0x30,%eax
80101f65:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101f66:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101f6b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101f6e:	b9 80 00 00 00       	mov    $0x80,%ecx
80101f73:	fc                   	cld    
80101f74:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101f76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f79:	5b                   	pop    %ebx
80101f7a:	5e                   	pop    %esi
80101f7b:	5d                   	pop    %ebp
80101f7c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101f7d:	83 ec 0c             	sub    $0xc,%esp
80101f80:	68 00 71 10 80       	push   $0x80107100
80101f85:	e8 e6 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101f8a:	83 ec 0c             	sub    $0xc,%esp
80101f8d:	68 f7 70 10 80       	push   $0x801070f7
80101f92:	e8 d9 e3 ff ff       	call   80100370 <panic>
80101f97:	89 f6                	mov    %esi,%esi
80101f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fa0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80101fa0:	55                   	push   %ebp
80101fa1:	89 e5                	mov    %esp,%ebp
80101fa3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80101fa6:	68 12 71 10 80       	push   $0x80107112
80101fab:	68 80 a5 10 80       	push   $0x8010a580
80101fb0:	e8 8b 22 00 00       	call   80104240 <initlock>
  picenable(IRQ_IDE);
80101fb5:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80101fbc:	e8 cf 12 00 00       	call   80103290 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80101fc1:	58                   	pop    %eax
80101fc2:	a1 80 2d 11 80       	mov    0x80112d80,%eax
80101fc7:	5a                   	pop    %edx
80101fc8:	83 e8 01             	sub    $0x1,%eax
80101fcb:	50                   	push   %eax
80101fcc:	6a 0e                	push   $0xe
80101fce:	e8 bd 02 00 00       	call   80102290 <ioapicenable>
80101fd3:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101fd6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fdb:	90                   	nop
80101fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fe0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101fe1:	83 e0 c0             	and    $0xffffffc0,%eax
80101fe4:	3c 40                	cmp    $0x40,%al
80101fe6:	75 f8                	jne    80101fe0 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fe8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fed:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80101ff2:	ee                   	out    %al,(%dx)
80101ff3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101ff8:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101ffd:	eb 06                	jmp    80102005 <ideinit+0x65>
80101fff:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102000:	83 e9 01             	sub    $0x1,%ecx
80102003:	74 0f                	je     80102014 <ideinit+0x74>
80102005:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102006:	84 c0                	test   %al,%al
80102008:	74 f6                	je     80102000 <ideinit+0x60>
      havedisk1 = 1;
8010200a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102011:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102014:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102019:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010201e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010201f:	c9                   	leave  
80102020:	c3                   	ret    
80102021:	eb 0d                	jmp    80102030 <ideintr>
80102023:	90                   	nop
80102024:	90                   	nop
80102025:	90                   	nop
80102026:	90                   	nop
80102027:	90                   	nop
80102028:	90                   	nop
80102029:	90                   	nop
8010202a:	90                   	nop
8010202b:	90                   	nop
8010202c:	90                   	nop
8010202d:	90                   	nop
8010202e:	90                   	nop
8010202f:	90                   	nop

80102030 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	57                   	push   %edi
80102034:	56                   	push   %esi
80102035:	53                   	push   %ebx
80102036:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102039:	68 80 a5 10 80       	push   $0x8010a580
8010203e:	e8 1d 22 00 00       	call   80104260 <acquire>
  if((b = idequeue) == 0){
80102043:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102049:	83 c4 10             	add    $0x10,%esp
8010204c:	85 db                	test   %ebx,%ebx
8010204e:	74 34                	je     80102084 <ideintr+0x54>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
80102050:	8b 43 58             	mov    0x58(%ebx),%eax
80102053:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102058:	8b 33                	mov    (%ebx),%esi
8010205a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102060:	74 3e                	je     801020a0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102062:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102065:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102068:	83 ce 02             	or     $0x2,%esi
8010206b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010206d:	53                   	push   %ebx
8010206e:	e8 0d 1f 00 00       	call   80103f80 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102073:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102078:	83 c4 10             	add    $0x10,%esp
8010207b:	85 c0                	test   %eax,%eax
8010207d:	74 05                	je     80102084 <ideintr+0x54>
    idestart(idequeue);
8010207f:	e8 4c fe ff ff       	call   80101ed0 <idestart>
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
80102084:	83 ec 0c             	sub    $0xc,%esp
80102087:	68 80 a5 10 80       	push   $0x8010a580
8010208c:	e8 af 23 00 00       	call   80104440 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102091:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102094:	5b                   	pop    %ebx
80102095:	5e                   	pop    %esi
80102096:	5f                   	pop    %edi
80102097:	5d                   	pop    %ebp
80102098:	c3                   	ret    
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020a0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020a5:	8d 76 00             	lea    0x0(%esi),%esi
801020a8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020a9:	89 c1                	mov    %eax,%ecx
801020ab:	83 e1 c0             	and    $0xffffffc0,%ecx
801020ae:	80 f9 40             	cmp    $0x40,%cl
801020b1:	75 f5                	jne    801020a8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020b3:	a8 21                	test   $0x21,%al
801020b5:	75 ab                	jne    80102062 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
801020b7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
801020ba:	b9 80 00 00 00       	mov    $0x80,%ecx
801020bf:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020c4:	fc                   	cld    
801020c5:	f3 6d                	rep insl (%dx),%es:(%edi)
801020c7:	8b 33                	mov    (%ebx),%esi
801020c9:	eb 97                	jmp    80102062 <ideintr+0x32>
801020cb:	90                   	nop
801020cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020d0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	53                   	push   %ebx
801020d4:	83 ec 10             	sub    $0x10,%esp
801020d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801020da:	8d 43 0c             	lea    0xc(%ebx),%eax
801020dd:	50                   	push   %eax
801020de:	e8 2d 21 00 00       	call   80104210 <holdingsleep>
801020e3:	83 c4 10             	add    $0x10,%esp
801020e6:	85 c0                	test   %eax,%eax
801020e8:	0f 84 ad 00 00 00    	je     8010219b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801020ee:	8b 03                	mov    (%ebx),%eax
801020f0:	83 e0 06             	and    $0x6,%eax
801020f3:	83 f8 02             	cmp    $0x2,%eax
801020f6:	0f 84 b9 00 00 00    	je     801021b5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801020fc:	8b 53 04             	mov    0x4(%ebx),%edx
801020ff:	85 d2                	test   %edx,%edx
80102101:	74 0d                	je     80102110 <iderw+0x40>
80102103:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102108:	85 c0                	test   %eax,%eax
8010210a:	0f 84 98 00 00 00    	je     801021a8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102110:	83 ec 0c             	sub    $0xc,%esp
80102113:	68 80 a5 10 80       	push   $0x8010a580
80102118:	e8 43 21 00 00       	call   80104260 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010211d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102123:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102126:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010212d:	85 d2                	test   %edx,%edx
8010212f:	75 09                	jne    8010213a <iderw+0x6a>
80102131:	eb 58                	jmp    8010218b <iderw+0xbb>
80102133:	90                   	nop
80102134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102138:	89 c2                	mov    %eax,%edx
8010213a:	8b 42 58             	mov    0x58(%edx),%eax
8010213d:	85 c0                	test   %eax,%eax
8010213f:	75 f7                	jne    80102138 <iderw+0x68>
80102141:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102144:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102146:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
8010214c:	74 44                	je     80102192 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010214e:	8b 03                	mov    (%ebx),%eax
80102150:	83 e0 06             	and    $0x6,%eax
80102153:	83 f8 02             	cmp    $0x2,%eax
80102156:	74 23                	je     8010217b <iderw+0xab>
80102158:	90                   	nop
80102159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102160:	83 ec 08             	sub    $0x8,%esp
80102163:	68 80 a5 10 80       	push   $0x8010a580
80102168:	53                   	push   %ebx
80102169:	e8 72 1c 00 00       	call   80103de0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010216e:	8b 03                	mov    (%ebx),%eax
80102170:	83 c4 10             	add    $0x10,%esp
80102173:	83 e0 06             	and    $0x6,%eax
80102176:	83 f8 02             	cmp    $0x2,%eax
80102179:	75 e5                	jne    80102160 <iderw+0x90>
    sleep(b, &idelock);
  }

  release(&idelock);
8010217b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102182:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102185:	c9                   	leave  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
80102186:	e9 b5 22 00 00       	jmp    80104440 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102190:	eb b2                	jmp    80102144 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102192:	89 d8                	mov    %ebx,%eax
80102194:	e8 37 fd ff ff       	call   80101ed0 <idestart>
80102199:	eb b3                	jmp    8010214e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010219b:	83 ec 0c             	sub    $0xc,%esp
8010219e:	68 16 71 10 80       	push   $0x80107116
801021a3:	e8 c8 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	68 41 71 10 80       	push   $0x80107141
801021b0:	e8 bb e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801021b5:	83 ec 0c             	sub    $0xc,%esp
801021b8:	68 2c 71 10 80       	push   $0x8010712c
801021bd:	e8 ae e1 ff ff       	call   80100370 <panic>
801021c2:	66 90                	xchg   %ax,%ax
801021c4:	66 90                	xchg   %ax,%ax
801021c6:	66 90                	xchg   %ax,%ax
801021c8:	66 90                	xchg   %ax,%ax
801021ca:	66 90                	xchg   %ax,%ax
801021cc:	66 90                	xchg   %ax,%ax
801021ce:	66 90                	xchg   %ax,%ax

801021d0 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
801021d0:	a1 84 27 11 80       	mov    0x80112784,%eax
801021d5:	85 c0                	test   %eax,%eax
801021d7:	0f 84 a8 00 00 00    	je     80102285 <ioapicinit+0xb5>
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021dd:	55                   	push   %ebp
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801021de:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
801021e5:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
801021e8:	89 e5                	mov    %esp,%ebp
801021ea:	56                   	push   %esi
801021eb:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ec:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801021f3:	00 00 00 
  return ioapic->data;
801021f6:	8b 15 54 26 11 80    	mov    0x80112654,%edx
801021fc:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
801021ff:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102205:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010220b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102212:	89 f0                	mov    %esi,%eax
80102214:	c1 e8 10             	shr    $0x10,%eax
80102217:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010221a:	8b 41 10             	mov    0x10(%ecx),%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010221d:	c1 e8 18             	shr    $0x18,%eax
80102220:	39 d0                	cmp    %edx,%eax
80102222:	74 16                	je     8010223a <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 60 71 10 80       	push   $0x80107160
8010222c:	e8 2f e4 ff ff       	call   80100660 <cprintf>
80102231:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102237:	83 c4 10             	add    $0x10,%esp
8010223a:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010223d:	ba 10 00 00 00       	mov    $0x10,%edx
80102242:	b8 20 00 00 00       	mov    $0x20,%eax
80102247:	89 f6                	mov    %esi,%esi
80102249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102250:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102252:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102258:	89 c3                	mov    %eax,%ebx
8010225a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80102260:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102263:	89 59 10             	mov    %ebx,0x10(%ecx)
80102266:	8d 5a 01             	lea    0x1(%edx),%ebx
80102269:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010226c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010226e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102270:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102276:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010227d:	75 d1                	jne    80102250 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010227f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102282:	5b                   	pop    %ebx
80102283:	5e                   	pop    %esi
80102284:	5d                   	pop    %ebp
80102285:	f3 c3                	repz ret 
80102287:	89 f6                	mov    %esi,%esi
80102289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102290 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102290:	8b 15 84 27 11 80    	mov    0x80112784,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102296:	55                   	push   %ebp
80102297:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102299:	85 d2                	test   %edx,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
8010229b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010229e:	74 2b                	je     801022cb <ioapicenable+0x3b>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022a0:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022a6:	8d 50 20             	lea    0x20(%eax),%edx
801022a9:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022ad:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022af:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b5:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022b8:	89 51 10             	mov    %edx,0x10(%ecx)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022bb:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022be:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801022c0:	a1 54 26 11 80       	mov    0x80112654,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022c5:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022c8:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801022cb:	5d                   	pop    %ebp
801022cc:	c3                   	ret    
801022cd:	66 90                	xchg   %ax,%ax
801022cf:	90                   	nop

801022d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	53                   	push   %ebx
801022d4:	83 ec 04             	sub    $0x4,%esp
801022d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801022e0:	75 70                	jne    80102352 <kfree+0x82>
801022e2:	81 fb 28 55 11 80    	cmp    $0x80115528,%ebx
801022e8:	72 68                	jb     80102352 <kfree+0x82>
801022ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801022f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801022f5:	77 5b                	ja     80102352 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801022f7:	83 ec 04             	sub    $0x4,%esp
801022fa:	68 00 10 00 00       	push   $0x1000
801022ff:	6a 01                	push   $0x1
80102301:	53                   	push   %ebx
80102302:	e8 89 21 00 00       	call   80104490 <memset>

  if(kmem.use_lock)
80102307:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010230d:	83 c4 10             	add    $0x10,%esp
80102310:	85 d2                	test   %edx,%edx
80102312:	75 2c                	jne    80102340 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102314:	a1 98 26 11 80       	mov    0x80112698,%eax
80102319:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010231b:	a1 94 26 11 80       	mov    0x80112694,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102320:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
80102326:	85 c0                	test   %eax,%eax
80102328:	75 06                	jne    80102330 <kfree+0x60>
    release(&kmem.lock);
}
8010232a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010232d:	c9                   	leave  
8010232e:	c3                   	ret    
8010232f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102330:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
80102337:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010233a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010233b:	e9 00 21 00 00       	jmp    80104440 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102340:	83 ec 0c             	sub    $0xc,%esp
80102343:	68 60 26 11 80       	push   $0x80112660
80102348:	e8 13 1f 00 00       	call   80104260 <acquire>
8010234d:	83 c4 10             	add    $0x10,%esp
80102350:	eb c2                	jmp    80102314 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102352:	83 ec 0c             	sub    $0xc,%esp
80102355:	68 92 71 10 80       	push   $0x80107192
8010235a:	e8 11 e0 ff ff       	call   80100370 <panic>
8010235f:	90                   	nop

80102360 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	56                   	push   %esi
80102364:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102365:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80102368:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010236b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102371:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102377:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010237d:	39 de                	cmp    %ebx,%esi
8010237f:	72 23                	jb     801023a4 <freerange+0x44>
80102381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102388:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010238e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102391:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102397:	50                   	push   %eax
80102398:	e8 33 ff ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	39 f3                	cmp    %esi,%ebx
801023a2:	76 e4                	jbe    80102388 <freerange+0x28>
    kfree(p);
}
801023a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023a7:	5b                   	pop    %ebx
801023a8:	5e                   	pop    %esi
801023a9:	5d                   	pop    %ebp
801023aa:	c3                   	ret    
801023ab:	90                   	nop
801023ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023b0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	56                   	push   %esi
801023b4:	53                   	push   %ebx
801023b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023b8:	83 ec 08             	sub    $0x8,%esp
801023bb:	68 98 71 10 80       	push   $0x80107198
801023c0:	68 60 26 11 80       	push   $0x80112660
801023c5:	e8 76 1e 00 00       	call   80104240 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023cd:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801023d0:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
801023d7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ec:	39 de                	cmp    %ebx,%esi
801023ee:	72 1c                	jb     8010240c <kinit1+0x5c>
    kfree(p);
801023f0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023f6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023ff:	50                   	push   %eax
80102400:	e8 cb fe ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102405:	83 c4 10             	add    $0x10,%esp
80102408:	39 de                	cmp    %ebx,%esi
8010240a:	73 e4                	jae    801023f0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010240c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010240f:	5b                   	pop    %ebx
80102410:	5e                   	pop    %esi
80102411:	5d                   	pop    %ebp
80102412:	c3                   	ret    
80102413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102420 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102425:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102428:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010242b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102431:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102437:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010243d:	39 de                	cmp    %ebx,%esi
8010243f:	72 23                	jb     80102464 <kinit2+0x44>
80102441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102448:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010244e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102451:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102457:	50                   	push   %eax
80102458:	e8 73 fe ff ff       	call   801022d0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010245d:	83 c4 10             	add    $0x10,%esp
80102460:	39 de                	cmp    %ebx,%esi
80102462:	73 e4                	jae    80102448 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80102464:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
8010246b:	00 00 00 
}
8010246e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102471:	5b                   	pop    %ebx
80102472:	5e                   	pop    %esi
80102473:	5d                   	pop    %ebp
80102474:	c3                   	ret    
80102475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	53                   	push   %ebx
80102484:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102487:	a1 94 26 11 80       	mov    0x80112694,%eax
8010248c:	85 c0                	test   %eax,%eax
8010248e:	75 30                	jne    801024c0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102490:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102496:	85 db                	test   %ebx,%ebx
80102498:	74 1c                	je     801024b6 <kalloc+0x36>
    kmem.freelist = r->next;
8010249a:	8b 13                	mov    (%ebx),%edx
8010249c:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
801024a2:	85 c0                	test   %eax,%eax
801024a4:	74 10                	je     801024b6 <kalloc+0x36>
    release(&kmem.lock);
801024a6:	83 ec 0c             	sub    $0xc,%esp
801024a9:	68 60 26 11 80       	push   $0x80112660
801024ae:	e8 8d 1f 00 00       	call   80104440 <release>
801024b3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801024b6:	89 d8                	mov    %ebx,%eax
801024b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801024bb:	c9                   	leave  
801024bc:	c3                   	ret    
801024bd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024c0:	83 ec 0c             	sub    $0xc,%esp
801024c3:	68 60 26 11 80       	push   $0x80112660
801024c8:	e8 93 1d 00 00       	call   80104260 <acquire>
  r = kmem.freelist;
801024cd:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
801024d3:	83 c4 10             	add    $0x10,%esp
801024d6:	a1 94 26 11 80       	mov    0x80112694,%eax
801024db:	85 db                	test   %ebx,%ebx
801024dd:	75 bb                	jne    8010249a <kalloc+0x1a>
801024df:	eb c1                	jmp    801024a2 <kalloc+0x22>
801024e1:	66 90                	xchg   %ax,%ax
801024e3:	66 90                	xchg   %ax,%ax
801024e5:	66 90                	xchg   %ax,%ax
801024e7:	66 90                	xchg   %ax,%ax
801024e9:	66 90                	xchg   %ax,%ax
801024eb:	66 90                	xchg   %ax,%ax
801024ed:	66 90                	xchg   %ax,%ax
801024ef:	90                   	nop

801024f0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801024f0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024f1:	ba 64 00 00 00       	mov    $0x64,%edx
801024f6:	89 e5                	mov    %esp,%ebp
801024f8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801024f9:	a8 01                	test   $0x1,%al
801024fb:	0f 84 af 00 00 00    	je     801025b0 <kbdgetc+0xc0>
80102501:	ba 60 00 00 00       	mov    $0x60,%edx
80102506:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102507:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010250a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102510:	74 7e                	je     80102590 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102512:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102514:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010251a:	79 24                	jns    80102540 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010251c:	f6 c1 40             	test   $0x40,%cl
8010251f:	75 05                	jne    80102526 <kbdgetc+0x36>
80102521:	89 c2                	mov    %eax,%edx
80102523:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102526:	0f b6 82 c0 72 10 80 	movzbl -0x7fef8d40(%edx),%eax
8010252d:	83 c8 40             	or     $0x40,%eax
80102530:	0f b6 c0             	movzbl %al,%eax
80102533:	f7 d0                	not    %eax
80102535:	21 c8                	and    %ecx,%eax
80102537:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010253c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010253e:	5d                   	pop    %ebp
8010253f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102540:	f6 c1 40             	test   $0x40,%cl
80102543:	74 09                	je     8010254e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102545:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102548:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010254b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010254e:	0f b6 82 c0 72 10 80 	movzbl -0x7fef8d40(%edx),%eax
80102555:	09 c1                	or     %eax,%ecx
80102557:	0f b6 82 c0 71 10 80 	movzbl -0x7fef8e40(%edx),%eax
8010255e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102560:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102562:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102568:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010256b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010256e:	8b 04 85 a0 71 10 80 	mov    -0x7fef8e60(,%eax,4),%eax
80102575:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102579:	74 c3                	je     8010253e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010257b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010257e:	83 fa 19             	cmp    $0x19,%edx
80102581:	77 1d                	ja     801025a0 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102583:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102586:	5d                   	pop    %ebp
80102587:	c3                   	ret    
80102588:	90                   	nop
80102589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102590:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102592:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102599:	5d                   	pop    %ebp
8010259a:	c3                   	ret    
8010259b:	90                   	nop
8010259c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025a0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025a3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801025a6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801025a7:	83 f9 19             	cmp    $0x19,%ecx
801025aa:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801025ad:	c3                   	ret    
801025ae:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025b5:	5d                   	pop    %ebp
801025b6:	c3                   	ret    
801025b7:	89 f6                	mov    %esi,%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025c0 <kbdintr>:

void
kbdintr(void)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801025c6:	68 f0 24 10 80       	push   $0x801024f0
801025cb:	e8 20 e2 ff ff       	call   801007f0 <consoleintr>
}
801025d0:	83 c4 10             	add    $0x10,%esp
801025d3:	c9                   	leave  
801025d4:	c3                   	ret    
801025d5:	66 90                	xchg   %ax,%ax
801025d7:	66 90                	xchg   %ax,%ax
801025d9:	66 90                	xchg   %ax,%ax
801025db:	66 90                	xchg   %ax,%ax
801025dd:	66 90                	xchg   %ax,%ax
801025df:	90                   	nop

801025e0 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
801025e0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
801025e5:	55                   	push   %ebp
801025e6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801025e8:	85 c0                	test   %eax,%eax
801025ea:	0f 84 c8 00 00 00    	je     801026b8 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025f0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801025f7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801025fa:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801025fd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102604:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102607:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010260a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102611:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102614:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102617:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010261e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102621:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102624:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010262b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010262e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102631:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102638:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010263b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010263e:	8b 50 30             	mov    0x30(%eax),%edx
80102641:	c1 ea 10             	shr    $0x10,%edx
80102644:	80 fa 03             	cmp    $0x3,%dl
80102647:	77 77                	ja     801026c0 <lapicinit+0xe0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102649:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102650:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102653:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102656:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010265d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102660:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102663:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010266a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102670:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102677:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010267a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010267d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102684:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102687:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010268a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102691:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102694:	8b 50 20             	mov    0x20(%eax),%edx
80102697:	89 f6                	mov    %esi,%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801026a0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801026a6:	80 e6 10             	and    $0x10,%dh
801026a9:	75 f5                	jne    801026a0 <lapicinit+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ab:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801026b2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801026b8:	5d                   	pop    %ebp
801026b9:	c3                   	ret    
801026ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801026c7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ca:	8b 50 20             	mov    0x20(%eax),%edx
801026cd:	e9 77 ff ff ff       	jmp    80102649 <lapicinit+0x69>
801026d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026e0 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	56                   	push   %esi
801026e4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801026e5:	9c                   	pushf  
801026e6:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
801026e7:	f6 c4 02             	test   $0x2,%ah
801026ea:	74 12                	je     801026fe <cpunum+0x1e>
    static int n;
    if(n++ == 0)
801026ec:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
801026f1:	8d 50 01             	lea    0x1(%eax),%edx
801026f4:	85 c0                	test   %eax,%eax
801026f6:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
801026fc:	74 4d                	je     8010274b <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
801026fe:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102703:	85 c0                	test   %eax,%eax
80102705:	74 60                	je     80102767 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
80102707:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
8010270a:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102710:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
80102713:	85 f6                	test   %esi,%esi
80102715:	7e 59                	jle    80102770 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102717:	0f b6 05 a0 27 11 80 	movzbl 0x801127a0,%eax
8010271e:	39 c3                	cmp    %eax,%ebx
80102720:	74 45                	je     80102767 <cpunum+0x87>
80102722:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
80102727:	31 c0                	xor    %eax,%eax
80102729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
80102730:	83 c0 01             	add    $0x1,%eax
80102733:	39 f0                	cmp    %esi,%eax
80102735:	74 39                	je     80102770 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102737:	0f b6 0a             	movzbl (%edx),%ecx
8010273a:	81 c2 bc 00 00 00    	add    $0xbc,%edx
80102740:	39 cb                	cmp    %ecx,%ebx
80102742:	75 ec                	jne    80102730 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
80102744:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102747:	5b                   	pop    %ebx
80102748:	5e                   	pop    %esi
80102749:	5d                   	pop    %ebp
8010274a:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
8010274b:	83 ec 08             	sub    $0x8,%esp
8010274e:	ff 75 04             	pushl  0x4(%ebp)
80102751:	68 c0 73 10 80       	push   $0x801073c0
80102756:	e8 05 df ff ff       	call   80100660 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
8010275b:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
80102760:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
80102763:	85 c0                	test   %eax,%eax
80102765:	75 a0                	jne    80102707 <cpunum+0x27>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
80102767:	8d 65 f8             	lea    -0x8(%ebp),%esp
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
    return 0;
8010276a:	31 c0                	xor    %eax,%eax
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
8010276c:	5b                   	pop    %ebx
8010276d:	5e                   	pop    %esi
8010276e:	5d                   	pop    %ebp
8010276f:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102770:	83 ec 0c             	sub    $0xc,%esp
80102773:	68 ec 73 10 80       	push   $0x801073ec
80102778:	e8 f3 db ff ff       	call   80100370 <panic>
8010277d:	8d 76 00             	lea    0x0(%esi),%esi

80102780 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102780:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102785:	55                   	push   %ebp
80102786:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102788:	85 c0                	test   %eax,%eax
8010278a:	74 0d                	je     80102799 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010278c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102793:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102796:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102799:	5d                   	pop    %ebp
8010279a:	c3                   	ret    
8010279b:	90                   	nop
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027a0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
}
801027a3:	5d                   	pop    %ebp
801027a4:	c3                   	ret    
801027a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027b0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027b0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b1:	ba 70 00 00 00       	mov    $0x70,%edx
801027b6:	b8 0f 00 00 00       	mov    $0xf,%eax
801027bb:	89 e5                	mov    %esp,%ebp
801027bd:	53                   	push   %ebx
801027be:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027c4:	ee                   	out    %al,(%dx)
801027c5:	ba 71 00 00 00       	mov    $0x71,%edx
801027ca:	b8 0a 00 00 00       	mov    $0xa,%eax
801027cf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027d0:	31 c0                	xor    %eax,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027d2:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027d5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027db:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027dd:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801027e0:	c1 e8 04             	shr    $0x4,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027e3:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027e5:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801027e8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ee:	a1 9c 26 11 80       	mov    0x8011269c,%eax
801027f3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f9:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027fc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102803:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102806:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102809:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102810:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102813:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102816:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281c:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010281f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102825:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102828:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102831:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102837:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010283a:	5b                   	pop    %ebx
8010283b:	5d                   	pop    %ebp
8010283c:	c3                   	ret    
8010283d:	8d 76 00             	lea    0x0(%esi),%esi

80102840 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102840:	55                   	push   %ebp
80102841:	ba 70 00 00 00       	mov    $0x70,%edx
80102846:	b8 0b 00 00 00       	mov    $0xb,%eax
8010284b:	89 e5                	mov    %esp,%ebp
8010284d:	57                   	push   %edi
8010284e:	56                   	push   %esi
8010284f:	53                   	push   %ebx
80102850:	83 ec 4c             	sub    $0x4c,%esp
80102853:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102854:	ba 71 00 00 00       	mov    $0x71,%edx
80102859:	ec                   	in     (%dx),%al
8010285a:	83 e0 04             	and    $0x4,%eax
8010285d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102860:	31 db                	xor    %ebx,%ebx
80102862:	88 45 b7             	mov    %al,-0x49(%ebp)
80102865:	bf 70 00 00 00       	mov    $0x70,%edi
8010286a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102870:	89 d8                	mov    %ebx,%eax
80102872:	89 fa                	mov    %edi,%edx
80102874:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102875:	b9 71 00 00 00       	mov    $0x71,%ecx
8010287a:	89 ca                	mov    %ecx,%edx
8010287c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010287d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102880:	89 fa                	mov    %edi,%edx
80102882:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102885:	b8 02 00 00 00       	mov    $0x2,%eax
8010288a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288b:	89 ca                	mov    %ecx,%edx
8010288d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010288e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102891:	89 fa                	mov    %edi,%edx
80102893:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102896:	b8 04 00 00 00       	mov    $0x4,%eax
8010289b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289c:	89 ca                	mov    %ecx,%edx
8010289e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010289f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a2:	89 fa                	mov    %edi,%edx
801028a4:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028a7:	b8 07 00 00 00       	mov    $0x7,%eax
801028ac:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ad:	89 ca                	mov    %ecx,%edx
801028af:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801028b0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028b3:	89 fa                	mov    %edi,%edx
801028b5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028b8:	b8 08 00 00 00       	mov    $0x8,%eax
801028bd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028be:	89 ca                	mov    %ecx,%edx
801028c0:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801028c1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c4:	89 fa                	mov    %edi,%edx
801028c6:	89 45 c8             	mov    %eax,-0x38(%ebp)
801028c9:	b8 09 00 00 00       	mov    $0x9,%eax
801028ce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028cf:	89 ca                	mov    %ecx,%edx
801028d1:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801028d2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d5:	89 fa                	mov    %edi,%edx
801028d7:	89 45 cc             	mov    %eax,-0x34(%ebp)
801028da:	b8 0a 00 00 00       	mov    $0xa,%eax
801028df:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e0:	89 ca                	mov    %ecx,%edx
801028e2:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028e3:	84 c0                	test   %al,%al
801028e5:	78 89                	js     80102870 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e7:	89 d8                	mov    %ebx,%eax
801028e9:	89 fa                	mov    %edi,%edx
801028eb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ec:	89 ca                	mov    %ecx,%edx
801028ee:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028ef:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f2:	89 fa                	mov    %edi,%edx
801028f4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028f7:	b8 02 00 00 00       	mov    $0x2,%eax
801028fc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fd:	89 ca                	mov    %ecx,%edx
801028ff:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102900:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102903:	89 fa                	mov    %edi,%edx
80102905:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102908:	b8 04 00 00 00       	mov    $0x4,%eax
8010290d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290e:	89 ca                	mov    %ecx,%edx
80102910:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102911:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102914:	89 fa                	mov    %edi,%edx
80102916:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102919:	b8 07 00 00 00       	mov    $0x7,%eax
8010291e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291f:	89 ca                	mov    %ecx,%edx
80102921:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102922:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102925:	89 fa                	mov    %edi,%edx
80102927:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010292a:	b8 08 00 00 00       	mov    $0x8,%eax
8010292f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102933:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 fa                	mov    %edi,%edx
80102938:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010293b:	b8 09 00 00 00       	mov    $0x9,%eax
80102940:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102941:	89 ca                	mov    %ecx,%edx
80102943:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102944:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102947:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
8010294a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010294d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102950:	6a 18                	push   $0x18
80102952:	56                   	push   %esi
80102953:	50                   	push   %eax
80102954:	e8 87 1b 00 00       	call   801044e0 <memcmp>
80102959:	83 c4 10             	add    $0x10,%esp
8010295c:	85 c0                	test   %eax,%eax
8010295e:	0f 85 0c ff ff ff    	jne    80102870 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102964:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102968:	75 78                	jne    801029e2 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010296a:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010296d:	89 c2                	mov    %eax,%edx
8010296f:	83 e0 0f             	and    $0xf,%eax
80102972:	c1 ea 04             	shr    $0x4,%edx
80102975:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102978:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010297e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102981:	89 c2                	mov    %eax,%edx
80102983:	83 e0 0f             	and    $0xf,%eax
80102986:	c1 ea 04             	shr    $0x4,%edx
80102989:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010298f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102992:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102995:	89 c2                	mov    %eax,%edx
80102997:	83 e0 0f             	and    $0xf,%eax
8010299a:	c1 ea 04             	shr    $0x4,%edx
8010299d:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a0:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a3:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029a6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029a9:	89 c2                	mov    %eax,%edx
801029ab:	83 e0 0f             	and    $0xf,%eax
801029ae:	c1 ea 04             	shr    $0x4,%edx
801029b1:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b4:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029b7:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029ba:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029bd:	89 c2                	mov    %eax,%edx
801029bf:	83 e0 0f             	and    $0xf,%eax
801029c2:	c1 ea 04             	shr    $0x4,%edx
801029c5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029c8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029cb:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029ce:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029d1:	89 c2                	mov    %eax,%edx
801029d3:	83 e0 0f             	and    $0xf,%eax
801029d6:	c1 ea 04             	shr    $0x4,%edx
801029d9:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029dc:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029df:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029e2:	8b 75 08             	mov    0x8(%ebp),%esi
801029e5:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029e8:	89 06                	mov    %eax,(%esi)
801029ea:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029ed:	89 46 04             	mov    %eax,0x4(%esi)
801029f0:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029f3:	89 46 08             	mov    %eax,0x8(%esi)
801029f6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029f9:	89 46 0c             	mov    %eax,0xc(%esi)
801029fc:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029ff:	89 46 10             	mov    %eax,0x10(%esi)
80102a02:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a05:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a08:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a0f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a12:	5b                   	pop    %ebx
80102a13:	5e                   	pop    %esi
80102a14:	5f                   	pop    %edi
80102a15:	5d                   	pop    %ebp
80102a16:	c3                   	ret    
80102a17:	66 90                	xchg   %ax,%ax
80102a19:	66 90                	xchg   %ax,%ax
80102a1b:	66 90                	xchg   %ax,%ax
80102a1d:	66 90                	xchg   %ax,%ax
80102a1f:	90                   	nop

80102a20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a20:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102a26:	85 c9                	test   %ecx,%ecx
80102a28:	0f 8e 85 00 00 00    	jle    80102ab3 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a2e:	55                   	push   %ebp
80102a2f:	89 e5                	mov    %esp,%ebp
80102a31:	57                   	push   %edi
80102a32:	56                   	push   %esi
80102a33:	53                   	push   %ebx
80102a34:	31 db                	xor    %ebx,%ebx
80102a36:	83 ec 0c             	sub    $0xc,%esp
80102a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a40:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102a45:	83 ec 08             	sub    $0x8,%esp
80102a48:	01 d8                	add    %ebx,%eax
80102a4a:	83 c0 01             	add    $0x1,%eax
80102a4d:	50                   	push   %eax
80102a4e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102a54:	e8 77 d6 ff ff       	call   801000d0 <bread>
80102a59:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5b:	58                   	pop    %eax
80102a5c:	5a                   	pop    %edx
80102a5d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102a64:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a6a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6d:	e8 5e d6 ff ff       	call   801000d0 <bread>
80102a72:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a74:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a77:	83 c4 0c             	add    $0xc,%esp
80102a7a:	68 00 02 00 00       	push   $0x200
80102a7f:	50                   	push   %eax
80102a80:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a83:	50                   	push   %eax
80102a84:	e8 b7 1a 00 00       	call   80104540 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 0f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a91:	89 3c 24             	mov    %edi,(%esp)
80102a94:	e8 47 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 3f d7 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102aa1:	83 c4 10             	add    $0x10,%esp
80102aa4:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102aaa:	7f 94                	jg     80102a40 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102aac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aaf:	5b                   	pop    %ebx
80102ab0:	5e                   	pop    %esi
80102ab1:	5f                   	pop    %edi
80102ab2:	5d                   	pop    %ebp
80102ab3:	f3 c3                	repz ret 
80102ab5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ac0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	53                   	push   %ebx
80102ac4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ac7:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102acd:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ad3:	e8 f8 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ad8:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102ade:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102ae1:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ae3:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ae5:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ae8:	7e 1f                	jle    80102b09 <write_head+0x49>
80102aea:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102af1:	31 d2                	xor    %edx,%edx
80102af3:	90                   	nop
80102af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102af8:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102afe:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102b02:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b05:	39 c2                	cmp    %eax,%edx
80102b07:	75 ef                	jne    80102af8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b09:	83 ec 0c             	sub    $0xc,%esp
80102b0c:	53                   	push   %ebx
80102b0d:	e8 8e d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b12:	89 1c 24             	mov    %ebx,(%esp)
80102b15:	e8 c6 d6 ff ff       	call   801001e0 <brelse>
}
80102b1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b1d:	c9                   	leave  
80102b1e:	c3                   	ret    
80102b1f:	90                   	nop

80102b20 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	53                   	push   %ebx
80102b24:	83 ec 2c             	sub    $0x2c,%esp
80102b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b2a:	68 fc 73 10 80       	push   $0x801073fc
80102b2f:	68 a0 26 11 80       	push   $0x801126a0
80102b34:	e8 07 17 00 00       	call   80104240 <initlock>
  readsb(dev, &sb);
80102b39:	58                   	pop    %eax
80102b3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 5b e8 ff ff       	call   801013a0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b45:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b48:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b4b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102b4c:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b52:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b58:	a3 d4 26 11 80       	mov    %eax,0x801126d4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b5d:	5a                   	pop    %edx
80102b5e:	50                   	push   %eax
80102b5f:	53                   	push   %ebx
80102b60:	e8 6b d5 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b65:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b68:	83 c4 10             	add    $0x10,%esp
80102b6b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b6d:	89 0d e8 26 11 80    	mov    %ecx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102b73:	7e 1c                	jle    80102b91 <initlog+0x71>
80102b75:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102b7c:	31 d2                	xor    %edx,%edx
80102b7e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102b80:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b84:	83 c2 04             	add    $0x4,%edx
80102b87:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b8d:	39 da                	cmp    %ebx,%edx
80102b8f:	75 ef                	jne    80102b80 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b91:	83 ec 0c             	sub    $0xc,%esp
80102b94:	50                   	push   %eax
80102b95:	e8 46 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b9a:	e8 81 fe ff ff       	call   80102a20 <install_trans>
  log.lh.n = 0;
80102b9f:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102ba6:	00 00 00 
  write_head(); // clear the log
80102ba9:	e8 12 ff ff ff       	call   80102ac0 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102bae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bb1:	c9                   	leave  
80102bb2:	c3                   	ret    
80102bb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bc6:	68 a0 26 11 80       	push   $0x801126a0
80102bcb:	e8 90 16 00 00       	call   80104260 <acquire>
80102bd0:	83 c4 10             	add    $0x10,%esp
80102bd3:	eb 18                	jmp    80102bed <begin_op+0x2d>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bd8:	83 ec 08             	sub    $0x8,%esp
80102bdb:	68 a0 26 11 80       	push   $0x801126a0
80102be0:	68 a0 26 11 80       	push   $0x801126a0
80102be5:	e8 f6 11 00 00       	call   80103de0 <sleep>
80102bea:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102bed:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102bf2:	85 c0                	test   %eax,%eax
80102bf4:	75 e2                	jne    80102bd8 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bf6:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102bfb:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102c01:	83 c0 01             	add    $0x1,%eax
80102c04:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c07:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c0a:	83 fa 1e             	cmp    $0x1e,%edx
80102c0d:	7f c9                	jg     80102bd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c0f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102c12:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102c17:	68 a0 26 11 80       	push   $0x801126a0
80102c1c:	e8 1f 18 00 00       	call   80104440 <release>
      break;
    }
  }
}
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	c9                   	leave  
80102c25:	c3                   	ret    
80102c26:	8d 76 00             	lea    0x0(%esi),%esi
80102c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c30 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	57                   	push   %edi
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c39:	68 a0 26 11 80       	push   $0x801126a0
80102c3e:	e8 1d 16 00 00       	call   80104260 <acquire>
  log.outstanding -= 1;
80102c43:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102c48:	8b 1d e0 26 11 80    	mov    0x801126e0,%ebx
80102c4e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c51:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102c54:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c56:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102c5b:	0f 85 23 01 00 00    	jne    80102d84 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102c61:	85 c0                	test   %eax,%eax
80102c63:	0f 85 f7 00 00 00    	jne    80102d60 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c69:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c6c:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102c73:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c76:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c78:	68 a0 26 11 80       	push   $0x801126a0
80102c7d:	e8 be 17 00 00       	call   80104440 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c82:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102c88:	83 c4 10             	add    $0x10,%esp
80102c8b:	85 c9                	test   %ecx,%ecx
80102c8d:	0f 8e 8a 00 00 00    	jle    80102d1d <end_op+0xed>
80102c93:	90                   	nop
80102c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c98:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102c9d:	83 ec 08             	sub    $0x8,%esp
80102ca0:	01 d8                	add    %ebx,%eax
80102ca2:	83 c0 01             	add    $0x1,%eax
80102ca5:	50                   	push   %eax
80102ca6:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102cac:	e8 1f d4 ff ff       	call   801000d0 <bread>
80102cb1:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cb3:	58                   	pop    %eax
80102cb4:	5a                   	pop    %edx
80102cb5:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102cbc:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cc2:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cc5:	e8 06 d4 ff ff       	call   801000d0 <bread>
80102cca:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ccc:	8d 40 5c             	lea    0x5c(%eax),%eax
80102ccf:	83 c4 0c             	add    $0xc,%esp
80102cd2:	68 00 02 00 00       	push   $0x200
80102cd7:	50                   	push   %eax
80102cd8:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cdb:	50                   	push   %eax
80102cdc:	e8 5f 18 00 00       	call   80104540 <memmove>
    bwrite(to);  // write the log
80102ce1:	89 34 24             	mov    %esi,(%esp)
80102ce4:	e8 b7 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ce9:	89 3c 24             	mov    %edi,(%esp)
80102cec:	e8 ef d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102cf1:	89 34 24             	mov    %esi,(%esp)
80102cf4:	e8 e7 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cf9:	83 c4 10             	add    $0x10,%esp
80102cfc:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d02:	7c 94                	jl     80102c98 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d04:	e8 b7 fd ff ff       	call   80102ac0 <write_head>
    install_trans(); // Now install writes to home locations
80102d09:	e8 12 fd ff ff       	call   80102a20 <install_trans>
    log.lh.n = 0;
80102d0e:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d15:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d18:	e8 a3 fd ff ff       	call   80102ac0 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d1d:	83 ec 0c             	sub    $0xc,%esp
80102d20:	68 a0 26 11 80       	push   $0x801126a0
80102d25:	e8 36 15 00 00       	call   80104260 <acquire>
    log.committing = 0;
    wakeup(&log);
80102d2a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102d31:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102d38:	00 00 00 
    wakeup(&log);
80102d3b:	e8 40 12 00 00       	call   80103f80 <wakeup>
    release(&log.lock);
80102d40:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d47:	e8 f4 16 00 00       	call   80104440 <release>
80102d4c:	83 c4 10             	add    $0x10,%esp
  }
}
80102d4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d52:	5b                   	pop    %ebx
80102d53:	5e                   	pop    %esi
80102d54:	5f                   	pop    %edi
80102d55:	5d                   	pop    %ebp
80102d56:	c3                   	ret    
80102d57:	89 f6                	mov    %esi,%esi
80102d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80102d60:	83 ec 0c             	sub    $0xc,%esp
80102d63:	68 a0 26 11 80       	push   $0x801126a0
80102d68:	e8 13 12 00 00       	call   80103f80 <wakeup>
  }
  release(&log.lock);
80102d6d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d74:	e8 c7 16 00 00       	call   80104440 <release>
80102d79:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102d7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d7f:	5b                   	pop    %ebx
80102d80:	5e                   	pop    %esi
80102d81:	5f                   	pop    %edi
80102d82:	5d                   	pop    %ebp
80102d83:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d84:	83 ec 0c             	sub    $0xc,%esp
80102d87:	68 00 74 10 80       	push   $0x80107400
80102d8c:	e8 df d5 ff ff       	call   80100370 <panic>
80102d91:	eb 0d                	jmp    80102da0 <log_write>
80102d93:	90                   	nop
80102d94:	90                   	nop
80102d95:	90                   	nop
80102d96:	90                   	nop
80102d97:	90                   	nop
80102d98:	90                   	nop
80102d99:	90                   	nop
80102d9a:	90                   	nop
80102d9b:	90                   	nop
80102d9c:	90                   	nop
80102d9d:	90                   	nop
80102d9e:	90                   	nop
80102d9f:	90                   	nop

80102da0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102da0:	55                   	push   %ebp
80102da1:	89 e5                	mov    %esp,%ebp
80102da3:	53                   	push   %ebx
80102da4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da7:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102dad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102db0:	83 fa 1d             	cmp    $0x1d,%edx
80102db3:	0f 8f 97 00 00 00    	jg     80102e50 <log_write+0xb0>
80102db9:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102dbe:	83 e8 01             	sub    $0x1,%eax
80102dc1:	39 c2                	cmp    %eax,%edx
80102dc3:	0f 8d 87 00 00 00    	jge    80102e50 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102dc9:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102dce:	85 c0                	test   %eax,%eax
80102dd0:	0f 8e 87 00 00 00    	jle    80102e5d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dd6:	83 ec 0c             	sub    $0xc,%esp
80102dd9:	68 a0 26 11 80       	push   $0x801126a0
80102dde:	e8 7d 14 00 00       	call   80104260 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102de3:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102de9:	83 c4 10             	add    $0x10,%esp
80102dec:	83 fa 00             	cmp    $0x0,%edx
80102def:	7e 50                	jle    80102e41 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102df4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102df6:	3b 0d ec 26 11 80    	cmp    0x801126ec,%ecx
80102dfc:	75 0b                	jne    80102e09 <log_write+0x69>
80102dfe:	eb 38                	jmp    80102e38 <log_write+0x98>
80102e00:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102e07:	74 2f                	je     80102e38 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e09:	83 c0 01             	add    $0x1,%eax
80102e0c:	39 d0                	cmp    %edx,%eax
80102e0e:	75 f0                	jne    80102e00 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e10:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e17:	83 c2 01             	add    $0x1,%edx
80102e1a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102e20:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e23:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102e2a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e2d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e2e:	e9 0d 16 00 00       	jmp    80104440 <release>
80102e33:	90                   	nop
80102e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e38:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102e3f:	eb df                	jmp    80102e20 <log_write+0x80>
80102e41:	8b 43 08             	mov    0x8(%ebx),%eax
80102e44:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102e49:	75 d5                	jne    80102e20 <log_write+0x80>
80102e4b:	eb ca                	jmp    80102e17 <log_write+0x77>
80102e4d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e50:	83 ec 0c             	sub    $0xc,%esp
80102e53:	68 0f 74 10 80       	push   $0x8010740f
80102e58:	e8 13 d5 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e5d:	83 ec 0c             	sub    $0xc,%esp
80102e60:	68 25 74 10 80       	push   $0x80107425
80102e65:	e8 06 d5 ff ff       	call   80100370 <panic>
80102e6a:	66 90                	xchg   %ax,%ax
80102e6c:	66 90                	xchg   %ax,%ax
80102e6e:	66 90                	xchg   %ax,%ax

80102e70 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102e76:	e8 65 f8 ff ff       	call   801026e0 <cpunum>
80102e7b:	83 ec 08             	sub    $0x8,%esp
80102e7e:	50                   	push   %eax
80102e7f:	68 40 74 10 80       	push   $0x80107440
80102e84:	e8 d7 d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e89:	e8 f2 28 00 00       	call   80105780 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102e8e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e95:	b8 01 00 00 00       	mov    $0x1,%eax
80102e9a:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102ea1:	e8 5a 0c 00 00       	call   80103b00 <scheduler>
80102ea6:	8d 76 00             	lea    0x0(%esi),%esi
80102ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102eb0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102eb6:	e8 d5 3a 00 00       	call   80106990 <switchkvm>
  seginit();
80102ebb:	e8 f0 38 00 00       	call   801067b0 <seginit>
  lapicinit();
80102ec0:	e8 1b f7 ff ff       	call   801025e0 <lapicinit>
  mpmain();
80102ec5:	e8 a6 ff ff ff       	call   80102e70 <mpmain>
80102eca:	66 90                	xchg   %ax,%ax
80102ecc:	66 90                	xchg   %ax,%ax
80102ece:	66 90                	xchg   %ax,%ax

80102ed0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102ed0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ed4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ed7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eda:	55                   	push   %ebp
80102edb:	89 e5                	mov    %esp,%ebp
80102edd:	53                   	push   %ebx
80102ede:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102edf:	83 ec 08             	sub    $0x8,%esp
80102ee2:	68 00 00 40 80       	push   $0x80400000
80102ee7:	68 28 55 11 80       	push   $0x80115528
80102eec:	e8 bf f4 ff ff       	call   801023b0 <kinit1>
  kvmalloc();      // kernel page table
80102ef1:	e8 7a 3a 00 00       	call   80106970 <kvmalloc>
  mpinit();        // detect other processors
80102ef6:	e8 b5 01 00 00       	call   801030b0 <mpinit>
  lapicinit();     // interrupt controller
80102efb:	e8 e0 f6 ff ff       	call   801025e0 <lapicinit>
  seginit();       // segment descriptors
80102f00:	e8 ab 38 00 00       	call   801067b0 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f05:	e8 d6 f7 ff ff       	call   801026e0 <cpunum>
80102f0a:	5a                   	pop    %edx
80102f0b:	59                   	pop    %ecx
80102f0c:	50                   	push   %eax
80102f0d:	68 51 74 10 80       	push   $0x80107451
80102f12:	e8 49 d7 ff ff       	call   80100660 <cprintf>
  picinit();       // another interrupt controller
80102f17:	e8 a4 03 00 00       	call   801032c0 <picinit>
  ioapicinit();    // another interrupt controller
80102f1c:	e8 af f2 ff ff       	call   801021d0 <ioapicinit>
  consoleinit();   // console hardware
80102f21:	e8 7a da ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102f26:	e8 55 2b 00 00       	call   80105a80 <uartinit>
  pinit();         // process table
80102f2b:	e8 30 09 00 00       	call   80103860 <pinit>
  tvinit();        // trap vectors
80102f30:	e8 ab 27 00 00       	call   801056e0 <tvinit>
  binit();         // buffer cache
80102f35:	e8 06 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f3a:	e8 01 de ff ff       	call   80100d40 <fileinit>
  ideinit();       // disk
80102f3f:	e8 5c f0 ff ff       	call   80101fa0 <ideinit>
  if(!ismp)
80102f44:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
80102f4a:	83 c4 10             	add    $0x10,%esp
80102f4d:	85 db                	test   %ebx,%ebx
80102f4f:	0f 84 ca 00 00 00    	je     8010301f <main+0x14f>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f55:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102f58:	bb a0 27 11 80       	mov    $0x801127a0,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f5d:	68 8a 00 00 00       	push   $0x8a
80102f62:	68 8c a4 10 80       	push   $0x8010a48c
80102f67:	68 00 70 00 80       	push   $0x80007000
80102f6c:	e8 cf 15 00 00       	call   80104540 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f71:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102f78:	00 00 00 
80102f7b:	83 c4 10             	add    $0x10,%esp
80102f7e:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f83:	39 d8                	cmp    %ebx,%eax
80102f85:	76 7c                	jbe    80103003 <main+0x133>
80102f87:	89 f6                	mov    %esi,%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == cpus+cpunum())  // We've started already.
80102f90:	e8 4b f7 ff ff       	call   801026e0 <cpunum>
80102f95:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102f9b:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fa0:	39 c3                	cmp    %eax,%ebx
80102fa2:	74 46                	je     80102fea <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102fa4:	e8 d7 f4 ff ff       	call   80102480 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102fa9:	83 ec 08             	sub    $0x8,%esp

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102fac:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80102fb1:	c7 05 f8 6f 00 80 b0 	movl   $0x80102eb0,0x80006ff8
80102fb8:	2e 10 80 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102fbb:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102fc0:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102fc7:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
80102fca:	68 00 70 00 00       	push   $0x7000
80102fcf:	0f b6 03             	movzbl (%ebx),%eax
80102fd2:	50                   	push   %eax
80102fd3:	e8 d8 f7 ff ff       	call   801027b0 <lapicstartap>
80102fd8:	83 c4 10             	add    $0x10,%esp
80102fdb:	90                   	nop
80102fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fe0:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80102fe6:	85 c0                	test   %eax,%eax
80102fe8:	74 f6                	je     80102fe0 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102fea:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102ff1:	00 00 00 
80102ff4:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
80102ffa:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102fff:	39 c3                	cmp    %eax,%ebx
80103001:	72 8d                	jb     80102f90 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103003:	83 ec 08             	sub    $0x8,%esp
80103006:	68 00 00 00 8e       	push   $0x8e000000
8010300b:	68 00 00 40 80       	push   $0x80400000
80103010:	e8 0b f4 ff ff       	call   80102420 <kinit2>
  userinit();      // first user process
80103015:	e8 66 08 00 00       	call   80103880 <userinit>
  mpmain();        // finish this processor's setup
8010301a:	e8 51 fe ff ff       	call   80102e70 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
8010301f:	e8 5c 26 00 00       	call   80105680 <timerinit>
80103024:	e9 2c ff ff ff       	jmp    80102f55 <main+0x85>
80103029:	66 90                	xchg   %ax,%ax
8010302b:	66 90                	xchg   %ax,%ax
8010302d:	66 90                	xchg   %ax,%ax
8010302f:	90                   	nop

80103030 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	57                   	push   %edi
80103034:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103035:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010303b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010303c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010303f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103042:	39 de                	cmp    %ebx,%esi
80103044:	73 48                	jae    8010308e <mpsearch1+0x5e>
80103046:	8d 76 00             	lea    0x0(%esi),%esi
80103049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103050:	83 ec 04             	sub    $0x4,%esp
80103053:	8d 7e 10             	lea    0x10(%esi),%edi
80103056:	6a 04                	push   $0x4
80103058:	68 68 74 10 80       	push   $0x80107468
8010305d:	56                   	push   %esi
8010305e:	e8 7d 14 00 00       	call   801044e0 <memcmp>
80103063:	83 c4 10             	add    $0x10,%esp
80103066:	85 c0                	test   %eax,%eax
80103068:	75 1e                	jne    80103088 <mpsearch1+0x58>
8010306a:	8d 7e 10             	lea    0x10(%esi),%edi
8010306d:	89 f2                	mov    %esi,%edx
8010306f:	31 c9                	xor    %ecx,%ecx
80103071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103078:	0f b6 02             	movzbl (%edx),%eax
8010307b:	83 c2 01             	add    $0x1,%edx
8010307e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103080:	39 fa                	cmp    %edi,%edx
80103082:	75 f4                	jne    80103078 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103084:	84 c9                	test   %cl,%cl
80103086:	74 10                	je     80103098 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103088:	39 fb                	cmp    %edi,%ebx
8010308a:	89 fe                	mov    %edi,%esi
8010308c:	77 c2                	ja     80103050 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010308e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103091:	31 c0                	xor    %eax,%eax
}
80103093:	5b                   	pop    %ebx
80103094:	5e                   	pop    %esi
80103095:	5f                   	pop    %edi
80103096:	5d                   	pop    %ebp
80103097:	c3                   	ret    
80103098:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010309b:	89 f0                	mov    %esi,%eax
8010309d:	5b                   	pop    %ebx
8010309e:	5e                   	pop    %esi
8010309f:	5f                   	pop    %edi
801030a0:	5d                   	pop    %ebp
801030a1:	c3                   	ret    
801030a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801030b0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801030b0:	55                   	push   %ebp
801030b1:	89 e5                	mov    %esp,%ebp
801030b3:	57                   	push   %edi
801030b4:	56                   	push   %esi
801030b5:	53                   	push   %ebx
801030b6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801030b9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801030c0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801030c7:	c1 e0 08             	shl    $0x8,%eax
801030ca:	09 d0                	or     %edx,%eax
801030cc:	c1 e0 04             	shl    $0x4,%eax
801030cf:	85 c0                	test   %eax,%eax
801030d1:	75 1b                	jne    801030ee <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
801030d3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801030da:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801030e1:	c1 e0 08             	shl    $0x8,%eax
801030e4:	09 d0                	or     %edx,%eax
801030e6:	c1 e0 0a             	shl    $0xa,%eax
801030e9:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
801030ee:	ba 00 04 00 00       	mov    $0x400,%edx
801030f3:	e8 38 ff ff ff       	call   80103030 <mpsearch1>
801030f8:	85 c0                	test   %eax,%eax
801030fa:	89 c6                	mov    %eax,%esi
801030fc:	0f 84 66 01 00 00    	je     80103268 <mpinit+0x1b8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103102:	8b 5e 04             	mov    0x4(%esi),%ebx
80103105:	85 db                	test   %ebx,%ebx
80103107:	0f 84 d6 00 00 00    	je     801031e3 <mpinit+0x133>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010310d:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103113:	83 ec 04             	sub    $0x4,%esp
80103116:	6a 04                	push   $0x4
80103118:	68 6d 74 10 80       	push   $0x8010746d
8010311d:	50                   	push   %eax
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010311e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103121:	e8 ba 13 00 00       	call   801044e0 <memcmp>
80103126:	83 c4 10             	add    $0x10,%esp
80103129:	85 c0                	test   %eax,%eax
8010312b:	0f 85 b2 00 00 00    	jne    801031e3 <mpinit+0x133>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103131:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103138:	3c 01                	cmp    $0x1,%al
8010313a:	74 08                	je     80103144 <mpinit+0x94>
8010313c:	3c 04                	cmp    $0x4,%al
8010313e:	0f 85 9f 00 00 00    	jne    801031e3 <mpinit+0x133>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103144:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010314b:	85 ff                	test   %edi,%edi
8010314d:	74 1e                	je     8010316d <mpinit+0xbd>
8010314f:	31 d2                	xor    %edx,%edx
80103151:	31 c0                	xor    %eax,%eax
80103153:	90                   	nop
80103154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103158:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010315f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103160:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103163:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103165:	39 c7                	cmp    %eax,%edi
80103167:	75 ef                	jne    80103158 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103169:	84 d2                	test   %dl,%dl
8010316b:	75 76                	jne    801031e3 <mpinit+0x133>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
8010316d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103170:	85 ff                	test   %edi,%edi
80103172:	74 6f                	je     801031e3 <mpinit+0x133>
    return;
  ismp = 1;
80103174:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
8010317b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
8010317e:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103184:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103189:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80103190:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103196:	01 f9                	add    %edi,%ecx
80103198:	39 c8                	cmp    %ecx,%eax
8010319a:	0f 83 a0 00 00 00    	jae    80103240 <mpinit+0x190>
    switch(*p){
801031a0:	80 38 04             	cmpb   $0x4,(%eax)
801031a3:	0f 87 87 00 00 00    	ja     80103230 <mpinit+0x180>
801031a9:	0f b6 10             	movzbl (%eax),%edx
801031ac:	ff 24 95 74 74 10 80 	jmp    *-0x7fef8b8c(,%edx,4)
801031b3:	90                   	nop
801031b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801031b8:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031bb:	39 c1                	cmp    %eax,%ecx
801031bd:	77 e1                	ja     801031a0 <mpinit+0xf0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
801031bf:	a1 84 27 11 80       	mov    0x80112784,%eax
801031c4:	85 c0                	test   %eax,%eax
801031c6:	75 78                	jne    80103240 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
801031c8:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
801031cf:	00 00 00 
    lapic = 0;
801031d2:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
801031d9:	00 00 00 
    ioapicid = 0;
801031dc:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801031e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031e6:	5b                   	pop    %ebx
801031e7:	5e                   	pop    %esi
801031e8:	5f                   	pop    %edi
801031e9:	5d                   	pop    %ebp
801031ea:	c3                   	ret    
801031eb:	90                   	nop
801031ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
801031f0:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
801031f6:	83 fa 07             	cmp    $0x7,%edx
801031f9:	7f 19                	jg     80103214 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031fb:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
801031ff:	69 fa bc 00 00 00    	imul   $0xbc,%edx,%edi
        ncpu++;
80103205:	83 c2 01             	add    $0x1,%edx
80103208:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010320e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
80103214:	83 c0 14             	add    $0x14,%eax
      continue;
80103217:	eb a2                	jmp    801031bb <mpinit+0x10b>
80103219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103220:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103224:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103227:	88 15 80 27 11 80    	mov    %dl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
8010322d:	eb 8c                	jmp    801031bb <mpinit+0x10b>
8010322f:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103230:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
80103237:	00 00 00 
      break;
8010323a:	e9 7c ff ff ff       	jmp    801031bb <mpinit+0x10b>
8010323f:	90                   	nop
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
80103240:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103244:	74 9d                	je     801031e3 <mpinit+0x133>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103246:	ba 22 00 00 00       	mov    $0x22,%edx
8010324b:	b8 70 00 00 00       	mov    $0x70,%eax
80103250:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103251:	ba 23 00 00 00       	mov    $0x23,%edx
80103256:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103257:	83 c8 01             	or     $0x1,%eax
8010325a:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010325b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010325e:	5b                   	pop    %ebx
8010325f:	5e                   	pop    %esi
80103260:	5f                   	pop    %edi
80103261:	5d                   	pop    %ebp
80103262:	c3                   	ret    
80103263:	90                   	nop
80103264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103268:	ba 00 00 01 00       	mov    $0x10000,%edx
8010326d:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103272:	e8 b9 fd ff ff       	call   80103030 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103277:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103279:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010327b:	0f 85 81 fe ff ff    	jne    80103102 <mpinit+0x52>
80103281:	e9 5d ff ff ff       	jmp    801031e3 <mpinit+0x133>
80103286:	66 90                	xchg   %ax,%ax
80103288:	66 90                	xchg   %ax,%ax
8010328a:	66 90                	xchg   %ax,%ax
8010328c:	66 90                	xchg   %ax,%ax
8010328e:	66 90                	xchg   %ax,%ax

80103290 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103290:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103291:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103296:	ba 21 00 00 00       	mov    $0x21,%edx
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
8010329b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010329d:	8b 4d 08             	mov    0x8(%ebp),%ecx
801032a0:	d3 c0                	rol    %cl,%eax
801032a2:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
801032a9:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
801032af:	ee                   	out    %al,(%dx)
801032b0:	ba a1 00 00 00       	mov    $0xa1,%edx
801032b5:	66 c1 e8 08          	shr    $0x8,%ax
801032b9:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
801032ba:	5d                   	pop    %ebp
801032bb:	c3                   	ret    
801032bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032c0 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
801032c0:	55                   	push   %ebp
801032c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032c6:	89 e5                	mov    %esp,%ebp
801032c8:	57                   	push   %edi
801032c9:	56                   	push   %esi
801032ca:	53                   	push   %ebx
801032cb:	bb 21 00 00 00       	mov    $0x21,%ebx
801032d0:	89 da                	mov    %ebx,%edx
801032d2:	ee                   	out    %al,(%dx)
801032d3:	b9 a1 00 00 00       	mov    $0xa1,%ecx
801032d8:	89 ca                	mov    %ecx,%edx
801032da:	ee                   	out    %al,(%dx)
801032db:	bf 11 00 00 00       	mov    $0x11,%edi
801032e0:	be 20 00 00 00       	mov    $0x20,%esi
801032e5:	89 f8                	mov    %edi,%eax
801032e7:	89 f2                	mov    %esi,%edx
801032e9:	ee                   	out    %al,(%dx)
801032ea:	b8 20 00 00 00       	mov    $0x20,%eax
801032ef:	89 da                	mov    %ebx,%edx
801032f1:	ee                   	out    %al,(%dx)
801032f2:	b8 04 00 00 00       	mov    $0x4,%eax
801032f7:	ee                   	out    %al,(%dx)
801032f8:	b8 03 00 00 00       	mov    $0x3,%eax
801032fd:	ee                   	out    %al,(%dx)
801032fe:	bb a0 00 00 00       	mov    $0xa0,%ebx
80103303:	89 f8                	mov    %edi,%eax
80103305:	89 da                	mov    %ebx,%edx
80103307:	ee                   	out    %al,(%dx)
80103308:	b8 28 00 00 00       	mov    $0x28,%eax
8010330d:	89 ca                	mov    %ecx,%edx
8010330f:	ee                   	out    %al,(%dx)
80103310:	b8 02 00 00 00       	mov    $0x2,%eax
80103315:	ee                   	out    %al,(%dx)
80103316:	b8 03 00 00 00       	mov    $0x3,%eax
8010331b:	ee                   	out    %al,(%dx)
8010331c:	bf 68 00 00 00       	mov    $0x68,%edi
80103321:	89 f2                	mov    %esi,%edx
80103323:	89 f8                	mov    %edi,%eax
80103325:	ee                   	out    %al,(%dx)
80103326:	b9 0a 00 00 00       	mov    $0xa,%ecx
8010332b:	89 c8                	mov    %ecx,%eax
8010332d:	ee                   	out    %al,(%dx)
8010332e:	89 f8                	mov    %edi,%eax
80103330:	89 da                	mov    %ebx,%edx
80103332:	ee                   	out    %al,(%dx)
80103333:	89 c8                	mov    %ecx,%eax
80103335:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
80103336:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
8010333d:	66 83 f8 ff          	cmp    $0xffff,%ax
80103341:	74 10                	je     80103353 <picinit+0x93>
80103343:	ba 21 00 00 00       	mov    $0x21,%edx
80103348:	ee                   	out    %al,(%dx)
80103349:	ba a1 00 00 00       	mov    $0xa1,%edx
8010334e:	66 c1 e8 08          	shr    $0x8,%ax
80103352:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
80103353:	5b                   	pop    %ebx
80103354:	5e                   	pop    %esi
80103355:	5f                   	pop    %edi
80103356:	5d                   	pop    %ebp
80103357:	c3                   	ret    
80103358:	66 90                	xchg   %ax,%ax
8010335a:	66 90                	xchg   %ax,%ax
8010335c:	66 90                	xchg   %ax,%ax
8010335e:	66 90                	xchg   %ax,%ax

80103360 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	57                   	push   %edi
80103364:	56                   	push   %esi
80103365:	53                   	push   %ebx
80103366:	83 ec 0c             	sub    $0xc,%esp
80103369:	8b 75 08             	mov    0x8(%ebp),%esi
8010336c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010336f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103375:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010337b:	e8 e0 d9 ff ff       	call   80100d60 <filealloc>
80103380:	85 c0                	test   %eax,%eax
80103382:	89 06                	mov    %eax,(%esi)
80103384:	0f 84 a8 00 00 00    	je     80103432 <pipealloc+0xd2>
8010338a:	e8 d1 d9 ff ff       	call   80100d60 <filealloc>
8010338f:	85 c0                	test   %eax,%eax
80103391:	89 03                	mov    %eax,(%ebx)
80103393:	0f 84 87 00 00 00    	je     80103420 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103399:	e8 e2 f0 ff ff       	call   80102480 <kalloc>
8010339e:	85 c0                	test   %eax,%eax
801033a0:	89 c7                	mov    %eax,%edi
801033a2:	0f 84 b0 00 00 00    	je     80103458 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801033a8:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
801033ab:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801033b2:	00 00 00 
  p->writeopen = 1;
801033b5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033bc:	00 00 00 
  p->nwrite = 0;
801033bf:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033c6:	00 00 00 
  p->nread = 0;
801033c9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033d0:	00 00 00 
  initlock(&p->lock, "pipe");
801033d3:	68 88 74 10 80       	push   $0x80107488
801033d8:	50                   	push   %eax
801033d9:	e8 62 0e 00 00       	call   80104240 <initlock>
  (*f0)->type = FD_PIPE;
801033de:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033e0:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
801033e3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033e9:	8b 06                	mov    (%esi),%eax
801033eb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033ef:	8b 06                	mov    (%esi),%eax
801033f1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033f5:	8b 06                	mov    (%esi),%eax
801033f7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033fa:	8b 03                	mov    (%ebx),%eax
801033fc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103402:	8b 03                	mov    (%ebx),%eax
80103404:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103408:	8b 03                	mov    (%ebx),%eax
8010340a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010340e:	8b 03                	mov    (%ebx),%eax
80103410:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103413:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103416:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103418:	5b                   	pop    %ebx
80103419:	5e                   	pop    %esi
8010341a:	5f                   	pop    %edi
8010341b:	5d                   	pop    %ebp
8010341c:	c3                   	ret    
8010341d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103420:	8b 06                	mov    (%esi),%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	74 1e                	je     80103444 <pipealloc+0xe4>
    fileclose(*f0);
80103426:	83 ec 0c             	sub    $0xc,%esp
80103429:	50                   	push   %eax
8010342a:	e8 f1 d9 ff ff       	call   80100e20 <fileclose>
8010342f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103432:	8b 03                	mov    (%ebx),%eax
80103434:	85 c0                	test   %eax,%eax
80103436:	74 0c                	je     80103444 <pipealloc+0xe4>
    fileclose(*f1);
80103438:	83 ec 0c             	sub    $0xc,%esp
8010343b:	50                   	push   %eax
8010343c:	e8 df d9 ff ff       	call   80100e20 <fileclose>
80103441:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103444:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010344c:	5b                   	pop    %ebx
8010344d:	5e                   	pop    %esi
8010344e:	5f                   	pop    %edi
8010344f:	5d                   	pop    %ebp
80103450:	c3                   	ret    
80103451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103458:	8b 06                	mov    (%esi),%eax
8010345a:	85 c0                	test   %eax,%eax
8010345c:	75 c8                	jne    80103426 <pipealloc+0xc6>
8010345e:	eb d2                	jmp    80103432 <pipealloc+0xd2>

80103460 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103460:	55                   	push   %ebp
80103461:	89 e5                	mov    %esp,%ebp
80103463:	56                   	push   %esi
80103464:	53                   	push   %ebx
80103465:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103468:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010346b:	83 ec 0c             	sub    $0xc,%esp
8010346e:	53                   	push   %ebx
8010346f:	e8 ec 0d 00 00       	call   80104260 <acquire>
  if(writable){
80103474:	83 c4 10             	add    $0x10,%esp
80103477:	85 f6                	test   %esi,%esi
80103479:	74 45                	je     801034c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010347b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103481:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103484:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010348b:	00 00 00 
    wakeup(&p->nread);
8010348e:	50                   	push   %eax
8010348f:	e8 ec 0a 00 00       	call   80103f80 <wakeup>
80103494:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103497:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010349d:	85 d2                	test   %edx,%edx
8010349f:	75 0a                	jne    801034ab <pipeclose+0x4b>
801034a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801034a7:	85 c0                	test   %eax,%eax
801034a9:	74 35                	je     801034e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801034ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801034ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034b1:	5b                   	pop    %ebx
801034b2:	5e                   	pop    %esi
801034b3:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801034b4:	e9 87 0f 00 00       	jmp    80104440 <release>
801034b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
801034c0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801034c6:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801034c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801034d0:	00 00 00 
    wakeup(&p->nwrite);
801034d3:	50                   	push   %eax
801034d4:	e8 a7 0a 00 00       	call   80103f80 <wakeup>
801034d9:	83 c4 10             	add    $0x10,%esp
801034dc:	eb b9                	jmp    80103497 <pipeclose+0x37>
801034de:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801034e0:	83 ec 0c             	sub    $0xc,%esp
801034e3:	53                   	push   %ebx
801034e4:	e8 57 0f 00 00       	call   80104440 <release>
    kfree((char*)p);
801034e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034ec:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
801034ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034f2:	5b                   	pop    %ebx
801034f3:	5e                   	pop    %esi
801034f4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801034f5:	e9 d6 ed ff ff       	jmp    801022d0 <kfree>
801034fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103500 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	57                   	push   %edi
80103504:	56                   	push   %esi
80103505:	53                   	push   %ebx
80103506:	83 ec 28             	sub    $0x28,%esp
80103509:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010350c:	57                   	push   %edi
8010350d:	e8 4e 0d 00 00       	call   80104260 <acquire>
  for(i = 0; i < n; i++){
80103512:	8b 45 10             	mov    0x10(%ebp),%eax
80103515:	83 c4 10             	add    $0x10,%esp
80103518:	85 c0                	test   %eax,%eax
8010351a:	0f 8e c6 00 00 00    	jle    801035e6 <pipewrite+0xe6>
80103520:	8b 45 0c             	mov    0xc(%ebp),%eax
80103523:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103529:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
8010352f:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
80103535:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103538:	03 45 10             	add    0x10(%ebp),%eax
8010353b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010353e:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
80103544:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010354a:	39 d1                	cmp    %edx,%ecx
8010354c:	0f 85 cf 00 00 00    	jne    80103621 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
80103552:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
80103558:	85 d2                	test   %edx,%edx
8010355a:	0f 84 a8 00 00 00    	je     80103608 <pipewrite+0x108>
80103560:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103567:	8b 42 24             	mov    0x24(%edx),%eax
8010356a:	85 c0                	test   %eax,%eax
8010356c:	74 25                	je     80103593 <pipewrite+0x93>
8010356e:	e9 95 00 00 00       	jmp    80103608 <pipewrite+0x108>
80103573:	90                   	nop
80103574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103578:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010357e:	85 c0                	test   %eax,%eax
80103580:	0f 84 82 00 00 00    	je     80103608 <pipewrite+0x108>
80103586:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010358c:	8b 40 24             	mov    0x24(%eax),%eax
8010358f:	85 c0                	test   %eax,%eax
80103591:	75 75                	jne    80103608 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103593:	83 ec 0c             	sub    $0xc,%esp
80103596:	56                   	push   %esi
80103597:	e8 e4 09 00 00       	call   80103f80 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010359c:	59                   	pop    %ecx
8010359d:	58                   	pop    %eax
8010359e:	57                   	push   %edi
8010359f:	53                   	push   %ebx
801035a0:	e8 3b 08 00 00       	call   80103de0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035a5:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035ab:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
801035b1:	83 c4 10             	add    $0x10,%esp
801035b4:	05 00 02 00 00       	add    $0x200,%eax
801035b9:	39 c2                	cmp    %eax,%edx
801035bb:	74 bb                	je     80103578 <pipewrite+0x78>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801035bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801035c0:	8d 4a 01             	lea    0x1(%edx),%ecx
801035c3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801035c7:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801035cd:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
801035d3:	0f b6 00             	movzbl (%eax),%eax
801035d6:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
801035da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801035dd:	3b 45 e0             	cmp    -0x20(%ebp),%eax
801035e0:	0f 85 58 ff ff ff    	jne    8010353e <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801035e6:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
801035ec:	83 ec 0c             	sub    $0xc,%esp
801035ef:	52                   	push   %edx
801035f0:	e8 8b 09 00 00       	call   80103f80 <wakeup>
  release(&p->lock);
801035f5:	89 3c 24             	mov    %edi,(%esp)
801035f8:	e8 43 0e 00 00       	call   80104440 <release>
  return n;
801035fd:	83 c4 10             	add    $0x10,%esp
80103600:	8b 45 10             	mov    0x10(%ebp),%eax
80103603:	eb 14                	jmp    80103619 <pipewrite+0x119>
80103605:	8d 76 00             	lea    0x0(%esi),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
80103608:	83 ec 0c             	sub    $0xc,%esp
8010360b:	57                   	push   %edi
8010360c:	e8 2f 0e 00 00       	call   80104440 <release>
        return -1;
80103611:	83 c4 10             	add    $0x10,%esp
80103614:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103619:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010361c:	5b                   	pop    %ebx
8010361d:	5e                   	pop    %esi
8010361e:	5f                   	pop    %edi
8010361f:	5d                   	pop    %ebp
80103620:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103621:	89 ca                	mov    %ecx,%edx
80103623:	eb 98                	jmp    801035bd <pipewrite+0xbd>
80103625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103630 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	57                   	push   %edi
80103634:	56                   	push   %esi
80103635:	53                   	push   %ebx
80103636:	83 ec 18             	sub    $0x18,%esp
80103639:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010363c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010363f:	53                   	push   %ebx
80103640:	e8 1b 0c 00 00       	call   80104260 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103645:	83 c4 10             	add    $0x10,%esp
80103648:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010364e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80103654:	75 6a                	jne    801036c0 <piperead+0x90>
80103656:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010365c:	85 f6                	test   %esi,%esi
8010365e:	0f 84 cc 00 00 00    	je     80103730 <piperead+0x100>
80103664:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010366a:	eb 2d                	jmp    80103699 <piperead+0x69>
8010366c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103670:	83 ec 08             	sub    $0x8,%esp
80103673:	53                   	push   %ebx
80103674:	56                   	push   %esi
80103675:	e8 66 07 00 00       	call   80103de0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010367a:	83 c4 10             	add    $0x10,%esp
8010367d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103683:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103689:	75 35                	jne    801036c0 <piperead+0x90>
8010368b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103691:	85 d2                	test   %edx,%edx
80103693:	0f 84 97 00 00 00    	je     80103730 <piperead+0x100>
    if(proc->killed){
80103699:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801036a0:	8b 4a 24             	mov    0x24(%edx),%ecx
801036a3:	85 c9                	test   %ecx,%ecx
801036a5:	74 c9                	je     80103670 <piperead+0x40>
      release(&p->lock);
801036a7:	83 ec 0c             	sub    $0xc,%esp
801036aa:	53                   	push   %ebx
801036ab:	e8 90 0d 00 00       	call   80104440 <release>
      return -1;
801036b0:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036b3:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
      return -1;
801036b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801036bb:	5b                   	pop    %ebx
801036bc:	5e                   	pop    %esi
801036bd:	5f                   	pop    %edi
801036be:	5d                   	pop    %ebp
801036bf:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036c0:	8b 45 10             	mov    0x10(%ebp),%eax
801036c3:	85 c0                	test   %eax,%eax
801036c5:	7e 69                	jle    80103730 <piperead+0x100>
    if(p->nread == p->nwrite)
801036c7:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
801036cd:	31 c9                	xor    %ecx,%ecx
801036cf:	eb 15                	jmp    801036e6 <piperead+0xb6>
801036d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d8:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
801036de:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
801036e4:	74 5a                	je     80103740 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801036e6:	8d 72 01             	lea    0x1(%edx),%esi
801036e9:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801036ef:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
801036f5:	0f b6 54 13 34       	movzbl 0x34(%ebx,%edx,1),%edx
801036fa:	88 14 0f             	mov    %dl,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036fd:	83 c1 01             	add    $0x1,%ecx
80103700:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103703:	75 d3                	jne    801036d8 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103705:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
8010370b:	83 ec 0c             	sub    $0xc,%esp
8010370e:	52                   	push   %edx
8010370f:	e8 6c 08 00 00       	call   80103f80 <wakeup>
  release(&p->lock);
80103714:	89 1c 24             	mov    %ebx,(%esp)
80103717:	e8 24 0d 00 00       	call   80104440 <release>
  return i;
8010371c:	8b 45 10             	mov    0x10(%ebp),%eax
8010371f:	83 c4 10             	add    $0x10,%esp
}
80103722:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103725:	5b                   	pop    %ebx
80103726:	5e                   	pop    %esi
80103727:	5f                   	pop    %edi
80103728:	5d                   	pop    %ebp
80103729:	c3                   	ret    
8010372a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103730:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80103737:	eb cc                	jmp    80103705 <piperead+0xd5>
80103739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103740:	89 4d 10             	mov    %ecx,0x10(%ebp)
80103743:	eb c0                	jmp    80103705 <piperead+0xd5>
80103745:	66 90                	xchg   %ax,%ax
80103747:	66 90                	xchg   %ax,%ax
80103749:	66 90                	xchg   %ax,%ax
8010374b:	66 90                	xchg   %ax,%ax
8010374d:	66 90                	xchg   %ax,%ax
8010374f:	90                   	nop

80103750 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103754:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103759:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010375c:	68 a0 2d 11 80       	push   $0x80112da0
80103761:	e8 fa 0a 00 00       	call   80104260 <acquire>
80103766:	83 c4 10             	add    $0x10,%esp
80103769:	eb 10                	jmp    8010377b <allocproc+0x2b>
8010376b:	90                   	nop
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103770:	83 c3 7c             	add    $0x7c,%ebx
80103773:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103779:	74 75                	je     801037f0 <allocproc+0xa0>
    if(p->state == UNUSED)
8010377b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010377e:	85 c0                	test   %eax,%eax
80103780:	75 ee                	jne    80103770 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103782:	a1 08 a0 10 80       	mov    0x8010a008,%eax

  release(&ptable.lock);
80103787:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010378a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103791:	68 a0 2d 11 80       	push   $0x80112da0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103796:	8d 50 01             	lea    0x1(%eax),%edx
80103799:	89 43 10             	mov    %eax,0x10(%ebx)
8010379c:	89 15 08 a0 10 80    	mov    %edx,0x8010a008

  release(&ptable.lock);
801037a2:	e8 99 0c 00 00       	call   80104440 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037a7:	e8 d4 ec ff ff       	call   80102480 <kalloc>
801037ac:	83 c4 10             	add    $0x10,%esp
801037af:	85 c0                	test   %eax,%eax
801037b1:	89 43 08             	mov    %eax,0x8(%ebx)
801037b4:	74 51                	je     80103807 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037b6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037bc:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
801037bf:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037c4:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801037c7:	c7 40 14 ce 56 10 80 	movl   $0x801056ce,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037ce:	6a 14                	push   $0x14
801037d0:	6a 00                	push   $0x0
801037d2:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
801037d3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801037d6:	e8 b5 0c 00 00       	call   80104490 <memset>
  p->context->eip = (uint)forkret;
801037db:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801037de:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
801037e1:	c7 40 10 10 38 10 80 	movl   $0x80103810,0x10(%eax)

  return p;
801037e8:	89 d8                	mov    %ebx,%eax
}
801037ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037ed:	c9                   	leave  
801037ee:	c3                   	ret    
801037ef:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801037f0:	83 ec 0c             	sub    $0xc,%esp
801037f3:	68 a0 2d 11 80       	push   $0x80112da0
801037f8:	e8 43 0c 00 00       	call   80104440 <release>
  return 0;
801037fd:	83 c4 10             	add    $0x10,%esp
80103800:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103802:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103805:	c9                   	leave  
80103806:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103807:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010380e:	eb da                	jmp    801037ea <allocproc+0x9a>

80103810 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103816:	68 a0 2d 11 80       	push   $0x80112da0
8010381b:	e8 20 0c 00 00       	call   80104440 <release>

  if (first) {
80103820:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103825:	83 c4 10             	add    $0x10,%esp
80103828:	85 c0                	test   %eax,%eax
8010382a:	75 04                	jne    80103830 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010382c:	c9                   	leave  
8010382d:	c3                   	ret    
8010382e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103830:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103833:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
8010383a:	00 00 00 
    iinit(ROOTDEV);
8010383d:	6a 01                	push   $0x1
8010383f:	e8 1c dc ff ff       	call   80101460 <iinit>
    initlog(ROOTDEV);
80103844:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010384b:	e8 d0 f2 ff ff       	call   80102b20 <initlog>
80103850:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103853:	c9                   	leave  
80103854:	c3                   	ret    
80103855:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103860 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103866:	68 8d 74 10 80       	push   $0x8010748d
8010386b:	68 a0 2d 11 80       	push   $0x80112da0
80103870:	e8 cb 09 00 00       	call   80104240 <initlock>
}
80103875:	83 c4 10             	add    $0x10,%esp
80103878:	c9                   	leave  
80103879:	c3                   	ret    
8010387a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103880 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	53                   	push   %ebx
80103884:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103887:	e8 c4 fe ff ff       	call   80103750 <allocproc>
8010388c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010388e:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103893:	e8 68 30 00 00       	call   80106900 <setupkvm>
80103898:	85 c0                	test   %eax,%eax
8010389a:	89 43 04             	mov    %eax,0x4(%ebx)
8010389d:	0f 84 bd 00 00 00    	je     80103960 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038a3:	83 ec 04             	sub    $0x4,%esp
801038a6:	68 2c 00 00 00       	push   $0x2c
801038ab:	68 60 a4 10 80       	push   $0x8010a460
801038b0:	50                   	push   %eax
801038b1:	e8 9a 31 00 00       	call   80106a50 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801038b6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801038b9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801038bf:	6a 4c                	push   $0x4c
801038c1:	6a 00                	push   $0x0
801038c3:	ff 73 18             	pushl  0x18(%ebx)
801038c6:	e8 c5 0b 00 00       	call   80104490 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038cb:	8b 43 18             	mov    0x18(%ebx),%eax
801038ce:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038d3:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038d8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038db:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038df:	8b 43 18             	mov    0x18(%ebx),%eax
801038e2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801038e6:	8b 43 18             	mov    0x18(%ebx),%eax
801038e9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038ed:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038f1:	8b 43 18             	mov    0x18(%ebx),%eax
801038f4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038f8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038fc:	8b 43 18             	mov    0x18(%ebx),%eax
801038ff:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103906:	8b 43 18             	mov    0x18(%ebx),%eax
80103909:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103910:	8b 43 18             	mov    0x18(%ebx),%eax
80103913:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010391a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010391d:	6a 10                	push   $0x10
8010391f:	68 ad 74 10 80       	push   $0x801074ad
80103924:	50                   	push   %eax
80103925:	e8 66 0d 00 00       	call   80104690 <safestrcpy>
  p->cwd = namei("/");
8010392a:	c7 04 24 b6 74 10 80 	movl   $0x801074b6,(%esp)
80103931:	e8 5a e5 ff ff       	call   80101e90 <namei>
80103936:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80103939:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103940:	e8 1b 09 00 00       	call   80104260 <acquire>

  p->state = RUNNABLE;
80103945:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
8010394c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103953:	e8 e8 0a 00 00       	call   80104440 <release>
}
80103958:	83 c4 10             	add    $0x10,%esp
8010395b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010395e:	c9                   	leave  
8010395f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103960:	83 ec 0c             	sub    $0xc,%esp
80103963:	68 94 74 10 80       	push   $0x80107494
80103968:	e8 03 ca ff ff       	call   80100370 <panic>
8010396d:	8d 76 00             	lea    0x0(%esi),%esi

80103970 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	83 ec 08             	sub    $0x8,%esp
  uint sz;

  sz = proc->sz;
80103976:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
8010397d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz;

  sz = proc->sz;
80103980:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103982:	83 f9 00             	cmp    $0x0,%ecx
80103985:	7e 39                	jle    801039c0 <growproc+0x50>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103987:	83 ec 04             	sub    $0x4,%esp
8010398a:	01 c1                	add    %eax,%ecx
8010398c:	51                   	push   %ecx
8010398d:	50                   	push   %eax
8010398e:	ff 72 04             	pushl  0x4(%edx)
80103991:	e8 fa 31 00 00       	call   80106b90 <allocuvm>
80103996:	83 c4 10             	add    $0x10,%esp
80103999:	85 c0                	test   %eax,%eax
8010399b:	74 3b                	je     801039d8 <growproc+0x68>
8010399d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
801039a4:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
801039a6:	83 ec 0c             	sub    $0xc,%esp
801039a9:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
801039b0:	e8 fb 2f 00 00       	call   801069b0 <switchuvm>
  return 0;
801039b5:	83 c4 10             	add    $0x10,%esp
801039b8:	31 c0                	xor    %eax,%eax
}
801039ba:	c9                   	leave  
801039bb:	c3                   	ret    
801039bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
801039c0:	74 e2                	je     801039a4 <growproc+0x34>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801039c2:	83 ec 04             	sub    $0x4,%esp
801039c5:	01 c1                	add    %eax,%ecx
801039c7:	51                   	push   %ecx
801039c8:	50                   	push   %eax
801039c9:	ff 72 04             	pushl  0x4(%edx)
801039cc:	e8 bf 32 00 00       	call   80106c90 <deallocuvm>
801039d1:	83 c4 10             	add    $0x10,%esp
801039d4:	85 c0                	test   %eax,%eax
801039d6:	75 c5                	jne    8010399d <growproc+0x2d>
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
801039d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}
801039dd:	c9                   	leave  
801039de:	c3                   	ret    
801039df:	90                   	nop

801039e0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	57                   	push   %edi
801039e4:	56                   	push   %esi
801039e5:	53                   	push   %ebx
801039e6:	83 ec 0c             	sub    $0xc,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
801039e9:	e8 62 fd ff ff       	call   80103750 <allocproc>
801039ee:	85 c0                	test   %eax,%eax
801039f0:	0f 84 d6 00 00 00    	je     80103acc <fork+0xec>
801039f6:	89 c3                	mov    %eax,%ebx
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801039f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801039fe:	83 ec 08             	sub    $0x8,%esp
80103a01:	ff 30                	pushl  (%eax)
80103a03:	ff 70 04             	pushl  0x4(%eax)
80103a06:	e8 65 33 00 00       	call   80106d70 <copyuvm>
80103a0b:	83 c4 10             	add    $0x10,%esp
80103a0e:	85 c0                	test   %eax,%eax
80103a10:	89 43 04             	mov    %eax,0x4(%ebx)
80103a13:	0f 84 ba 00 00 00    	je     80103ad3 <fork+0xf3>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
80103a19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
80103a1f:	8b 7b 18             	mov    0x18(%ebx),%edi
80103a22:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
80103a27:	8b 00                	mov    (%eax),%eax
80103a29:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103a2b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a31:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103a34:	8b 70 18             	mov    0x18(%eax),%esi
80103a37:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a39:	31 f6                	xor    %esi,%esi
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103a3b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a3e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a45:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
80103a50:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103a54:	85 c0                	test   %eax,%eax
80103a56:	74 17                	je     80103a6f <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103a58:	83 ec 0c             	sub    $0xc,%esp
80103a5b:	50                   	push   %eax
80103a5c:	e8 6f d3 ff ff       	call   80100dd0 <filedup>
80103a61:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103a65:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a6c:	83 c4 10             	add    $0x10,%esp
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a6f:	83 c6 01             	add    $0x1,%esi
80103a72:	83 fe 10             	cmp    $0x10,%esi
80103a75:	75 d9                	jne    80103a50 <fork+0x70>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80103a77:	83 ec 0c             	sub    $0xc,%esp
80103a7a:	ff 72 68             	pushl  0x68(%edx)
80103a7d:	e8 ae db ff ff       	call   80101630 <idup>
80103a82:	89 43 68             	mov    %eax,0x68(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103a85:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a8b:	83 c4 0c             	add    $0xc,%esp
80103a8e:	6a 10                	push   $0x10
80103a90:	83 c0 6c             	add    $0x6c,%eax
80103a93:	50                   	push   %eax
80103a94:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a97:	50                   	push   %eax
80103a98:	e8 f3 0b 00 00       	call   80104690 <safestrcpy>

  pid = np->pid;
80103a9d:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
80103aa0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103aa7:	e8 b4 07 00 00       	call   80104260 <acquire>

  np->state = RUNNABLE;
80103aac:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103ab3:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103aba:	e8 81 09 00 00       	call   80104440 <release>

  return pid;
80103abf:	83 c4 10             	add    $0x10,%esp
80103ac2:	89 f0                	mov    %esi,%eax
}
80103ac4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ac7:	5b                   	pop    %ebx
80103ac8:	5e                   	pop    %esi
80103ac9:	5f                   	pop    %edi
80103aca:	5d                   	pop    %ebp
80103acb:	c3                   	ret    
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103acc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ad1:	eb f1                	jmp    80103ac4 <fork+0xe4>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
80103ad3:	83 ec 0c             	sub    $0xc,%esp
80103ad6:	ff 73 08             	pushl  0x8(%ebx)
80103ad9:	e8 f2 e7 ff ff       	call   801022d0 <kfree>
    np->kstack = 0;
80103ade:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103ae5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103aec:	83 c4 10             	add    $0x10,%esp
80103aef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103af4:	eb ce                	jmp    80103ac4 <fork+0xe4>
80103af6:	8d 76 00             	lea    0x0(%esi),%esi
80103af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b00 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103b00:	55                   	push   %ebp
80103b01:	89 e5                	mov    %esp,%ebp
80103b03:	53                   	push   %ebx
80103b04:	83 ec 04             	sub    $0x4,%esp
80103b07:	89 f6                	mov    %esi,%esi
80103b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b10:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b11:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b14:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b19:	68 a0 2d 11 80       	push   $0x80112da0
80103b1e:	e8 3d 07 00 00       	call   80104260 <acquire>
80103b23:	83 c4 10             	add    $0x10,%esp
80103b26:	eb 13                	jmp    80103b3b <scheduler+0x3b>
80103b28:	90                   	nop
80103b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b30:	83 c3 7c             	add    $0x7c,%ebx
80103b33:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103b39:	74 55                	je     80103b90 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103b3b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b3f:	75 ef                	jne    80103b30 <scheduler+0x30>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103b41:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80103b44:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103b4b:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b4c:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103b4f:	e8 5c 2e 00 00       	call   801069b0 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, p->context);
80103b54:	58                   	pop    %eax
80103b55:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103b5b:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)
      swtch(&cpu->scheduler, p->context);
80103b62:	5a                   	pop    %edx
80103b63:	ff 73 a0             	pushl  -0x60(%ebx)
80103b66:	83 c0 04             	add    $0x4,%eax
80103b69:	50                   	push   %eax
80103b6a:	e8 7c 0b 00 00       	call   801046eb <swtch>
      switchkvm();
80103b6f:	e8 1c 2e 00 00       	call   80106990 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103b74:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b77:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
      swtch(&cpu->scheduler, p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103b7d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103b84:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b88:	75 b1                	jne    80103b3b <scheduler+0x3b>
80103b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80103b90:	83 ec 0c             	sub    $0xc,%esp
80103b93:	68 a0 2d 11 80       	push   $0x80112da0
80103b98:	e8 a3 08 00 00       	call   80104440 <release>

  }
80103b9d:	83 c4 10             	add    $0x10,%esp
80103ba0:	e9 6b ff ff ff       	jmp    80103b10 <scheduler+0x10>
80103ba5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bb0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	53                   	push   %ebx
80103bb4:	83 ec 10             	sub    $0x10,%esp
  int intena;

  if(!holding(&ptable.lock))
80103bb7:	68 a0 2d 11 80       	push   $0x80112da0
80103bbc:	e8 cf 07 00 00       	call   80104390 <holding>
80103bc1:	83 c4 10             	add    $0x10,%esp
80103bc4:	85 c0                	test   %eax,%eax
80103bc6:	74 4c                	je     80103c14 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103bc8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103bcf:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103bd6:	75 63                	jne    80103c3b <sched+0x8b>
    panic("sched locks");
  if(proc->state == RUNNING)
80103bd8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103bde:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103be2:	74 4a                	je     80103c2e <sched+0x7e>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103be4:	9c                   	pushf  
80103be5:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
80103be6:	80 e5 02             	and    $0x2,%ch
80103be9:	75 36                	jne    80103c21 <sched+0x71>
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
80103beb:	83 ec 08             	sub    $0x8,%esp
80103bee:	83 c0 1c             	add    $0x1c,%eax
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
80103bf1:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103bf7:	ff 72 04             	pushl  0x4(%edx)
80103bfa:	50                   	push   %eax
80103bfb:	e8 eb 0a 00 00       	call   801046eb <swtch>
  cpu->intena = intena;
80103c00:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103c06:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
80103c09:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103c0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c12:	c9                   	leave  
80103c13:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103c14:	83 ec 0c             	sub    $0xc,%esp
80103c17:	68 b8 74 10 80       	push   $0x801074b8
80103c1c:	e8 4f c7 ff ff       	call   80100370 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103c21:	83 ec 0c             	sub    $0xc,%esp
80103c24:	68 e4 74 10 80       	push   $0x801074e4
80103c29:	e8 42 c7 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
80103c2e:	83 ec 0c             	sub    $0xc,%esp
80103c31:	68 d6 74 10 80       	push   $0x801074d6
80103c36:	e8 35 c7 ff ff       	call   80100370 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
80103c3b:	83 ec 0c             	sub    $0xc,%esp
80103c3e:	68 ca 74 10 80       	push   $0x801074ca
80103c43:	e8 28 c7 ff ff       	call   80100370 <panic>
80103c48:	90                   	nop
80103c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c50 <exit>:
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
80103c50:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c57:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c5d:	55                   	push   %ebp
80103c5e:	89 e5                	mov    %esp,%ebp
80103c60:	56                   	push   %esi
80103c61:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
80103c62:	0f 84 1f 01 00 00    	je     80103d87 <exit+0x137>
80103c68:	31 db                	xor    %ebx,%ebx
80103c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103c70:	8d 73 08             	lea    0x8(%ebx),%esi
80103c73:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103c77:	85 c0                	test   %eax,%eax
80103c79:	74 1b                	je     80103c96 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103c7b:	83 ec 0c             	sub    $0xc,%esp
80103c7e:	50                   	push   %eax
80103c7f:	e8 9c d1 ff ff       	call   80100e20 <fileclose>
      proc->ofile[fd] = 0;
80103c84:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c8b:	83 c4 10             	add    $0x10,%esp
80103c8e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103c95:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103c96:	83 c3 01             	add    $0x1,%ebx
80103c99:	83 fb 10             	cmp    $0x10,%ebx
80103c9c:	75 d2                	jne    80103c70 <exit+0x20>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c9e:	e8 1d ef ff ff       	call   80102bc0 <begin_op>
  iput(proc->cwd);
80103ca3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ca9:	83 ec 0c             	sub    $0xc,%esp
80103cac:	ff 70 68             	pushl  0x68(%eax)
80103caf:	e8 dc da ff ff       	call   80101790 <iput>
  end_op();
80103cb4:	e8 77 ef ff ff       	call   80102c30 <end_op>
  proc->cwd = 0;
80103cb9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103cbf:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103cc6:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103ccd:	e8 8e 05 00 00       	call   80104260 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103cd2:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103cd9:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cdc:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103ce1:	8b 51 14             	mov    0x14(%ecx),%edx
80103ce4:	eb 14                	jmp    80103cfa <exit+0xaa>
80103ce6:	8d 76 00             	lea    0x0(%esi),%esi
80103ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cf0:	83 c0 7c             	add    $0x7c,%eax
80103cf3:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103cf8:	74 1c                	je     80103d16 <exit+0xc6>
    if(p->state == SLEEPING && p->chan == chan)
80103cfa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cfe:	75 f0                	jne    80103cf0 <exit+0xa0>
80103d00:	3b 50 20             	cmp    0x20(%eax),%edx
80103d03:	75 eb                	jne    80103cf0 <exit+0xa0>
      p->state = RUNNABLE;
80103d05:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d0c:	83 c0 7c             	add    $0x7c,%eax
80103d0f:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103d14:	75 e4                	jne    80103cfa <exit+0xaa>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103d16:	8b 1d bc a5 10 80    	mov    0x8010a5bc,%ebx
80103d1c:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103d21:	eb 10                	jmp    80103d33 <exit+0xe3>
80103d23:	90                   	nop
80103d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d28:	83 c2 7c             	add    $0x7c,%edx
80103d2b:	81 fa d4 4c 11 80    	cmp    $0x80114cd4,%edx
80103d31:	74 3b                	je     80103d6e <exit+0x11e>
    if(p->parent == proc){
80103d33:	3b 4a 14             	cmp    0x14(%edx),%ecx
80103d36:	75 f0                	jne    80103d28 <exit+0xd8>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103d38:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103d3c:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d3f:	75 e7                	jne    80103d28 <exit+0xd8>
80103d41:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103d46:	eb 12                	jmp    80103d5a <exit+0x10a>
80103d48:	90                   	nop
80103d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d50:	83 c0 7c             	add    $0x7c,%eax
80103d53:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103d58:	74 ce                	je     80103d28 <exit+0xd8>
    if(p->state == SLEEPING && p->chan == chan)
80103d5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d5e:	75 f0                	jne    80103d50 <exit+0x100>
80103d60:	3b 58 20             	cmp    0x20(%eax),%ebx
80103d63:	75 eb                	jne    80103d50 <exit+0x100>
      p->state = RUNNABLE;
80103d65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d6c:	eb e2                	jmp    80103d50 <exit+0x100>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80103d6e:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
80103d75:	e8 36 fe ff ff       	call   80103bb0 <sched>
  panic("zombie exit");
80103d7a:	83 ec 0c             	sub    $0xc,%esp
80103d7d:	68 05 75 10 80       	push   $0x80107505
80103d82:	e8 e9 c5 ff ff       	call   80100370 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103d87:	83 ec 0c             	sub    $0xc,%esp
80103d8a:	68 f8 74 10 80       	push   $0x801074f8
80103d8f:	e8 dc c5 ff ff       	call   80100370 <panic>
80103d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103da0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103da6:	68 a0 2d 11 80       	push   $0x80112da0
80103dab:	e8 b0 04 00 00       	call   80104260 <acquire>
  proc->state = RUNNABLE;
80103db0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103db6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103dbd:	e8 ee fd ff ff       	call   80103bb0 <sched>
  release(&ptable.lock);
80103dc2:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103dc9:	e8 72 06 00 00       	call   80104440 <release>
}
80103dce:	83 c4 10             	add    $0x10,%esp
80103dd1:	c9                   	leave  
80103dd2:	c3                   	ret    
80103dd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103de0 <sleep>:
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
80103de0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103de6:	55                   	push   %ebp
80103de7:	89 e5                	mov    %esp,%ebp
80103de9:	56                   	push   %esi
80103dea:	53                   	push   %ebx
  if(proc == 0)
80103deb:	85 c0                	test   %eax,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103ded:	8b 75 08             	mov    0x8(%ebp),%esi
80103df0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103df3:	0f 84 97 00 00 00    	je     80103e90 <sleep+0xb0>
    panic("sleep");

  if(lk == 0)
80103df9:	85 db                	test   %ebx,%ebx
80103dfb:	0f 84 82 00 00 00    	je     80103e83 <sleep+0xa3>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e01:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103e07:	74 57                	je     80103e60 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e09:	83 ec 0c             	sub    $0xc,%esp
80103e0c:	68 a0 2d 11 80       	push   $0x80112da0
80103e11:	e8 4a 04 00 00       	call   80104260 <acquire>
    release(lk);
80103e16:	89 1c 24             	mov    %ebx,(%esp)
80103e19:	e8 22 06 00 00       	call   80104440 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80103e1e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e24:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103e27:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103e2e:	e8 7d fd ff ff       	call   80103bb0 <sched>

  // Tidy up.
  proc->chan = 0;
80103e33:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e39:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103e40:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e47:	e8 f4 05 00 00       	call   80104440 <release>
    acquire(lk);
80103e4c:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103e4f:	83 c4 10             	add    $0x10,%esp
  }
}
80103e52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e55:	5b                   	pop    %ebx
80103e56:	5e                   	pop    %esi
80103e57:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103e58:	e9 03 04 00 00       	jmp    80104260 <acquire>
80103e5d:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
80103e60:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103e63:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103e6a:	e8 41 fd ff ff       	call   80103bb0 <sched>

  // Tidy up.
  proc->chan = 0;
80103e6f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e75:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103e7c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e7f:	5b                   	pop    %ebx
80103e80:	5e                   	pop    %esi
80103e81:	5d                   	pop    %ebp
80103e82:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103e83:	83 ec 0c             	sub    $0xc,%esp
80103e86:	68 17 75 10 80       	push   $0x80107517
80103e8b:	e8 e0 c4 ff ff       	call   80100370 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
80103e90:	83 ec 0c             	sub    $0xc,%esp
80103e93:	68 11 75 10 80       	push   $0x80107511
80103e98:	e8 d3 c4 ff ff       	call   80100370 <panic>
80103e9d:	8d 76 00             	lea    0x0(%esi),%esi

80103ea0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	56                   	push   %esi
80103ea4:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103ea5:	83 ec 0c             	sub    $0xc,%esp
80103ea8:	68 a0 2d 11 80       	push   $0x80112da0
80103ead:	e8 ae 03 00 00       	call   80104260 <acquire>
80103eb2:	83 c4 10             	add    $0x10,%esp
80103eb5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103ebb:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ebd:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103ec2:	eb 0f                	jmp    80103ed3 <wait+0x33>
80103ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ec8:	83 c3 7c             	add    $0x7c,%ebx
80103ecb:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103ed1:	74 1d                	je     80103ef0 <wait+0x50>
      if(p->parent != proc)
80103ed3:	3b 43 14             	cmp    0x14(%ebx),%eax
80103ed6:	75 f0                	jne    80103ec8 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103ed8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103edc:	74 30                	je     80103f0e <wait+0x6e>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ede:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != proc)
        continue;
      havekids = 1;
80103ee1:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ee6:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103eec:	75 e5                	jne    80103ed3 <wait+0x33>
80103eee:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103ef0:	85 d2                	test   %edx,%edx
80103ef2:	74 70                	je     80103f64 <wait+0xc4>
80103ef4:	8b 50 24             	mov    0x24(%eax),%edx
80103ef7:	85 d2                	test   %edx,%edx
80103ef9:	75 69                	jne    80103f64 <wait+0xc4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103efb:	83 ec 08             	sub    $0x8,%esp
80103efe:	68 a0 2d 11 80       	push   $0x80112da0
80103f03:	50                   	push   %eax
80103f04:	e8 d7 fe ff ff       	call   80103de0 <sleep>
  }
80103f09:	83 c4 10             	add    $0x10,%esp
80103f0c:	eb a7                	jmp    80103eb5 <wait+0x15>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103f0e:	83 ec 0c             	sub    $0xc,%esp
80103f11:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103f14:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f17:	e8 b4 e3 ff ff       	call   801022d0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103f1c:	59                   	pop    %ecx
80103f1d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103f20:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f27:	e8 94 2d 00 00       	call   80106cc0 <freevm>
        p->pid = 0;
80103f2c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f33:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f3a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f3e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f45:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f4c:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103f53:	e8 e8 04 00 00       	call   80104440 <release>
        return pid;
80103f58:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f5b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103f5e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f60:	5b                   	pop    %ebx
80103f61:	5e                   	pop    %esi
80103f62:	5d                   	pop    %ebp
80103f63:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103f64:	83 ec 0c             	sub    $0xc,%esp
80103f67:	68 a0 2d 11 80       	push   $0x80112da0
80103f6c:	e8 cf 04 00 00       	call   80104440 <release>
      return -1;
80103f71:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f74:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
80103f77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f7c:	5b                   	pop    %ebx
80103f7d:	5e                   	pop    %esi
80103f7e:	5d                   	pop    %ebp
80103f7f:	c3                   	ret    

80103f80 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	53                   	push   %ebx
80103f84:	83 ec 10             	sub    $0x10,%esp
80103f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f8a:	68 a0 2d 11 80       	push   $0x80112da0
80103f8f:	e8 cc 02 00 00       	call   80104260 <acquire>
80103f94:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f97:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103f9c:	eb 0c                	jmp    80103faa <wakeup+0x2a>
80103f9e:	66 90                	xchg   %ax,%ax
80103fa0:	83 c0 7c             	add    $0x7c,%eax
80103fa3:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103fa8:	74 1c                	je     80103fc6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80103faa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fae:	75 f0                	jne    80103fa0 <wakeup+0x20>
80103fb0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103fb3:	75 eb                	jne    80103fa0 <wakeup+0x20>
      p->state = RUNNABLE;
80103fb5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fbc:	83 c0 7c             	add    $0x7c,%eax
80103fbf:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103fc4:	75 e4                	jne    80103faa <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103fc6:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
80103fcd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fd0:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103fd1:	e9 6a 04 00 00       	jmp    80104440 <release>
80103fd6:	8d 76 00             	lea    0x0(%esi),%esi
80103fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fe0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	53                   	push   %ebx
80103fe4:	83 ec 10             	sub    $0x10,%esp
80103fe7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103fea:	68 a0 2d 11 80       	push   $0x80112da0
80103fef:	e8 6c 02 00 00       	call   80104260 <acquire>
80103ff4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ff7:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103ffc:	eb 0c                	jmp    8010400a <kill+0x2a>
80103ffe:	66 90                	xchg   %ax,%ax
80104000:	83 c0 7c             	add    $0x7c,%eax
80104003:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80104008:	74 3e                	je     80104048 <kill+0x68>
    if(p->pid == pid){
8010400a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010400d:	75 f1                	jne    80104000 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010400f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104013:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010401a:	74 1c                	je     80104038 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010401c:	83 ec 0c             	sub    $0xc,%esp
8010401f:	68 a0 2d 11 80       	push   $0x80112da0
80104024:	e8 17 04 00 00       	call   80104440 <release>
      return 0;
80104029:	83 c4 10             	add    $0x10,%esp
8010402c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010402e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104031:	c9                   	leave  
80104032:	c3                   	ret    
80104033:	90                   	nop
80104034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104038:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010403f:	eb db                	jmp    8010401c <kill+0x3c>
80104041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104048:	83 ec 0c             	sub    $0xc,%esp
8010404b:	68 a0 2d 11 80       	push   $0x80112da0
80104050:	e8 eb 03 00 00       	call   80104440 <release>
  return -1;
80104055:	83 c4 10             	add    $0x10,%esp
80104058:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010405d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104060:	c9                   	leave  
80104061:	c3                   	ret    
80104062:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104070 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	57                   	push   %edi
80104074:	56                   	push   %esi
80104075:	53                   	push   %ebx
80104076:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104079:	bb 40 2e 11 80       	mov    $0x80112e40,%ebx
8010407e:	83 ec 3c             	sub    $0x3c,%esp
80104081:	eb 24                	jmp    801040a7 <procdump+0x37>
80104083:	90                   	nop
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104088:	83 ec 0c             	sub    $0xc,%esp
8010408b:	68 66 74 10 80       	push   $0x80107466
80104090:	e8 cb c5 ff ff       	call   80100660 <cprintf>
80104095:	83 c4 10             	add    $0x10,%esp
80104098:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010409b:	81 fb 40 4d 11 80    	cmp    $0x80114d40,%ebx
801040a1:	0f 84 81 00 00 00    	je     80104128 <procdump+0xb8>
    if(p->state == UNUSED)
801040a7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801040aa:	85 c0                	test   %eax,%eax
801040ac:	74 ea                	je     80104098 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040ae:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801040b1:	ba 28 75 10 80       	mov    $0x80107528,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801040b6:	77 11                	ja     801040c9 <procdump+0x59>
801040b8:	8b 14 85 60 75 10 80 	mov    -0x7fef8aa0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801040bf:	b8 28 75 10 80       	mov    $0x80107528,%eax
801040c4:	85 d2                	test   %edx,%edx
801040c6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801040c9:	53                   	push   %ebx
801040ca:	52                   	push   %edx
801040cb:	ff 73 a4             	pushl  -0x5c(%ebx)
801040ce:	68 2c 75 10 80       	push   $0x8010752c
801040d3:	e8 88 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801040d8:	83 c4 10             	add    $0x10,%esp
801040db:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801040df:	75 a7                	jne    80104088 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801040e1:	8d 45 c0             	lea    -0x40(%ebp),%eax
801040e4:	83 ec 08             	sub    $0x8,%esp
801040e7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801040ea:	50                   	push   %eax
801040eb:	8b 43 b0             	mov    -0x50(%ebx),%eax
801040ee:	8b 40 0c             	mov    0xc(%eax),%eax
801040f1:	83 c0 08             	add    $0x8,%eax
801040f4:	50                   	push   %eax
801040f5:	e8 36 02 00 00       	call   80104330 <getcallerpcs>
801040fa:	83 c4 10             	add    $0x10,%esp
801040fd:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104100:	8b 17                	mov    (%edi),%edx
80104102:	85 d2                	test   %edx,%edx
80104104:	74 82                	je     80104088 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104106:	83 ec 08             	sub    $0x8,%esp
80104109:	83 c7 04             	add    $0x4,%edi
8010410c:	52                   	push   %edx
8010410d:	68 89 6f 10 80       	push   $0x80106f89
80104112:	e8 49 c5 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104117:	83 c4 10             	add    $0x10,%esp
8010411a:	39 f7                	cmp    %esi,%edi
8010411c:	75 e2                	jne    80104100 <procdump+0x90>
8010411e:	e9 65 ff ff ff       	jmp    80104088 <procdump+0x18>
80104123:	90                   	nop
80104124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104128:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010412b:	5b                   	pop    %ebx
8010412c:	5e                   	pop    %esi
8010412d:	5f                   	pop    %edi
8010412e:	5d                   	pop    %ebp
8010412f:	c3                   	ret    

80104130 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	53                   	push   %ebx
80104134:	83 ec 0c             	sub    $0xc,%esp
80104137:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010413a:	68 78 75 10 80       	push   $0x80107578
8010413f:	8d 43 04             	lea    0x4(%ebx),%eax
80104142:	50                   	push   %eax
80104143:	e8 f8 00 00 00       	call   80104240 <initlock>
  lk->name = name;
80104148:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010414b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104151:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104154:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010415b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
8010415e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104161:	c9                   	leave  
80104162:	c3                   	ret    
80104163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104170 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	56                   	push   %esi
80104174:	53                   	push   %ebx
80104175:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104178:	83 ec 0c             	sub    $0xc,%esp
8010417b:	8d 73 04             	lea    0x4(%ebx),%esi
8010417e:	56                   	push   %esi
8010417f:	e8 dc 00 00 00       	call   80104260 <acquire>
  while (lk->locked) {
80104184:	8b 13                	mov    (%ebx),%edx
80104186:	83 c4 10             	add    $0x10,%esp
80104189:	85 d2                	test   %edx,%edx
8010418b:	74 16                	je     801041a3 <acquiresleep+0x33>
8010418d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104190:	83 ec 08             	sub    $0x8,%esp
80104193:	56                   	push   %esi
80104194:	53                   	push   %ebx
80104195:	e8 46 fc ff ff       	call   80103de0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010419a:	8b 03                	mov    (%ebx),%eax
8010419c:	83 c4 10             	add    $0x10,%esp
8010419f:	85 c0                	test   %eax,%eax
801041a1:	75 ed                	jne    80104190 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
801041a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
801041a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801041af:	8b 40 10             	mov    0x10(%eax),%eax
801041b2:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801041b5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801041b8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041bb:	5b                   	pop    %ebx
801041bc:	5e                   	pop    %esi
801041bd:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = proc->pid;
  release(&lk->lk);
801041be:	e9 7d 02 00 00       	jmp    80104440 <release>
801041c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041d0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	56                   	push   %esi
801041d4:	53                   	push   %ebx
801041d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801041d8:	83 ec 0c             	sub    $0xc,%esp
801041db:	8d 73 04             	lea    0x4(%ebx),%esi
801041de:	56                   	push   %esi
801041df:	e8 7c 00 00 00       	call   80104260 <acquire>
  lk->locked = 0;
801041e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801041ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801041f1:	89 1c 24             	mov    %ebx,(%esp)
801041f4:	e8 87 fd ff ff       	call   80103f80 <wakeup>
  release(&lk->lk);
801041f9:	89 75 08             	mov    %esi,0x8(%ebp)
801041fc:	83 c4 10             	add    $0x10,%esp
}
801041ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104202:	5b                   	pop    %ebx
80104203:	5e                   	pop    %esi
80104204:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104205:	e9 36 02 00 00       	jmp    80104440 <release>
8010420a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104210 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	56                   	push   %esi
80104214:	53                   	push   %ebx
80104215:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104218:	83 ec 0c             	sub    $0xc,%esp
8010421b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010421e:	53                   	push   %ebx
8010421f:	e8 3c 00 00 00       	call   80104260 <acquire>
  r = lk->locked;
80104224:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104226:	89 1c 24             	mov    %ebx,(%esp)
80104229:	e8 12 02 00 00       	call   80104440 <release>
  return r;
}
8010422e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104231:	89 f0                	mov    %esi,%eax
80104233:	5b                   	pop    %ebx
80104234:	5e                   	pop    %esi
80104235:	5d                   	pop    %ebp
80104236:	c3                   	ret    
80104237:	66 90                	xchg   %ax,%ax
80104239:	66 90                	xchg   %ax,%ax
8010423b:	66 90                	xchg   %ax,%ax
8010423d:	66 90                	xchg   %ax,%ax
8010423f:	90                   	nop

80104240 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104246:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104249:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010424f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104252:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104259:	5d                   	pop    %ebp
8010425a:	c3                   	ret    
8010425b:	90                   	nop
8010425c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104260 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 04             	sub    $0x4,%esp
80104267:	9c                   	pushf  
80104268:	5a                   	pop    %edx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104269:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
8010426a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104271:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104277:	85 c0                	test   %eax,%eax
80104279:	75 0c                	jne    80104287 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
8010427b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104281:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
80104287:	8b 55 08             	mov    0x8(%ebp),%edx

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
    cpu->intena = eflags & FL_IF;
  cpu->ncli += 1;
8010428a:	83 c0 01             	add    $0x1,%eax
8010428d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104293:	8b 02                	mov    (%edx),%eax
80104295:	85 c0                	test   %eax,%eax
80104297:	74 05                	je     8010429e <acquire+0x3e>
80104299:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010429c:	74 7a                	je     80104318 <acquire+0xb8>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010429e:	b9 01 00 00 00       	mov    $0x1,%ecx
801042a3:	90                   	nop
801042a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042a8:	89 c8                	mov    %ecx,%eax
801042aa:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801042ad:	85 c0                	test   %eax,%eax
801042af:	75 f7                	jne    801042a8 <acquire+0x48>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801042b1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801042b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801042b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801042bf:	89 ea                	mov    %ebp,%edx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801042c1:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
801042c4:	83 c1 0c             	add    $0xc,%ecx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801042c7:	31 c0                	xor    %eax,%eax
801042c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801042d0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801042d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801042dc:	77 1a                	ja     801042f8 <acquire+0x98>
      break;
    pcs[i] = ebp[1];     // saved %eip
801042de:	8b 5a 04             	mov    0x4(%edx),%ebx
801042e1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801042e4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801042e7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801042e9:	83 f8 0a             	cmp    $0xa,%eax
801042ec:	75 e2                	jne    801042d0 <acquire+0x70>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  getcallerpcs(&lk, lk->pcs);
}
801042ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042f1:	c9                   	leave  
801042f2:	c3                   	ret    
801042f3:	90                   	nop
801042f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801042f8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801042ff:	83 c0 01             	add    $0x1,%eax
80104302:	83 f8 0a             	cmp    $0xa,%eax
80104305:	74 e7                	je     801042ee <acquire+0x8e>
    pcs[i] = 0;
80104307:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010430e:	83 c0 01             	add    $0x1,%eax
80104311:	83 f8 0a             	cmp    $0xa,%eax
80104314:	75 e2                	jne    801042f8 <acquire+0x98>
80104316:	eb d6                	jmp    801042ee <acquire+0x8e>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104318:	83 ec 0c             	sub    $0xc,%esp
8010431b:	68 83 75 10 80       	push   $0x80107583
80104320:	e8 4b c0 ff ff       	call   80100370 <panic>
80104325:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104330 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104334:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104337:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010433a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010433d:	31 c0                	xor    %eax,%eax
8010433f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104340:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104346:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010434c:	77 1a                	ja     80104368 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010434e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104351:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104354:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104357:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104359:	83 f8 0a             	cmp    $0xa,%eax
8010435c:	75 e2                	jne    80104340 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010435e:	5b                   	pop    %ebx
8010435f:	5d                   	pop    %ebp
80104360:	c3                   	ret    
80104361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104368:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010436f:	83 c0 01             	add    $0x1,%eax
80104372:	83 f8 0a             	cmp    $0xa,%eax
80104375:	74 e7                	je     8010435e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104377:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010437e:	83 c0 01             	add    $0x1,%eax
80104381:	83 f8 0a             	cmp    $0xa,%eax
80104384:	75 e2                	jne    80104368 <getcallerpcs+0x38>
80104386:	eb d6                	jmp    8010435e <getcallerpcs+0x2e>
80104388:	90                   	nop
80104389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104390 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104396:	8b 02                	mov    (%edx),%eax
80104398:	85 c0                	test   %eax,%eax
8010439a:	74 14                	je     801043b0 <holding+0x20>
8010439c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801043a2:	39 42 08             	cmp    %eax,0x8(%edx)
}
801043a5:	5d                   	pop    %ebp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801043a6:	0f 94 c0             	sete   %al
801043a9:	0f b6 c0             	movzbl %al,%eax
}
801043ac:	c3                   	ret    
801043ad:	8d 76 00             	lea    0x0(%esi),%esi
801043b0:	31 c0                	xor    %eax,%eax
801043b2:	5d                   	pop    %ebp
801043b3:	c3                   	ret    
801043b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801043c0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043c3:	9c                   	pushf  
801043c4:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
801043c5:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801043c6:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801043cd:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
801043d3:	85 c0                	test   %eax,%eax
801043d5:	75 0c                	jne    801043e3 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
801043d7:	81 e1 00 02 00 00    	and    $0x200,%ecx
801043dd:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
801043e3:	83 c0 01             	add    $0x1,%eax
801043e6:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
801043ec:	5d                   	pop    %ebp
801043ed:	c3                   	ret    
801043ee:	66 90                	xchg   %ax,%ax

801043f0 <popcli>:

void
popcli(void)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801043f6:	9c                   	pushf  
801043f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801043f8:	f6 c4 02             	test   $0x2,%ah
801043fb:	75 2c                	jne    80104429 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
801043fd:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104404:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
8010440b:	78 0f                	js     8010441c <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
8010440d:	75 0b                	jne    8010441a <popcli+0x2a>
8010440f:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104415:	85 c0                	test   %eax,%eax
80104417:	74 01                	je     8010441a <popcli+0x2a>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104419:	fb                   	sti    
    sti();
}
8010441a:	c9                   	leave  
8010441b:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
8010441c:	83 ec 0c             	sub    $0xc,%esp
8010441f:	68 a2 75 10 80       	push   $0x801075a2
80104424:	e8 47 bf ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104429:	83 ec 0c             	sub    $0xc,%esp
8010442c:	68 8b 75 10 80       	push   $0x8010758b
80104431:	e8 3a bf ff ff       	call   80100370 <panic>
80104436:	8d 76 00             	lea    0x0(%esi),%esi
80104439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104440 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	83 ec 08             	sub    $0x8,%esp
80104446:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104449:	8b 10                	mov    (%eax),%edx
8010444b:	85 d2                	test   %edx,%edx
8010444d:	74 0c                	je     8010445b <release+0x1b>
8010444f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104456:	39 50 08             	cmp    %edx,0x8(%eax)
80104459:	74 15                	je     80104470 <release+0x30>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010445b:	83 ec 0c             	sub    $0xc,%esp
8010445e:	68 a9 75 10 80       	push   $0x801075a9
80104463:	e8 08 bf ff ff       	call   80100370 <panic>
80104468:	90                   	nop
80104469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  lk->pcs[0] = 0;
80104470:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104477:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010447e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104483:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
80104489:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010448a:	e9 61 ff ff ff       	jmp    801043f0 <popcli>
8010448f:	90                   	nop

80104490 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	57                   	push   %edi
80104494:	53                   	push   %ebx
80104495:	8b 55 08             	mov    0x8(%ebp),%edx
80104498:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010449b:	f6 c2 03             	test   $0x3,%dl
8010449e:	75 05                	jne    801044a5 <memset+0x15>
801044a0:	f6 c1 03             	test   $0x3,%cl
801044a3:	74 13                	je     801044b8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801044a5:	89 d7                	mov    %edx,%edi
801044a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801044aa:	fc                   	cld    
801044ab:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801044ad:	5b                   	pop    %ebx
801044ae:	89 d0                	mov    %edx,%eax
801044b0:	5f                   	pop    %edi
801044b1:	5d                   	pop    %ebp
801044b2:	c3                   	ret    
801044b3:	90                   	nop
801044b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801044b8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801044bc:	c1 e9 02             	shr    $0x2,%ecx
801044bf:	89 fb                	mov    %edi,%ebx
801044c1:	89 f8                	mov    %edi,%eax
801044c3:	c1 e3 18             	shl    $0x18,%ebx
801044c6:	c1 e0 10             	shl    $0x10,%eax
801044c9:	09 d8                	or     %ebx,%eax
801044cb:	09 f8                	or     %edi,%eax
801044cd:	c1 e7 08             	shl    $0x8,%edi
801044d0:	09 f8                	or     %edi,%eax
801044d2:	89 d7                	mov    %edx,%edi
801044d4:	fc                   	cld    
801044d5:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801044d7:	5b                   	pop    %ebx
801044d8:	89 d0                	mov    %edx,%eax
801044da:	5f                   	pop    %edi
801044db:	5d                   	pop    %ebp
801044dc:	c3                   	ret    
801044dd:	8d 76 00             	lea    0x0(%esi),%esi

801044e0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	57                   	push   %edi
801044e4:	56                   	push   %esi
801044e5:	8b 45 10             	mov    0x10(%ebp),%eax
801044e8:	53                   	push   %ebx
801044e9:	8b 75 0c             	mov    0xc(%ebp),%esi
801044ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801044ef:	85 c0                	test   %eax,%eax
801044f1:	74 29                	je     8010451c <memcmp+0x3c>
    if(*s1 != *s2)
801044f3:	0f b6 13             	movzbl (%ebx),%edx
801044f6:	0f b6 0e             	movzbl (%esi),%ecx
801044f9:	38 d1                	cmp    %dl,%cl
801044fb:	75 2b                	jne    80104528 <memcmp+0x48>
801044fd:	8d 78 ff             	lea    -0x1(%eax),%edi
80104500:	31 c0                	xor    %eax,%eax
80104502:	eb 14                	jmp    80104518 <memcmp+0x38>
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104508:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010450d:	83 c0 01             	add    $0x1,%eax
80104510:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104514:	38 ca                	cmp    %cl,%dl
80104516:	75 10                	jne    80104528 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104518:	39 f8                	cmp    %edi,%eax
8010451a:	75 ec                	jne    80104508 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010451c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010451d:	31 c0                	xor    %eax,%eax
}
8010451f:	5e                   	pop    %esi
80104520:	5f                   	pop    %edi
80104521:	5d                   	pop    %ebp
80104522:	c3                   	ret    
80104523:	90                   	nop
80104524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104528:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010452b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010452c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010452e:	5e                   	pop    %esi
8010452f:	5f                   	pop    %edi
80104530:	5d                   	pop    %ebp
80104531:	c3                   	ret    
80104532:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104540 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	8b 45 08             	mov    0x8(%ebp),%eax
80104548:	8b 75 0c             	mov    0xc(%ebp),%esi
8010454b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010454e:	39 c6                	cmp    %eax,%esi
80104550:	73 2e                	jae    80104580 <memmove+0x40>
80104552:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104555:	39 c8                	cmp    %ecx,%eax
80104557:	73 27                	jae    80104580 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104559:	85 db                	test   %ebx,%ebx
8010455b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010455e:	74 17                	je     80104577 <memmove+0x37>
      *--d = *--s;
80104560:	29 d9                	sub    %ebx,%ecx
80104562:	89 cb                	mov    %ecx,%ebx
80104564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104568:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010456c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010456f:	83 ea 01             	sub    $0x1,%edx
80104572:	83 fa ff             	cmp    $0xffffffff,%edx
80104575:	75 f1                	jne    80104568 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104577:	5b                   	pop    %ebx
80104578:	5e                   	pop    %esi
80104579:	5d                   	pop    %ebp
8010457a:	c3                   	ret    
8010457b:	90                   	nop
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104580:	31 d2                	xor    %edx,%edx
80104582:	85 db                	test   %ebx,%ebx
80104584:	74 f1                	je     80104577 <memmove+0x37>
80104586:	8d 76 00             	lea    0x0(%esi),%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104590:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104594:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104597:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010459a:	39 d3                	cmp    %edx,%ebx
8010459c:	75 f2                	jne    80104590 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010459e:	5b                   	pop    %ebx
8010459f:	5e                   	pop    %esi
801045a0:	5d                   	pop    %ebp
801045a1:	c3                   	ret    
801045a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801045b3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801045b4:	eb 8a                	jmp    80104540 <memmove>
801045b6:	8d 76 00             	lea    0x0(%esi),%esi
801045b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045c0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045c8:	53                   	push   %ebx
801045c9:	8b 7d 08             	mov    0x8(%ebp),%edi
801045cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801045cf:	85 c9                	test   %ecx,%ecx
801045d1:	74 37                	je     8010460a <strncmp+0x4a>
801045d3:	0f b6 17             	movzbl (%edi),%edx
801045d6:	0f b6 1e             	movzbl (%esi),%ebx
801045d9:	84 d2                	test   %dl,%dl
801045db:	74 3f                	je     8010461c <strncmp+0x5c>
801045dd:	38 d3                	cmp    %dl,%bl
801045df:	75 3b                	jne    8010461c <strncmp+0x5c>
801045e1:	8d 47 01             	lea    0x1(%edi),%eax
801045e4:	01 cf                	add    %ecx,%edi
801045e6:	eb 1b                	jmp    80104603 <strncmp+0x43>
801045e8:	90                   	nop
801045e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045f0:	0f b6 10             	movzbl (%eax),%edx
801045f3:	84 d2                	test   %dl,%dl
801045f5:	74 21                	je     80104618 <strncmp+0x58>
801045f7:	0f b6 19             	movzbl (%ecx),%ebx
801045fa:	83 c0 01             	add    $0x1,%eax
801045fd:	89 ce                	mov    %ecx,%esi
801045ff:	38 da                	cmp    %bl,%dl
80104601:	75 19                	jne    8010461c <strncmp+0x5c>
80104603:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104605:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104608:	75 e6                	jne    801045f0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010460a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010460b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010460d:	5e                   	pop    %esi
8010460e:	5f                   	pop    %edi
8010460f:	5d                   	pop    %ebp
80104610:	c3                   	ret    
80104611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104618:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010461c:	0f b6 c2             	movzbl %dl,%eax
8010461f:	29 d8                	sub    %ebx,%eax
}
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5f                   	pop    %edi
80104624:	5d                   	pop    %ebp
80104625:	c3                   	ret    
80104626:	8d 76 00             	lea    0x0(%esi),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	56                   	push   %esi
80104634:	53                   	push   %ebx
80104635:	8b 45 08             	mov    0x8(%ebp),%eax
80104638:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010463b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010463e:	89 c2                	mov    %eax,%edx
80104640:	eb 19                	jmp    8010465b <strncpy+0x2b>
80104642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104648:	83 c3 01             	add    $0x1,%ebx
8010464b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010464f:	83 c2 01             	add    $0x1,%edx
80104652:	84 c9                	test   %cl,%cl
80104654:	88 4a ff             	mov    %cl,-0x1(%edx)
80104657:	74 09                	je     80104662 <strncpy+0x32>
80104659:	89 f1                	mov    %esi,%ecx
8010465b:	85 c9                	test   %ecx,%ecx
8010465d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104660:	7f e6                	jg     80104648 <strncpy+0x18>
    ;
  while(n-- > 0)
80104662:	31 c9                	xor    %ecx,%ecx
80104664:	85 f6                	test   %esi,%esi
80104666:	7e 17                	jle    8010467f <strncpy+0x4f>
80104668:	90                   	nop
80104669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104670:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104674:	89 f3                	mov    %esi,%ebx
80104676:	83 c1 01             	add    $0x1,%ecx
80104679:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010467b:	85 db                	test   %ebx,%ebx
8010467d:	7f f1                	jg     80104670 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010467f:	5b                   	pop    %ebx
80104680:	5e                   	pop    %esi
80104681:	5d                   	pop    %ebp
80104682:	c3                   	ret    
80104683:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104690 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104698:	8b 45 08             	mov    0x8(%ebp),%eax
8010469b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010469e:	85 c9                	test   %ecx,%ecx
801046a0:	7e 26                	jle    801046c8 <safestrcpy+0x38>
801046a2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801046a6:	89 c1                	mov    %eax,%ecx
801046a8:	eb 17                	jmp    801046c1 <safestrcpy+0x31>
801046aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801046b0:	83 c2 01             	add    $0x1,%edx
801046b3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801046b7:	83 c1 01             	add    $0x1,%ecx
801046ba:	84 db                	test   %bl,%bl
801046bc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801046bf:	74 04                	je     801046c5 <safestrcpy+0x35>
801046c1:	39 f2                	cmp    %esi,%edx
801046c3:	75 eb                	jne    801046b0 <safestrcpy+0x20>
    ;
  *s = 0;
801046c5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801046c8:	5b                   	pop    %ebx
801046c9:	5e                   	pop    %esi
801046ca:	5d                   	pop    %ebp
801046cb:	c3                   	ret    
801046cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046d0 <strlen>:

int
strlen(const char *s)
{
801046d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801046d1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
801046d3:	89 e5                	mov    %esp,%ebp
801046d5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
801046d8:	80 3a 00             	cmpb   $0x0,(%edx)
801046db:	74 0c                	je     801046e9 <strlen+0x19>
801046dd:	8d 76 00             	lea    0x0(%esi),%esi
801046e0:	83 c0 01             	add    $0x1,%eax
801046e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801046e7:	75 f7                	jne    801046e0 <strlen+0x10>
    ;
  return n;
}
801046e9:	5d                   	pop    %ebp
801046ea:	c3                   	ret    

801046eb <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801046eb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801046ef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801046f3:	55                   	push   %ebp
  pushl %ebx
801046f4:	53                   	push   %ebx
  pushl %esi
801046f5:	56                   	push   %esi
  pushl %edi
801046f6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801046f7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801046f9:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801046fb:	5f                   	pop    %edi
  popl %esi
801046fc:	5e                   	pop    %esi
  popl %ebx
801046fd:	5b                   	pop    %ebx
  popl %ebp
801046fe:	5d                   	pop    %ebp
  ret
801046ff:	c3                   	ret    

80104700 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104700:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104701:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104708:	89 e5                	mov    %esp,%ebp
8010470a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010470d:	8b 12                	mov    (%edx),%edx
8010470f:	39 c2                	cmp    %eax,%edx
80104711:	76 15                	jbe    80104728 <fetchint+0x28>
80104713:	8d 48 04             	lea    0x4(%eax),%ecx
80104716:	39 ca                	cmp    %ecx,%edx
80104718:	72 0e                	jb     80104728 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010471a:	8b 10                	mov    (%eax),%edx
8010471c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010471f:	89 10                	mov    %edx,(%eax)
  return 0;
80104721:	31 c0                	xor    %eax,%eax
}
80104723:	5d                   	pop    %ebp
80104724:	c3                   	ret    
80104725:	8d 76 00             	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(addr);
  return 0;
}
8010472d:	5d                   	pop    %ebp
8010472e:	c3                   	ret    
8010472f:	90                   	nop

80104730 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104730:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104731:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104737:	89 e5                	mov    %esp,%ebp
80104739:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *s, *ep;

  if(addr >= proc->sz)
8010473c:	39 08                	cmp    %ecx,(%eax)
8010473e:	76 2c                	jbe    8010476c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104740:	8b 55 0c             	mov    0xc(%ebp),%edx
80104743:	89 c8                	mov    %ecx,%eax
80104745:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104747:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010474e:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104750:	39 d1                	cmp    %edx,%ecx
80104752:	73 18                	jae    8010476c <fetchstr+0x3c>
    if(*s == 0)
80104754:	80 39 00             	cmpb   $0x0,(%ecx)
80104757:	75 0c                	jne    80104765 <fetchstr+0x35>
80104759:	eb 1d                	jmp    80104778 <fetchstr+0x48>
8010475b:	90                   	nop
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104760:	80 38 00             	cmpb   $0x0,(%eax)
80104763:	74 13                	je     80104778 <fetchstr+0x48>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80104765:	83 c0 01             	add    $0x1,%eax
80104768:	39 c2                	cmp    %eax,%edx
8010476a:	77 f4                	ja     80104760 <fetchstr+0x30>
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
8010476c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
80104771:	5d                   	pop    %ebp
80104772:	c3                   	ret    
80104773:	90                   	nop
80104774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
80104778:	29 c8                	sub    %ecx,%eax
  return -1;
}
8010477a:	5d                   	pop    %ebp
8010477b:	c3                   	ret    
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104780 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104780:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104787:	55                   	push   %ebp
80104788:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010478a:	8b 42 18             	mov    0x18(%edx),%eax
8010478d:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104790:	8b 12                	mov    (%edx),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104792:	8b 40 44             	mov    0x44(%eax),%eax
80104795:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104798:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010479b:	39 d1                	cmp    %edx,%ecx
8010479d:	73 19                	jae    801047b8 <argint+0x38>
8010479f:	8d 48 08             	lea    0x8(%eax),%ecx
801047a2:	39 ca                	cmp    %ecx,%edx
801047a4:	72 12                	jb     801047b8 <argint+0x38>
    return -1;
  *ip = *(int*)(addr);
801047a6:	8b 50 04             	mov    0x4(%eax),%edx
801047a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801047ac:	89 10                	mov    %edx,(%eax)
  return 0;
801047ae:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
801047b0:	5d                   	pop    %ebp
801047b1:	c3                   	ret    
801047b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
801047b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
801047bd:	5d                   	pop    %ebp
801047be:	c3                   	ret    
801047bf:	90                   	nop

801047c0 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801047c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801047c6:	55                   	push   %ebp
801047c7:	89 e5                	mov    %esp,%ebp
801047c9:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801047ca:	8b 50 18             	mov    0x18(%eax),%edx
801047cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
801047d0:	8b 52 44             	mov    0x44(%edx),%edx
801047d3:	8d 0c 8a             	lea    (%edx,%ecx,4),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801047d6:	8b 10                	mov    (%eax),%edx
argptr(int n, char **pp, int size)
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
801047d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801047dd:	8d 59 04             	lea    0x4(%ecx),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801047e0:	39 d3                	cmp    %edx,%ebx
801047e2:	73 1e                	jae    80104802 <argptr+0x42>
801047e4:	8d 59 08             	lea    0x8(%ecx),%ebx
801047e7:	39 da                	cmp    %ebx,%edx
801047e9:	72 17                	jb     80104802 <argptr+0x42>
    return -1;
  *ip = *(int*)(addr);
801047eb:	8b 49 04             	mov    0x4(%ecx),%ecx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801047ee:	39 d1                	cmp    %edx,%ecx
801047f0:	73 10                	jae    80104802 <argptr+0x42>
801047f2:	8b 5d 10             	mov    0x10(%ebp),%ebx
801047f5:	01 cb                	add    %ecx,%ebx
801047f7:	39 d3                	cmp    %edx,%ebx
801047f9:	77 07                	ja     80104802 <argptr+0x42>
    return -1;
  *pp = (char*)i;
801047fb:	8b 45 0c             	mov    0xc(%ebp),%eax
801047fe:	89 08                	mov    %ecx,(%eax)
  return 0;
80104800:	31 c0                	xor    %eax,%eax
}
80104802:	5b                   	pop    %ebx
80104803:	5d                   	pop    %ebp
80104804:	c3                   	ret    
80104805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104810:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104816:	55                   	push   %ebp
80104817:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104819:	8b 50 18             	mov    0x18(%eax),%edx
8010481c:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010481f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104821:	8b 52 44             	mov    0x44(%edx),%edx
80104824:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104827:	8d 4a 04             	lea    0x4(%edx),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010482a:	39 c1                	cmp    %eax,%ecx
8010482c:	73 07                	jae    80104835 <argstr+0x25>
8010482e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104831:	39 c8                	cmp    %ecx,%eax
80104833:	73 0b                	jae    80104840 <argstr+0x30>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104835:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
8010483a:	5d                   	pop    %ebp
8010483b:	c3                   	ret    
8010483c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104840:	8b 4a 04             	mov    0x4(%edx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
80104843:	39 c1                	cmp    %eax,%ecx
80104845:	73 ee                	jae    80104835 <argstr+0x25>
    return -1;
  *pp = (char*)addr;
80104847:	8b 55 0c             	mov    0xc(%ebp),%edx
8010484a:	89 c8                	mov    %ecx,%eax
8010484c:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
8010484e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104855:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104857:	39 d1                	cmp    %edx,%ecx
80104859:	73 da                	jae    80104835 <argstr+0x25>
    if(*s == 0)
8010485b:	80 39 00             	cmpb   $0x0,(%ecx)
8010485e:	75 0d                	jne    8010486d <argstr+0x5d>
80104860:	eb 1e                	jmp    80104880 <argstr+0x70>
80104862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104868:	80 38 00             	cmpb   $0x0,(%eax)
8010486b:	74 13                	je     80104880 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010486d:	83 c0 01             	add    $0x1,%eax
80104870:	39 c2                	cmp    %eax,%edx
80104872:	77 f4                	ja     80104868 <argstr+0x58>
80104874:	eb bf                	jmp    80104835 <argstr+0x25>
80104876:	8d 76 00             	lea    0x0(%esi),%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(*s == 0)
      return s - *pp;
80104880:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104882:	5d                   	pop    %ebp
80104883:	c3                   	ret    
80104884:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010488a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104890 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
80104894:	83 ec 04             	sub    $0x4,%esp
  int num;

  num = proc->tf->eax;
80104897:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010489e:	8b 5a 18             	mov    0x18(%edx),%ebx
801048a1:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801048a4:	8d 48 ff             	lea    -0x1(%eax),%ecx
801048a7:	83 f9 14             	cmp    $0x14,%ecx
801048aa:	77 1c                	ja     801048c8 <syscall+0x38>
801048ac:	8b 0c 85 e0 75 10 80 	mov    -0x7fef8a20(,%eax,4),%ecx
801048b3:	85 c9                	test   %ecx,%ecx
801048b5:	74 11                	je     801048c8 <syscall+0x38>
    proc->tf->eax = syscalls[num]();
801048b7:	ff d1                	call   *%ecx
801048b9:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
801048bc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048bf:	c9                   	leave  
801048c0:	c3                   	ret    
801048c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801048c8:	50                   	push   %eax
            proc->pid, proc->name, num);
801048c9:	8d 42 6c             	lea    0x6c(%edx),%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
801048cc:	50                   	push   %eax
801048cd:	ff 72 10             	pushl  0x10(%edx)
801048d0:	68 b1 75 10 80       	push   $0x801075b1
801048d5:	e8 86 bd ff ff       	call   80100660 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801048da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048e0:	83 c4 10             	add    $0x10,%esp
801048e3:	8b 40 18             	mov    0x18(%eax),%eax
801048e6:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801048ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048f0:	c9                   	leave  
801048f1:	c3                   	ret    
801048f2:	66 90                	xchg   %ax,%ax
801048f4:	66 90                	xchg   %ax,%ax
801048f6:	66 90                	xchg   %ax,%ax
801048f8:	66 90                	xchg   %ax,%ax
801048fa:	66 90                	xchg   %ax,%ax
801048fc:	66 90                	xchg   %ax,%ax
801048fe:	66 90                	xchg   %ax,%ax

80104900 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	57                   	push   %edi
80104904:	56                   	push   %esi
80104905:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104906:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104909:	83 ec 44             	sub    $0x44,%esp
8010490c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010490f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104912:	56                   	push   %esi
80104913:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104914:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104917:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010491a:	e8 91 d5 ff ff       	call   80101eb0 <nameiparent>
8010491f:	83 c4 10             	add    $0x10,%esp
80104922:	85 c0                	test   %eax,%eax
80104924:	0f 84 f6 00 00 00    	je     80104a20 <create+0x120>
    return 0;
  ilock(dp);
8010492a:	83 ec 0c             	sub    $0xc,%esp
8010492d:	89 c7                	mov    %eax,%edi
8010492f:	50                   	push   %eax
80104930:	e8 2b cd ff ff       	call   80101660 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104935:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104938:	83 c4 0c             	add    $0xc,%esp
8010493b:	50                   	push   %eax
8010493c:	56                   	push   %esi
8010493d:	57                   	push   %edi
8010493e:	e8 2d d2 ff ff       	call   80101b70 <dirlookup>
80104943:	83 c4 10             	add    $0x10,%esp
80104946:	85 c0                	test   %eax,%eax
80104948:	89 c3                	mov    %eax,%ebx
8010494a:	74 54                	je     801049a0 <create+0xa0>
    iunlockput(dp);
8010494c:	83 ec 0c             	sub    $0xc,%esp
8010494f:	57                   	push   %edi
80104950:	e8 7b cf ff ff       	call   801018d0 <iunlockput>
    ilock(ip);
80104955:	89 1c 24             	mov    %ebx,(%esp)
80104958:	e8 03 cd ff ff       	call   80101660 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010495d:	83 c4 10             	add    $0x10,%esp
80104960:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104965:	75 19                	jne    80104980 <create+0x80>
80104967:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
8010496c:	89 d8                	mov    %ebx,%eax
8010496e:	75 10                	jne    80104980 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104973:	5b                   	pop    %ebx
80104974:	5e                   	pop    %esi
80104975:	5f                   	pop    %edi
80104976:	5d                   	pop    %ebp
80104977:	c3                   	ret    
80104978:	90                   	nop
80104979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104980:	83 ec 0c             	sub    $0xc,%esp
80104983:	53                   	push   %ebx
80104984:	e8 47 cf ff ff       	call   801018d0 <iunlockput>
    return 0;
80104989:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010498c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
8010498f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104991:	5b                   	pop    %ebx
80104992:	5e                   	pop    %esi
80104993:	5f                   	pop    %edi
80104994:	5d                   	pop    %ebp
80104995:	c3                   	ret    
80104996:	8d 76 00             	lea    0x0(%esi),%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801049a0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801049a4:	83 ec 08             	sub    $0x8,%esp
801049a7:	50                   	push   %eax
801049a8:	ff 37                	pushl  (%edi)
801049aa:	e8 41 cb ff ff       	call   801014f0 <ialloc>
801049af:	83 c4 10             	add    $0x10,%esp
801049b2:	85 c0                	test   %eax,%eax
801049b4:	89 c3                	mov    %eax,%ebx
801049b6:	0f 84 cc 00 00 00    	je     80104a88 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
801049bc:	83 ec 0c             	sub    $0xc,%esp
801049bf:	50                   	push   %eax
801049c0:	e8 9b cc ff ff       	call   80101660 <ilock>
  ip->major = major;
801049c5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801049c9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
801049cd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
801049d1:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
801049d5:	b8 01 00 00 00       	mov    $0x1,%eax
801049da:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
801049de:	89 1c 24             	mov    %ebx,(%esp)
801049e1:	e8 ca cb ff ff       	call   801015b0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
801049e6:	83 c4 10             	add    $0x10,%esp
801049e9:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801049ee:	74 40                	je     80104a30 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
801049f0:	83 ec 04             	sub    $0x4,%esp
801049f3:	ff 73 04             	pushl  0x4(%ebx)
801049f6:	56                   	push   %esi
801049f7:	57                   	push   %edi
801049f8:	e8 d3 d3 ff ff       	call   80101dd0 <dirlink>
801049fd:	83 c4 10             	add    $0x10,%esp
80104a00:	85 c0                	test   %eax,%eax
80104a02:	78 77                	js     80104a7b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80104a04:	83 ec 0c             	sub    $0xc,%esp
80104a07:	57                   	push   %edi
80104a08:	e8 c3 ce ff ff       	call   801018d0 <iunlockput>

  return ip;
80104a0d:	83 c4 10             	add    $0x10,%esp
}
80104a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104a13:	89 d8                	mov    %ebx,%eax
}
80104a15:	5b                   	pop    %ebx
80104a16:	5e                   	pop    %esi
80104a17:	5f                   	pop    %edi
80104a18:	5d                   	pop    %ebp
80104a19:	c3                   	ret    
80104a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104a20:	31 c0                	xor    %eax,%eax
80104a22:	e9 49 ff ff ff       	jmp    80104970 <create+0x70>
80104a27:	89 f6                	mov    %esi,%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104a30:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104a35:	83 ec 0c             	sub    $0xc,%esp
80104a38:	57                   	push   %edi
80104a39:	e8 72 cb ff ff       	call   801015b0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104a3e:	83 c4 0c             	add    $0xc,%esp
80104a41:	ff 73 04             	pushl  0x4(%ebx)
80104a44:	68 54 76 10 80       	push   $0x80107654
80104a49:	53                   	push   %ebx
80104a4a:	e8 81 d3 ff ff       	call   80101dd0 <dirlink>
80104a4f:	83 c4 10             	add    $0x10,%esp
80104a52:	85 c0                	test   %eax,%eax
80104a54:	78 18                	js     80104a6e <create+0x16e>
80104a56:	83 ec 04             	sub    $0x4,%esp
80104a59:	ff 77 04             	pushl  0x4(%edi)
80104a5c:	68 53 76 10 80       	push   $0x80107653
80104a61:	53                   	push   %ebx
80104a62:	e8 69 d3 ff ff       	call   80101dd0 <dirlink>
80104a67:	83 c4 10             	add    $0x10,%esp
80104a6a:	85 c0                	test   %eax,%eax
80104a6c:	79 82                	jns    801049f0 <create+0xf0>
      panic("create dots");
80104a6e:	83 ec 0c             	sub    $0xc,%esp
80104a71:	68 47 76 10 80       	push   $0x80107647
80104a76:	e8 f5 b8 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104a7b:	83 ec 0c             	sub    $0xc,%esp
80104a7e:	68 56 76 10 80       	push   $0x80107656
80104a83:	e8 e8 b8 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104a88:	83 ec 0c             	sub    $0xc,%esp
80104a8b:	68 38 76 10 80       	push   $0x80107638
80104a90:	e8 db b8 ff ff       	call   80100370 <panic>
80104a95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	56                   	push   %esi
80104aa4:	53                   	push   %ebx
80104aa5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104aa7:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104aaa:	89 d3                	mov    %edx,%ebx
80104aac:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104aaf:	50                   	push   %eax
80104ab0:	6a 00                	push   $0x0
80104ab2:	e8 c9 fc ff ff       	call   80104780 <argint>
80104ab7:	83 c4 10             	add    $0x10,%esp
80104aba:	85 c0                	test   %eax,%eax
80104abc:	78 3a                	js     80104af8 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ac1:	83 f8 0f             	cmp    $0xf,%eax
80104ac4:	77 32                	ja     80104af8 <argfd.constprop.0+0x58>
80104ac6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104acd:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104ad1:	85 d2                	test   %edx,%edx
80104ad3:	74 23                	je     80104af8 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
80104ad5:	85 f6                	test   %esi,%esi
80104ad7:	74 02                	je     80104adb <argfd.constprop.0+0x3b>
    *pfd = fd;
80104ad9:	89 06                	mov    %eax,(%esi)
  if(pf)
80104adb:	85 db                	test   %ebx,%ebx
80104add:	74 11                	je     80104af0 <argfd.constprop.0+0x50>
    *pf = f;
80104adf:	89 13                	mov    %edx,(%ebx)
  return 0;
80104ae1:	31 c0                	xor    %eax,%eax
}
80104ae3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ae6:	5b                   	pop    %ebx
80104ae7:	5e                   	pop    %esi
80104ae8:	5d                   	pop    %ebp
80104ae9:	c3                   	ret    
80104aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104af0:	31 c0                	xor    %eax,%eax
80104af2:	eb ef                	jmp    80104ae3 <argfd.constprop.0+0x43>
80104af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104af8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104afd:	eb e4                	jmp    80104ae3 <argfd.constprop.0+0x43>
80104aff:	90                   	nop

80104b00 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104b00:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104b01:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104b03:	89 e5                	mov    %esp,%ebp
80104b05:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104b06:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104b09:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104b0c:	e8 8f ff ff ff       	call   80104aa0 <argfd.constprop.0>
80104b11:	85 c0                	test   %eax,%eax
80104b13:	78 1b                	js     80104b30 <sys_dup+0x30>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104b15:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104b1e:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
80104b20:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104b24:	85 c9                	test   %ecx,%ecx
80104b26:	74 18                	je     80104b40 <sys_dup+0x40>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104b28:	83 c3 01             	add    $0x1,%ebx
80104b2b:	83 fb 10             	cmp    $0x10,%ebx
80104b2e:	75 f0                	jne    80104b20 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104b35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b38:	c9                   	leave  
80104b39:	c3                   	ret    
80104b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104b40:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104b43:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104b47:	52                   	push   %edx
80104b48:	e8 83 c2 ff ff       	call   80100dd0 <filedup>
  return fd;
80104b4d:	89 d8                	mov    %ebx,%eax
80104b4f:	83 c4 10             	add    $0x10,%esp
}
80104b52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b55:	c9                   	leave  
80104b56:	c3                   	ret    
80104b57:	89 f6                	mov    %esi,%esi
80104b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b60 <sys_read>:

int
sys_read(void)
{
80104b60:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b61:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104b63:	89 e5                	mov    %esp,%ebp
80104b65:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b68:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104b6b:	e8 30 ff ff ff       	call   80104aa0 <argfd.constprop.0>
80104b70:	85 c0                	test   %eax,%eax
80104b72:	78 4c                	js     80104bc0 <sys_read+0x60>
80104b74:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b77:	83 ec 08             	sub    $0x8,%esp
80104b7a:	50                   	push   %eax
80104b7b:	6a 02                	push   $0x2
80104b7d:	e8 fe fb ff ff       	call   80104780 <argint>
80104b82:	83 c4 10             	add    $0x10,%esp
80104b85:	85 c0                	test   %eax,%eax
80104b87:	78 37                	js     80104bc0 <sys_read+0x60>
80104b89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b8c:	83 ec 04             	sub    $0x4,%esp
80104b8f:	ff 75 f0             	pushl  -0x10(%ebp)
80104b92:	50                   	push   %eax
80104b93:	6a 01                	push   $0x1
80104b95:	e8 26 fc ff ff       	call   801047c0 <argptr>
80104b9a:	83 c4 10             	add    $0x10,%esp
80104b9d:	85 c0                	test   %eax,%eax
80104b9f:	78 1f                	js     80104bc0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104ba1:	83 ec 04             	sub    $0x4,%esp
80104ba4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ba7:	ff 75 f4             	pushl  -0xc(%ebp)
80104baa:	ff 75 ec             	pushl  -0x14(%ebp)
80104bad:	e8 8e c3 ff ff       	call   80100f40 <fileread>
80104bb2:	83 c4 10             	add    $0x10,%esp
}
80104bb5:	c9                   	leave  
80104bb6:	c3                   	ret    
80104bb7:	89 f6                	mov    %esi,%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104bc5:	c9                   	leave  
80104bc6:	c3                   	ret    
80104bc7:	89 f6                	mov    %esi,%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <sys_write>:

int
sys_write(void)
{
80104bd0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bd1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104bd3:	89 e5                	mov    %esp,%ebp
80104bd5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bd8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104bdb:	e8 c0 fe ff ff       	call   80104aa0 <argfd.constprop.0>
80104be0:	85 c0                	test   %eax,%eax
80104be2:	78 4c                	js     80104c30 <sys_write+0x60>
80104be4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104be7:	83 ec 08             	sub    $0x8,%esp
80104bea:	50                   	push   %eax
80104beb:	6a 02                	push   $0x2
80104bed:	e8 8e fb ff ff       	call   80104780 <argint>
80104bf2:	83 c4 10             	add    $0x10,%esp
80104bf5:	85 c0                	test   %eax,%eax
80104bf7:	78 37                	js     80104c30 <sys_write+0x60>
80104bf9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bfc:	83 ec 04             	sub    $0x4,%esp
80104bff:	ff 75 f0             	pushl  -0x10(%ebp)
80104c02:	50                   	push   %eax
80104c03:	6a 01                	push   $0x1
80104c05:	e8 b6 fb ff ff       	call   801047c0 <argptr>
80104c0a:	83 c4 10             	add    $0x10,%esp
80104c0d:	85 c0                	test   %eax,%eax
80104c0f:	78 1f                	js     80104c30 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104c11:	83 ec 04             	sub    $0x4,%esp
80104c14:	ff 75 f0             	pushl  -0x10(%ebp)
80104c17:	ff 75 f4             	pushl  -0xc(%ebp)
80104c1a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c1d:	e8 ae c3 ff ff       	call   80100fd0 <filewrite>
80104c22:	83 c4 10             	add    $0x10,%esp
}
80104c25:	c9                   	leave  
80104c26:	c3                   	ret    
80104c27:	89 f6                	mov    %esi,%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104c30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104c35:	c9                   	leave  
80104c36:	c3                   	ret    
80104c37:	89 f6                	mov    %esi,%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <sys_close>:

int
sys_close(void)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104c46:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104c49:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c4c:	e8 4f fe ff ff       	call   80104aa0 <argfd.constprop.0>
80104c51:	85 c0                	test   %eax,%eax
80104c53:	78 2b                	js     80104c80 <sys_close+0x40>
    return -1;
  proc->ofile[fd] = 0;
80104c55:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104c58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
80104c5e:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
80104c61:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104c68:	00 
  fileclose(f);
80104c69:	ff 75 f4             	pushl  -0xc(%ebp)
80104c6c:	e8 af c1 ff ff       	call   80100e20 <fileclose>
  return 0;
80104c71:	83 c4 10             	add    $0x10,%esp
80104c74:	31 c0                	xor    %eax,%eax
}
80104c76:	c9                   	leave  
80104c77:	c3                   	ret    
80104c78:	90                   	nop
80104c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104c85:	c9                   	leave  
80104c86:	c3                   	ret    
80104c87:	89 f6                	mov    %esi,%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <sys_fstat>:

int
sys_fstat(void)
{
80104c90:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104c91:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104c93:	89 e5                	mov    %esp,%ebp
80104c95:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104c98:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104c9b:	e8 00 fe ff ff       	call   80104aa0 <argfd.constprop.0>
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	78 2c                	js     80104cd0 <sys_fstat+0x40>
80104ca4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ca7:	83 ec 04             	sub    $0x4,%esp
80104caa:	6a 14                	push   $0x14
80104cac:	50                   	push   %eax
80104cad:	6a 01                	push   $0x1
80104caf:	e8 0c fb ff ff       	call   801047c0 <argptr>
80104cb4:	83 c4 10             	add    $0x10,%esp
80104cb7:	85 c0                	test   %eax,%eax
80104cb9:	78 15                	js     80104cd0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104cbb:	83 ec 08             	sub    $0x8,%esp
80104cbe:	ff 75 f4             	pushl  -0xc(%ebp)
80104cc1:	ff 75 f0             	pushl  -0x10(%ebp)
80104cc4:	e8 27 c2 ff ff       	call   80100ef0 <filestat>
80104cc9:	83 c4 10             	add    $0x10,%esp
}
80104ccc:	c9                   	leave  
80104ccd:	c3                   	ret    
80104cce:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	57                   	push   %edi
80104ce4:	56                   	push   %esi
80104ce5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104ce6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104ce9:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104cec:	50                   	push   %eax
80104ced:	6a 00                	push   $0x0
80104cef:	e8 1c fb ff ff       	call   80104810 <argstr>
80104cf4:	83 c4 10             	add    $0x10,%esp
80104cf7:	85 c0                	test   %eax,%eax
80104cf9:	0f 88 fb 00 00 00    	js     80104dfa <sys_link+0x11a>
80104cff:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104d02:	83 ec 08             	sub    $0x8,%esp
80104d05:	50                   	push   %eax
80104d06:	6a 01                	push   $0x1
80104d08:	e8 03 fb ff ff       	call   80104810 <argstr>
80104d0d:	83 c4 10             	add    $0x10,%esp
80104d10:	85 c0                	test   %eax,%eax
80104d12:	0f 88 e2 00 00 00    	js     80104dfa <sys_link+0x11a>
    return -1;

  begin_op();
80104d18:	e8 a3 de ff ff       	call   80102bc0 <begin_op>
  if((ip = namei(old)) == 0){
80104d1d:	83 ec 0c             	sub    $0xc,%esp
80104d20:	ff 75 d4             	pushl  -0x2c(%ebp)
80104d23:	e8 68 d1 ff ff       	call   80101e90 <namei>
80104d28:	83 c4 10             	add    $0x10,%esp
80104d2b:	85 c0                	test   %eax,%eax
80104d2d:	89 c3                	mov    %eax,%ebx
80104d2f:	0f 84 f3 00 00 00    	je     80104e28 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104d35:	83 ec 0c             	sub    $0xc,%esp
80104d38:	50                   	push   %eax
80104d39:	e8 22 c9 ff ff       	call   80101660 <ilock>
  if(ip->type == T_DIR){
80104d3e:	83 c4 10             	add    $0x10,%esp
80104d41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d46:	0f 84 c4 00 00 00    	je     80104e10 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104d4c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104d51:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104d54:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104d57:	53                   	push   %ebx
80104d58:	e8 53 c8 ff ff       	call   801015b0 <iupdate>
  iunlock(ip);
80104d5d:	89 1c 24             	mov    %ebx,(%esp)
80104d60:	e8 db c9 ff ff       	call   80101740 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104d65:	58                   	pop    %eax
80104d66:	5a                   	pop    %edx
80104d67:	57                   	push   %edi
80104d68:	ff 75 d0             	pushl  -0x30(%ebp)
80104d6b:	e8 40 d1 ff ff       	call   80101eb0 <nameiparent>
80104d70:	83 c4 10             	add    $0x10,%esp
80104d73:	85 c0                	test   %eax,%eax
80104d75:	89 c6                	mov    %eax,%esi
80104d77:	74 5b                	je     80104dd4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80104d79:	83 ec 0c             	sub    $0xc,%esp
80104d7c:	50                   	push   %eax
80104d7d:	e8 de c8 ff ff       	call   80101660 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104d82:	83 c4 10             	add    $0x10,%esp
80104d85:	8b 03                	mov    (%ebx),%eax
80104d87:	39 06                	cmp    %eax,(%esi)
80104d89:	75 3d                	jne    80104dc8 <sys_link+0xe8>
80104d8b:	83 ec 04             	sub    $0x4,%esp
80104d8e:	ff 73 04             	pushl  0x4(%ebx)
80104d91:	57                   	push   %edi
80104d92:	56                   	push   %esi
80104d93:	e8 38 d0 ff ff       	call   80101dd0 <dirlink>
80104d98:	83 c4 10             	add    $0x10,%esp
80104d9b:	85 c0                	test   %eax,%eax
80104d9d:	78 29                	js     80104dc8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104d9f:	83 ec 0c             	sub    $0xc,%esp
80104da2:	56                   	push   %esi
80104da3:	e8 28 cb ff ff       	call   801018d0 <iunlockput>
  iput(ip);
80104da8:	89 1c 24             	mov    %ebx,(%esp)
80104dab:	e8 e0 c9 ff ff       	call   80101790 <iput>

  end_op();
80104db0:	e8 7b de ff ff       	call   80102c30 <end_op>

  return 0;
80104db5:	83 c4 10             	add    $0x10,%esp
80104db8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104dba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104dbd:	5b                   	pop    %ebx
80104dbe:	5e                   	pop    %esi
80104dbf:	5f                   	pop    %edi
80104dc0:	5d                   	pop    %ebp
80104dc1:	c3                   	ret    
80104dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104dc8:	83 ec 0c             	sub    $0xc,%esp
80104dcb:	56                   	push   %esi
80104dcc:	e8 ff ca ff ff       	call   801018d0 <iunlockput>
    goto bad;
80104dd1:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104dd4:	83 ec 0c             	sub    $0xc,%esp
80104dd7:	53                   	push   %ebx
80104dd8:	e8 83 c8 ff ff       	call   80101660 <ilock>
  ip->nlink--;
80104ddd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104de2:	89 1c 24             	mov    %ebx,(%esp)
80104de5:	e8 c6 c7 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80104dea:	89 1c 24             	mov    %ebx,(%esp)
80104ded:	e8 de ca ff ff       	call   801018d0 <iunlockput>
  end_op();
80104df2:	e8 39 de ff ff       	call   80102c30 <end_op>
  return -1;
80104df7:	83 c4 10             	add    $0x10,%esp
}
80104dfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104dfd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e02:	5b                   	pop    %ebx
80104e03:	5e                   	pop    %esi
80104e04:	5f                   	pop    %edi
80104e05:	5d                   	pop    %ebp
80104e06:	c3                   	ret    
80104e07:	89 f6                	mov    %esi,%esi
80104e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104e10:	83 ec 0c             	sub    $0xc,%esp
80104e13:	53                   	push   %ebx
80104e14:	e8 b7 ca ff ff       	call   801018d0 <iunlockput>
    end_op();
80104e19:	e8 12 de ff ff       	call   80102c30 <end_op>
    return -1;
80104e1e:	83 c4 10             	add    $0x10,%esp
80104e21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e26:	eb 92                	jmp    80104dba <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104e28:	e8 03 de ff ff       	call   80102c30 <end_op>
    return -1;
80104e2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e32:	eb 86                	jmp    80104dba <sys_link+0xda>
80104e34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e40 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	57                   	push   %edi
80104e44:	56                   	push   %esi
80104e45:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104e46:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104e49:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104e4c:	50                   	push   %eax
80104e4d:	6a 00                	push   $0x0
80104e4f:	e8 bc f9 ff ff       	call   80104810 <argstr>
80104e54:	83 c4 10             	add    $0x10,%esp
80104e57:	85 c0                	test   %eax,%eax
80104e59:	0f 88 82 01 00 00    	js     80104fe1 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104e5f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104e62:	e8 59 dd ff ff       	call   80102bc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104e67:	83 ec 08             	sub    $0x8,%esp
80104e6a:	53                   	push   %ebx
80104e6b:	ff 75 c0             	pushl  -0x40(%ebp)
80104e6e:	e8 3d d0 ff ff       	call   80101eb0 <nameiparent>
80104e73:	83 c4 10             	add    $0x10,%esp
80104e76:	85 c0                	test   %eax,%eax
80104e78:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104e7b:	0f 84 6a 01 00 00    	je     80104feb <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104e81:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104e84:	83 ec 0c             	sub    $0xc,%esp
80104e87:	56                   	push   %esi
80104e88:	e8 d3 c7 ff ff       	call   80101660 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104e8d:	58                   	pop    %eax
80104e8e:	5a                   	pop    %edx
80104e8f:	68 54 76 10 80       	push   $0x80107654
80104e94:	53                   	push   %ebx
80104e95:	e8 b6 cc ff ff       	call   80101b50 <namecmp>
80104e9a:	83 c4 10             	add    $0x10,%esp
80104e9d:	85 c0                	test   %eax,%eax
80104e9f:	0f 84 fc 00 00 00    	je     80104fa1 <sys_unlink+0x161>
80104ea5:	83 ec 08             	sub    $0x8,%esp
80104ea8:	68 53 76 10 80       	push   $0x80107653
80104ead:	53                   	push   %ebx
80104eae:	e8 9d cc ff ff       	call   80101b50 <namecmp>
80104eb3:	83 c4 10             	add    $0x10,%esp
80104eb6:	85 c0                	test   %eax,%eax
80104eb8:	0f 84 e3 00 00 00    	je     80104fa1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104ebe:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104ec1:	83 ec 04             	sub    $0x4,%esp
80104ec4:	50                   	push   %eax
80104ec5:	53                   	push   %ebx
80104ec6:	56                   	push   %esi
80104ec7:	e8 a4 cc ff ff       	call   80101b70 <dirlookup>
80104ecc:	83 c4 10             	add    $0x10,%esp
80104ecf:	85 c0                	test   %eax,%eax
80104ed1:	89 c3                	mov    %eax,%ebx
80104ed3:	0f 84 c8 00 00 00    	je     80104fa1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80104ed9:	83 ec 0c             	sub    $0xc,%esp
80104edc:	50                   	push   %eax
80104edd:	e8 7e c7 ff ff       	call   80101660 <ilock>

  if(ip->nlink < 1)
80104ee2:	83 c4 10             	add    $0x10,%esp
80104ee5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104eea:	0f 8e 24 01 00 00    	jle    80105014 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104ef0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104ef5:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104ef8:	74 66                	je     80104f60 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104efa:	83 ec 04             	sub    $0x4,%esp
80104efd:	6a 10                	push   $0x10
80104eff:	6a 00                	push   $0x0
80104f01:	56                   	push   %esi
80104f02:	e8 89 f5 ff ff       	call   80104490 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f07:	6a 10                	push   $0x10
80104f09:	ff 75 c4             	pushl  -0x3c(%ebp)
80104f0c:	56                   	push   %esi
80104f0d:	ff 75 b4             	pushl  -0x4c(%ebp)
80104f10:	e8 0b cb ff ff       	call   80101a20 <writei>
80104f15:	83 c4 20             	add    $0x20,%esp
80104f18:	83 f8 10             	cmp    $0x10,%eax
80104f1b:	0f 85 e6 00 00 00    	jne    80105007 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104f21:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f26:	0f 84 9c 00 00 00    	je     80104fc8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104f2c:	83 ec 0c             	sub    $0xc,%esp
80104f2f:	ff 75 b4             	pushl  -0x4c(%ebp)
80104f32:	e8 99 c9 ff ff       	call   801018d0 <iunlockput>

  ip->nlink--;
80104f37:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f3c:	89 1c 24             	mov    %ebx,(%esp)
80104f3f:	e8 6c c6 ff ff       	call   801015b0 <iupdate>
  iunlockput(ip);
80104f44:	89 1c 24             	mov    %ebx,(%esp)
80104f47:	e8 84 c9 ff ff       	call   801018d0 <iunlockput>

  end_op();
80104f4c:	e8 df dc ff ff       	call   80102c30 <end_op>

  return 0;
80104f51:	83 c4 10             	add    $0x10,%esp
80104f54:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104f56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f59:	5b                   	pop    %ebx
80104f5a:	5e                   	pop    %esi
80104f5b:	5f                   	pop    %edi
80104f5c:	5d                   	pop    %ebp
80104f5d:	c3                   	ret    
80104f5e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104f60:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104f64:	76 94                	jbe    80104efa <sys_unlink+0xba>
80104f66:	bf 20 00 00 00       	mov    $0x20,%edi
80104f6b:	eb 0f                	jmp    80104f7c <sys_unlink+0x13c>
80104f6d:	8d 76 00             	lea    0x0(%esi),%esi
80104f70:	83 c7 10             	add    $0x10,%edi
80104f73:	3b 7b 58             	cmp    0x58(%ebx),%edi
80104f76:	0f 83 7e ff ff ff    	jae    80104efa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f7c:	6a 10                	push   $0x10
80104f7e:	57                   	push   %edi
80104f7f:	56                   	push   %esi
80104f80:	53                   	push   %ebx
80104f81:	e8 9a c9 ff ff       	call   80101920 <readi>
80104f86:	83 c4 10             	add    $0x10,%esp
80104f89:	83 f8 10             	cmp    $0x10,%eax
80104f8c:	75 6c                	jne    80104ffa <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104f8e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104f93:	74 db                	je     80104f70 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104f95:	83 ec 0c             	sub    $0xc,%esp
80104f98:	53                   	push   %ebx
80104f99:	e8 32 c9 ff ff       	call   801018d0 <iunlockput>
    goto bad;
80104f9e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104fa1:	83 ec 0c             	sub    $0xc,%esp
80104fa4:	ff 75 b4             	pushl  -0x4c(%ebp)
80104fa7:	e8 24 c9 ff ff       	call   801018d0 <iunlockput>
  end_op();
80104fac:	e8 7f dc ff ff       	call   80102c30 <end_op>
  return -1;
80104fb1:	83 c4 10             	add    $0x10,%esp
}
80104fb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80104fb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fbc:	5b                   	pop    %ebx
80104fbd:	5e                   	pop    %esi
80104fbe:	5f                   	pop    %edi
80104fbf:	5d                   	pop    %ebp
80104fc0:	c3                   	ret    
80104fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104fc8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80104fcb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104fce:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80104fd3:	50                   	push   %eax
80104fd4:	e8 d7 c5 ff ff       	call   801015b0 <iupdate>
80104fd9:	83 c4 10             	add    $0x10,%esp
80104fdc:	e9 4b ff ff ff       	jmp    80104f2c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80104fe1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fe6:	e9 6b ff ff ff       	jmp    80104f56 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
80104feb:	e8 40 dc ff ff       	call   80102c30 <end_op>
    return -1;
80104ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ff5:	e9 5c ff ff ff       	jmp    80104f56 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104ffa:	83 ec 0c             	sub    $0xc,%esp
80104ffd:	68 78 76 10 80       	push   $0x80107678
80105002:	e8 69 b3 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105007:	83 ec 0c             	sub    $0xc,%esp
8010500a:	68 8a 76 10 80       	push   $0x8010768a
8010500f:	e8 5c b3 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105014:	83 ec 0c             	sub    $0xc,%esp
80105017:	68 66 76 10 80       	push   $0x80107666
8010501c:	e8 4f b3 ff ff       	call   80100370 <panic>
80105021:	eb 0d                	jmp    80105030 <sys_open>
80105023:	90                   	nop
80105024:	90                   	nop
80105025:	90                   	nop
80105026:	90                   	nop
80105027:	90                   	nop
80105028:	90                   	nop
80105029:	90                   	nop
8010502a:	90                   	nop
8010502b:	90                   	nop
8010502c:	90                   	nop
8010502d:	90                   	nop
8010502e:	90                   	nop
8010502f:	90                   	nop

80105030 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	57                   	push   %edi
80105034:	56                   	push   %esi
80105035:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105036:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105039:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010503c:	50                   	push   %eax
8010503d:	6a 00                	push   $0x0
8010503f:	e8 cc f7 ff ff       	call   80104810 <argstr>
80105044:	83 c4 10             	add    $0x10,%esp
80105047:	85 c0                	test   %eax,%eax
80105049:	0f 88 9e 00 00 00    	js     801050ed <sys_open+0xbd>
8010504f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105052:	83 ec 08             	sub    $0x8,%esp
80105055:	50                   	push   %eax
80105056:	6a 01                	push   $0x1
80105058:	e8 23 f7 ff ff       	call   80104780 <argint>
8010505d:	83 c4 10             	add    $0x10,%esp
80105060:	85 c0                	test   %eax,%eax
80105062:	0f 88 85 00 00 00    	js     801050ed <sys_open+0xbd>
    return -1;

  begin_op();
80105068:	e8 53 db ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
8010506d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105071:	0f 85 89 00 00 00    	jne    80105100 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105077:	83 ec 0c             	sub    $0xc,%esp
8010507a:	ff 75 e0             	pushl  -0x20(%ebp)
8010507d:	e8 0e ce ff ff       	call   80101e90 <namei>
80105082:	83 c4 10             	add    $0x10,%esp
80105085:	85 c0                	test   %eax,%eax
80105087:	89 c7                	mov    %eax,%edi
80105089:	0f 84 8e 00 00 00    	je     8010511d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010508f:	83 ec 0c             	sub    $0xc,%esp
80105092:	50                   	push   %eax
80105093:	e8 c8 c5 ff ff       	call   80101660 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105098:	83 c4 10             	add    $0x10,%esp
8010509b:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
801050a0:	0f 84 d2 00 00 00    	je     80105178 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801050a6:	e8 b5 bc ff ff       	call   80100d60 <filealloc>
801050ab:	85 c0                	test   %eax,%eax
801050ad:	89 c6                	mov    %eax,%esi
801050af:	74 2b                	je     801050dc <sys_open+0xac>
801050b1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801050b8:	31 db                	xor    %ebx,%ebx
801050ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
801050c0:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
801050c4:	85 c0                	test   %eax,%eax
801050c6:	74 68                	je     80105130 <sys_open+0x100>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801050c8:	83 c3 01             	add    $0x1,%ebx
801050cb:	83 fb 10             	cmp    $0x10,%ebx
801050ce:	75 f0                	jne    801050c0 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801050d0:	83 ec 0c             	sub    $0xc,%esp
801050d3:	56                   	push   %esi
801050d4:	e8 47 bd ff ff       	call   80100e20 <fileclose>
801050d9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801050dc:	83 ec 0c             	sub    $0xc,%esp
801050df:	57                   	push   %edi
801050e0:	e8 eb c7 ff ff       	call   801018d0 <iunlockput>
    end_op();
801050e5:	e8 46 db ff ff       	call   80102c30 <end_op>
    return -1;
801050ea:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801050ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801050f5:	5b                   	pop    %ebx
801050f6:	5e                   	pop    %esi
801050f7:	5f                   	pop    %edi
801050f8:	5d                   	pop    %ebp
801050f9:	c3                   	ret    
801050fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105100:	83 ec 0c             	sub    $0xc,%esp
80105103:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105106:	31 c9                	xor    %ecx,%ecx
80105108:	6a 00                	push   $0x0
8010510a:	ba 02 00 00 00       	mov    $0x2,%edx
8010510f:	e8 ec f7 ff ff       	call   80104900 <create>
    if(ip == 0){
80105114:	83 c4 10             	add    $0x10,%esp
80105117:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105119:	89 c7                	mov    %eax,%edi
    if(ip == 0){
8010511b:	75 89                	jne    801050a6 <sys_open+0x76>
      end_op();
8010511d:	e8 0e db ff ff       	call   80102c30 <end_op>
      return -1;
80105122:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105127:	eb 43                	jmp    8010516c <sys_open+0x13c>
80105129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105130:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105133:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105137:	57                   	push   %edi
80105138:	e8 03 c6 ff ff       	call   80101740 <iunlock>
  end_op();
8010513d:	e8 ee da ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
80105142:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105148:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010514b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010514e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80105151:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105158:	89 d0                	mov    %edx,%eax
8010515a:	83 e0 01             	and    $0x1,%eax
8010515d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105160:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105163:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105166:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
8010516a:	89 d8                	mov    %ebx,%eax
}
8010516c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010516f:	5b                   	pop    %ebx
80105170:	5e                   	pop    %esi
80105171:	5f                   	pop    %edi
80105172:	5d                   	pop    %ebp
80105173:	c3                   	ret    
80105174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105178:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010517b:	85 d2                	test   %edx,%edx
8010517d:	0f 84 23 ff ff ff    	je     801050a6 <sys_open+0x76>
80105183:	e9 54 ff ff ff       	jmp    801050dc <sys_open+0xac>
80105188:	90                   	nop
80105189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105190 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105196:	e8 25 da ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010519b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010519e:	83 ec 08             	sub    $0x8,%esp
801051a1:	50                   	push   %eax
801051a2:	6a 00                	push   $0x0
801051a4:	e8 67 f6 ff ff       	call   80104810 <argstr>
801051a9:	83 c4 10             	add    $0x10,%esp
801051ac:	85 c0                	test   %eax,%eax
801051ae:	78 30                	js     801051e0 <sys_mkdir+0x50>
801051b0:	83 ec 0c             	sub    $0xc,%esp
801051b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051b6:	31 c9                	xor    %ecx,%ecx
801051b8:	6a 00                	push   $0x0
801051ba:	ba 01 00 00 00       	mov    $0x1,%edx
801051bf:	e8 3c f7 ff ff       	call   80104900 <create>
801051c4:	83 c4 10             	add    $0x10,%esp
801051c7:	85 c0                	test   %eax,%eax
801051c9:	74 15                	je     801051e0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801051cb:	83 ec 0c             	sub    $0xc,%esp
801051ce:	50                   	push   %eax
801051cf:	e8 fc c6 ff ff       	call   801018d0 <iunlockput>
  end_op();
801051d4:	e8 57 da ff ff       	call   80102c30 <end_op>
  return 0;
801051d9:	83 c4 10             	add    $0x10,%esp
801051dc:	31 c0                	xor    %eax,%eax
}
801051de:	c9                   	leave  
801051df:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801051e0:	e8 4b da ff ff       	call   80102c30 <end_op>
    return -1;
801051e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801051ea:	c9                   	leave  
801051eb:	c3                   	ret    
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051f0 <sys_mknod>:

int
sys_mknod(void)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801051f6:	e8 c5 d9 ff ff       	call   80102bc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801051fb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801051fe:	83 ec 08             	sub    $0x8,%esp
80105201:	50                   	push   %eax
80105202:	6a 00                	push   $0x0
80105204:	e8 07 f6 ff ff       	call   80104810 <argstr>
80105209:	83 c4 10             	add    $0x10,%esp
8010520c:	85 c0                	test   %eax,%eax
8010520e:	78 60                	js     80105270 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105210:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105213:	83 ec 08             	sub    $0x8,%esp
80105216:	50                   	push   %eax
80105217:	6a 01                	push   $0x1
80105219:	e8 62 f5 ff ff       	call   80104780 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010521e:	83 c4 10             	add    $0x10,%esp
80105221:	85 c0                	test   %eax,%eax
80105223:	78 4b                	js     80105270 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105225:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105228:	83 ec 08             	sub    $0x8,%esp
8010522b:	50                   	push   %eax
8010522c:	6a 02                	push   $0x2
8010522e:	e8 4d f5 ff ff       	call   80104780 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105233:	83 c4 10             	add    $0x10,%esp
80105236:	85 c0                	test   %eax,%eax
80105238:	78 36                	js     80105270 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010523a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010523e:	83 ec 0c             	sub    $0xc,%esp
80105241:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105245:	ba 03 00 00 00       	mov    $0x3,%edx
8010524a:	50                   	push   %eax
8010524b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010524e:	e8 ad f6 ff ff       	call   80104900 <create>
80105253:	83 c4 10             	add    $0x10,%esp
80105256:	85 c0                	test   %eax,%eax
80105258:	74 16                	je     80105270 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010525a:	83 ec 0c             	sub    $0xc,%esp
8010525d:	50                   	push   %eax
8010525e:	e8 6d c6 ff ff       	call   801018d0 <iunlockput>
  end_op();
80105263:	e8 c8 d9 ff ff       	call   80102c30 <end_op>
  return 0;
80105268:	83 c4 10             	add    $0x10,%esp
8010526b:	31 c0                	xor    %eax,%eax
}
8010526d:	c9                   	leave  
8010526e:	c3                   	ret    
8010526f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105270:	e8 bb d9 ff ff       	call   80102c30 <end_op>
    return -1;
80105275:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010527a:	c9                   	leave  
8010527b:	c3                   	ret    
8010527c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105280 <sys_chdir>:

int
sys_chdir(void)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	53                   	push   %ebx
80105284:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105287:	e8 34 d9 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010528c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010528f:	83 ec 08             	sub    $0x8,%esp
80105292:	50                   	push   %eax
80105293:	6a 00                	push   $0x0
80105295:	e8 76 f5 ff ff       	call   80104810 <argstr>
8010529a:	83 c4 10             	add    $0x10,%esp
8010529d:	85 c0                	test   %eax,%eax
8010529f:	78 7f                	js     80105320 <sys_chdir+0xa0>
801052a1:	83 ec 0c             	sub    $0xc,%esp
801052a4:	ff 75 f4             	pushl  -0xc(%ebp)
801052a7:	e8 e4 cb ff ff       	call   80101e90 <namei>
801052ac:	83 c4 10             	add    $0x10,%esp
801052af:	85 c0                	test   %eax,%eax
801052b1:	89 c3                	mov    %eax,%ebx
801052b3:	74 6b                	je     80105320 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801052b5:	83 ec 0c             	sub    $0xc,%esp
801052b8:	50                   	push   %eax
801052b9:	e8 a2 c3 ff ff       	call   80101660 <ilock>
  if(ip->type != T_DIR){
801052be:	83 c4 10             	add    $0x10,%esp
801052c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052c6:	75 38                	jne    80105300 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052c8:	83 ec 0c             	sub    $0xc,%esp
801052cb:	53                   	push   %ebx
801052cc:	e8 6f c4 ff ff       	call   80101740 <iunlock>
  iput(proc->cwd);
801052d1:	58                   	pop    %eax
801052d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052d8:	ff 70 68             	pushl  0x68(%eax)
801052db:	e8 b0 c4 ff ff       	call   80101790 <iput>
  end_op();
801052e0:	e8 4b d9 ff ff       	call   80102c30 <end_op>
  proc->cwd = ip;
801052e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
801052eb:	83 c4 10             	add    $0x10,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
801052ee:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
801052f1:	31 c0                	xor    %eax,%eax
}
801052f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801052f6:	c9                   	leave  
801052f7:	c3                   	ret    
801052f8:	90                   	nop
801052f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105300:	83 ec 0c             	sub    $0xc,%esp
80105303:	53                   	push   %ebx
80105304:	e8 c7 c5 ff ff       	call   801018d0 <iunlockput>
    end_op();
80105309:	e8 22 d9 ff ff       	call   80102c30 <end_op>
    return -1;
8010530e:	83 c4 10             	add    $0x10,%esp
80105311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105316:	eb db                	jmp    801052f3 <sys_chdir+0x73>
80105318:	90                   	nop
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105320:	e8 0b d9 ff ff       	call   80102c30 <end_op>
    return -1;
80105325:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010532a:	eb c7                	jmp    801052f3 <sys_chdir+0x73>
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105330 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	57                   	push   %edi
80105334:	56                   	push   %esi
80105335:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105336:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010533c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105342:	50                   	push   %eax
80105343:	6a 00                	push   $0x0
80105345:	e8 c6 f4 ff ff       	call   80104810 <argstr>
8010534a:	83 c4 10             	add    $0x10,%esp
8010534d:	85 c0                	test   %eax,%eax
8010534f:	78 7f                	js     801053d0 <sys_exec+0xa0>
80105351:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105357:	83 ec 08             	sub    $0x8,%esp
8010535a:	50                   	push   %eax
8010535b:	6a 01                	push   $0x1
8010535d:	e8 1e f4 ff ff       	call   80104780 <argint>
80105362:	83 c4 10             	add    $0x10,%esp
80105365:	85 c0                	test   %eax,%eax
80105367:	78 67                	js     801053d0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105369:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010536f:	83 ec 04             	sub    $0x4,%esp
80105372:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105378:	68 80 00 00 00       	push   $0x80
8010537d:	6a 00                	push   $0x0
8010537f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105385:	50                   	push   %eax
80105386:	31 db                	xor    %ebx,%ebx
80105388:	e8 03 f1 ff ff       	call   80104490 <memset>
8010538d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105390:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105396:	83 ec 08             	sub    $0x8,%esp
80105399:	57                   	push   %edi
8010539a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010539d:	50                   	push   %eax
8010539e:	e8 5d f3 ff ff       	call   80104700 <fetchint>
801053a3:	83 c4 10             	add    $0x10,%esp
801053a6:	85 c0                	test   %eax,%eax
801053a8:	78 26                	js     801053d0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801053aa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801053b0:	85 c0                	test   %eax,%eax
801053b2:	74 2c                	je     801053e0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801053b4:	83 ec 08             	sub    $0x8,%esp
801053b7:	56                   	push   %esi
801053b8:	50                   	push   %eax
801053b9:	e8 72 f3 ff ff       	call   80104730 <fetchstr>
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 0b                	js     801053d0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801053c5:	83 c3 01             	add    $0x1,%ebx
801053c8:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801053cb:	83 fb 20             	cmp    $0x20,%ebx
801053ce:	75 c0                	jne    80105390 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801053d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801053d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801053d8:	5b                   	pop    %ebx
801053d9:	5e                   	pop    %esi
801053da:	5f                   	pop    %edi
801053db:	5d                   	pop    %ebp
801053dc:	c3                   	ret    
801053dd:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801053e0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801053e6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801053e9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801053f0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801053f4:	50                   	push   %eax
801053f5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801053fb:	e8 f0 b5 ff ff       	call   801009f0 <exec>
80105400:	83 c4 10             	add    $0x10,%esp
}
80105403:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105406:	5b                   	pop    %ebx
80105407:	5e                   	pop    %esi
80105408:	5f                   	pop    %edi
80105409:	5d                   	pop    %ebp
8010540a:	c3                   	ret    
8010540b:	90                   	nop
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <sys_pipe>:

int
sys_pipe(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	57                   	push   %edi
80105414:	56                   	push   %esi
80105415:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105416:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105419:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010541c:	6a 08                	push   $0x8
8010541e:	50                   	push   %eax
8010541f:	6a 00                	push   $0x0
80105421:	e8 9a f3 ff ff       	call   801047c0 <argptr>
80105426:	83 c4 10             	add    $0x10,%esp
80105429:	85 c0                	test   %eax,%eax
8010542b:	78 48                	js     80105475 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010542d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105430:	83 ec 08             	sub    $0x8,%esp
80105433:	50                   	push   %eax
80105434:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105437:	50                   	push   %eax
80105438:	e8 23 df ff ff       	call   80103360 <pipealloc>
8010543d:	83 c4 10             	add    $0x10,%esp
80105440:	85 c0                	test   %eax,%eax
80105442:	78 31                	js     80105475 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105444:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105447:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010544e:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
80105450:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80105454:	85 d2                	test   %edx,%edx
80105456:	74 28                	je     80105480 <sys_pipe+0x70>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105458:	83 c0 01             	add    $0x1,%eax
8010545b:	83 f8 10             	cmp    $0x10,%eax
8010545e:	75 f0                	jne    80105450 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105460:	83 ec 0c             	sub    $0xc,%esp
80105463:	53                   	push   %ebx
80105464:	e8 b7 b9 ff ff       	call   80100e20 <fileclose>
    fileclose(wf);
80105469:	58                   	pop    %eax
8010546a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010546d:	e8 ae b9 ff ff       	call   80100e20 <fileclose>
    return -1;
80105472:	83 c4 10             	add    $0x10,%esp
80105475:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010547a:	eb 45                	jmp    801054c1 <sys_pipe+0xb1>
8010547c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105480:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105483:	8b 7d e4             	mov    -0x1c(%ebp),%edi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105486:	31 d2                	xor    %edx,%edx
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105488:	89 5e 28             	mov    %ebx,0x28(%esi)
8010548b:	90                   	nop
8010548c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105490:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
80105495:	74 19                	je     801054b0 <sys_pipe+0xa0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105497:	83 c2 01             	add    $0x1,%edx
8010549a:	83 fa 10             	cmp    $0x10,%edx
8010549d:	75 f1                	jne    80105490 <sys_pipe+0x80>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
8010549f:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
801054a6:	eb b8                	jmp    80105460 <sys_pipe+0x50>
801054a8:	90                   	nop
801054a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801054b0:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801054b4:	8b 4d dc             	mov    -0x24(%ebp),%ecx
801054b7:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
801054b9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801054bc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801054bf:	31 c0                	xor    %eax,%eax
}
801054c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054c4:	5b                   	pop    %ebx
801054c5:	5e                   	pop    %esi
801054c6:	5f                   	pop    %edi
801054c7:	5d                   	pop    %ebp
801054c8:	c3                   	ret    
801054c9:	66 90                	xchg   %ax,%ax
801054cb:	66 90                	xchg   %ax,%ax
801054cd:	66 90                	xchg   %ax,%ax
801054cf:	90                   	nop

801054d0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801054d3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801054d4:	e9 07 e5 ff ff       	jmp    801039e0 <fork>
801054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_exit>:
}

int
sys_exit(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	83 ec 08             	sub    $0x8,%esp
  exit();
801054e6:	e8 65 e7 ff ff       	call   80103c50 <exit>
  return 0;  // not reached
}
801054eb:	31 c0                	xor    %eax,%eax
801054ed:	c9                   	leave  
801054ee:	c3                   	ret    
801054ef:	90                   	nop

801054f0 <sys_wait>:

int
sys_wait(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801054f3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801054f4:	e9 a7 e9 ff ff       	jmp    80103ea0 <wait>
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105500 <sys_kill>:
}

int
sys_kill(void)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105506:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105509:	50                   	push   %eax
8010550a:	6a 00                	push   $0x0
8010550c:	e8 6f f2 ff ff       	call   80104780 <argint>
80105511:	83 c4 10             	add    $0x10,%esp
80105514:	85 c0                	test   %eax,%eax
80105516:	78 18                	js     80105530 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105518:	83 ec 0c             	sub    $0xc,%esp
8010551b:	ff 75 f4             	pushl  -0xc(%ebp)
8010551e:	e8 bd ea ff ff       	call   80103fe0 <kill>
80105523:	83 c4 10             	add    $0x10,%esp
}
80105526:	c9                   	leave  
80105527:	c3                   	ret    
80105528:	90                   	nop
80105529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105535:	c9                   	leave  
80105536:	c3                   	ret    
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105540 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105540:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
80105546:	55                   	push   %ebp
80105547:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105549:	8b 40 10             	mov    0x10(%eax),%eax
}
8010554c:	5d                   	pop    %ebp
8010554d:	c3                   	ret    
8010554e:	66 90                	xchg   %ax,%ax

80105550 <sys_sbrk>:

int
sys_sbrk(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105554:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return proc->pid;
}

int
sys_sbrk(void)
{
80105557:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
8010555a:	50                   	push   %eax
8010555b:	6a 00                	push   $0x0
8010555d:	e8 1e f2 ff ff       	call   80104780 <argint>
80105562:	83 c4 10             	add    $0x10,%esp
80105565:	85 c0                	test   %eax,%eax
80105567:	78 27                	js     80105590 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105569:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
8010556f:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
80105572:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105574:	ff 75 f4             	pushl  -0xc(%ebp)
80105577:	e8 f4 e3 ff ff       	call   80103970 <growproc>
8010557c:	83 c4 10             	add    $0x10,%esp
8010557f:	85 c0                	test   %eax,%eax
80105581:	78 0d                	js     80105590 <sys_sbrk+0x40>
    return -1;
  return addr;
80105583:	89 d8                	mov    %ebx,%eax
}
80105585:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105588:	c9                   	leave  
80105589:	c3                   	ret    
8010558a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105590:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105595:	eb ee                	jmp    80105585 <sys_sbrk+0x35>
80105597:	89 f6                	mov    %esi,%esi
80105599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055a0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801055a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801055a7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801055aa:	50                   	push   %eax
801055ab:	6a 00                	push   $0x0
801055ad:	e8 ce f1 ff ff       	call   80104780 <argint>
801055b2:	83 c4 10             	add    $0x10,%esp
801055b5:	85 c0                	test   %eax,%eax
801055b7:	0f 88 8a 00 00 00    	js     80105647 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801055bd:	83 ec 0c             	sub    $0xc,%esp
801055c0:	68 e0 4c 11 80       	push   $0x80114ce0
801055c5:	e8 96 ec ff ff       	call   80104260 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801055ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055cd:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801055d0:	8b 1d 20 55 11 80    	mov    0x80115520,%ebx
  while(ticks - ticks0 < n){
801055d6:	85 d2                	test   %edx,%edx
801055d8:	75 27                	jne    80105601 <sys_sleep+0x61>
801055da:	eb 54                	jmp    80105630 <sys_sleep+0x90>
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801055e0:	83 ec 08             	sub    $0x8,%esp
801055e3:	68 e0 4c 11 80       	push   $0x80114ce0
801055e8:	68 20 55 11 80       	push   $0x80115520
801055ed:	e8 ee e7 ff ff       	call   80103de0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801055f2:	a1 20 55 11 80       	mov    0x80115520,%eax
801055f7:	83 c4 10             	add    $0x10,%esp
801055fa:	29 d8                	sub    %ebx,%eax
801055fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801055ff:	73 2f                	jae    80105630 <sys_sleep+0x90>
    if(proc->killed){
80105601:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105607:	8b 40 24             	mov    0x24(%eax),%eax
8010560a:	85 c0                	test   %eax,%eax
8010560c:	74 d2                	je     801055e0 <sys_sleep+0x40>
      release(&tickslock);
8010560e:	83 ec 0c             	sub    $0xc,%esp
80105611:	68 e0 4c 11 80       	push   $0x80114ce0
80105616:	e8 25 ee ff ff       	call   80104440 <release>
      return -1;
8010561b:	83 c4 10             	add    $0x10,%esp
8010561e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105623:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105626:	c9                   	leave  
80105627:	c3                   	ret    
80105628:	90                   	nop
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105630:	83 ec 0c             	sub    $0xc,%esp
80105633:	68 e0 4c 11 80       	push   $0x80114ce0
80105638:	e8 03 ee ff ff       	call   80104440 <release>
  return 0;
8010563d:	83 c4 10             	add    $0x10,%esp
80105640:	31 c0                	xor    %eax,%eax
}
80105642:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105645:	c9                   	leave  
80105646:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105647:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010564c:	eb d5                	jmp    80105623 <sys_sleep+0x83>
8010564e:	66 90                	xchg   %ax,%ax

80105650 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	53                   	push   %ebx
80105654:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105657:	68 e0 4c 11 80       	push   $0x80114ce0
8010565c:	e8 ff eb ff ff       	call   80104260 <acquire>
  xticks = ticks;
80105661:	8b 1d 20 55 11 80    	mov    0x80115520,%ebx
  release(&tickslock);
80105667:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
8010566e:	e8 cd ed ff ff       	call   80104440 <release>
  return xticks;
}
80105673:	89 d8                	mov    %ebx,%eax
80105675:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105678:	c9                   	leave  
80105679:	c3                   	ret    
8010567a:	66 90                	xchg   %ax,%ax
8010567c:	66 90                	xchg   %ax,%ax
8010567e:	66 90                	xchg   %ax,%ax

80105680 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105680:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105681:	ba 43 00 00 00       	mov    $0x43,%edx
80105686:	b8 34 00 00 00       	mov    $0x34,%eax
8010568b:	89 e5                	mov    %esp,%ebp
8010568d:	83 ec 14             	sub    $0x14,%esp
80105690:	ee                   	out    %al,(%dx)
80105691:	ba 40 00 00 00       	mov    $0x40,%edx
80105696:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
8010569b:	ee                   	out    %al,(%dx)
8010569c:	b8 2e 00 00 00       	mov    $0x2e,%eax
801056a1:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
801056a2:	6a 00                	push   $0x0
801056a4:	e8 e7 db ff ff       	call   80103290 <picenable>
}
801056a9:	83 c4 10             	add    $0x10,%esp
801056ac:	c9                   	leave  
801056ad:	c3                   	ret    

801056ae <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801056ae:	1e                   	push   %ds
  pushl %es
801056af:	06                   	push   %es
  pushl %fs
801056b0:	0f a0                	push   %fs
  pushl %gs
801056b2:	0f a8                	push   %gs
  pushal
801056b4:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
801056b5:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801056b9:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801056bb:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
801056bd:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
801056c1:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
801056c3:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
801056c5:	54                   	push   %esp
  call trap
801056c6:	e8 e5 00 00 00       	call   801057b0 <trap>
  addl $4, %esp
801056cb:	83 c4 04             	add    $0x4,%esp

801056ce <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801056ce:	61                   	popa   
  popl %gs
801056cf:	0f a9                	pop    %gs
  popl %fs
801056d1:	0f a1                	pop    %fs
  popl %es
801056d3:	07                   	pop    %es
  popl %ds
801056d4:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801056d5:	83 c4 08             	add    $0x8,%esp
  iret
801056d8:	cf                   	iret   
801056d9:	66 90                	xchg   %ax,%ax
801056db:	66 90                	xchg   %ax,%ax
801056dd:	66 90                	xchg   %ax,%ax
801056df:	90                   	nop

801056e0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801056e0:	31 c0                	xor    %eax,%eax
801056e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801056e8:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
801056ef:	b9 08 00 00 00       	mov    $0x8,%ecx
801056f4:	c6 04 c5 24 4d 11 80 	movb   $0x0,-0x7feeb2dc(,%eax,8)
801056fb:	00 
801056fc:	66 89 0c c5 22 4d 11 	mov    %cx,-0x7feeb2de(,%eax,8)
80105703:	80 
80105704:	c6 04 c5 25 4d 11 80 	movb   $0x8e,-0x7feeb2db(,%eax,8)
8010570b:	8e 
8010570c:	66 89 14 c5 20 4d 11 	mov    %dx,-0x7feeb2e0(,%eax,8)
80105713:	80 
80105714:	c1 ea 10             	shr    $0x10,%edx
80105717:	66 89 14 c5 26 4d 11 	mov    %dx,-0x7feeb2da(,%eax,8)
8010571e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010571f:	83 c0 01             	add    $0x1,%eax
80105722:	3d 00 01 00 00       	cmp    $0x100,%eax
80105727:	75 bf                	jne    801056e8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105729:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010572a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010572f:	89 e5                	mov    %esp,%ebp
80105731:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105734:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105739:	68 99 76 10 80       	push   $0x80107699
8010573e:	68 e0 4c 11 80       	push   $0x80114ce0
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105743:	66 89 15 22 4f 11 80 	mov    %dx,0x80114f22
8010574a:	c6 05 24 4f 11 80 00 	movb   $0x0,0x80114f24
80105751:	66 a3 20 4f 11 80    	mov    %ax,0x80114f20
80105757:	c1 e8 10             	shr    $0x10,%eax
8010575a:	c6 05 25 4f 11 80 ef 	movb   $0xef,0x80114f25
80105761:	66 a3 26 4f 11 80    	mov    %ax,0x80114f26

  initlock(&tickslock, "time");
80105767:	e8 d4 ea ff ff       	call   80104240 <initlock>
}
8010576c:	83 c4 10             	add    $0x10,%esp
8010576f:	c9                   	leave  
80105770:	c3                   	ret    
80105771:	eb 0d                	jmp    80105780 <idtinit>
80105773:	90                   	nop
80105774:	90                   	nop
80105775:	90                   	nop
80105776:	90                   	nop
80105777:	90                   	nop
80105778:	90                   	nop
80105779:	90                   	nop
8010577a:	90                   	nop
8010577b:	90                   	nop
8010577c:	90                   	nop
8010577d:	90                   	nop
8010577e:	90                   	nop
8010577f:	90                   	nop

80105780 <idtinit>:

void
idtinit(void)
{
80105780:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105781:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105786:	89 e5                	mov    %esp,%ebp
80105788:	83 ec 10             	sub    $0x10,%esp
8010578b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010578f:	b8 20 4d 11 80       	mov    $0x80114d20,%eax
80105794:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105798:	c1 e8 10             	shr    $0x10,%eax
8010579b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010579f:	8d 45 fa             	lea    -0x6(%ebp),%eax
801057a2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801057a5:	c9                   	leave  
801057a6:	c3                   	ret    
801057a7:	89 f6                	mov    %esi,%esi
801057a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057b0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	57                   	push   %edi
801057b4:	56                   	push   %esi
801057b5:	53                   	push   %ebx
801057b6:	83 ec 0c             	sub    $0xc,%esp
801057b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801057bc:	8b 43 30             	mov    0x30(%ebx),%eax
801057bf:	83 f8 40             	cmp    $0x40,%eax
801057c2:	0f 84 f8 00 00 00    	je     801058c0 <trap+0x110>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801057c8:	83 e8 20             	sub    $0x20,%eax
801057cb:	83 f8 1f             	cmp    $0x1f,%eax
801057ce:	77 68                	ja     80105838 <trap+0x88>
801057d0:	ff 24 85 40 77 10 80 	jmp    *-0x7fef88c0(,%eax,4)
801057d7:	89 f6                	mov    %esi,%esi
801057d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
801057e0:	e8 fb ce ff ff       	call   801026e0 <cpunum>
801057e5:	85 c0                	test   %eax,%eax
801057e7:	0f 84 b3 01 00 00    	je     801059a0 <trap+0x1f0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
801057ed:	e8 8e cf ff ff       	call   80102780 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801057f2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057f8:	85 c0                	test   %eax,%eax
801057fa:	74 2d                	je     80105829 <trap+0x79>
801057fc:	8b 50 24             	mov    0x24(%eax),%edx
801057ff:	85 d2                	test   %edx,%edx
80105801:	0f 85 86 00 00 00    	jne    8010588d <trap+0xdd>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105807:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010580b:	0f 84 ef 00 00 00    	je     80105900 <trap+0x150>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105811:	8b 40 24             	mov    0x24(%eax),%eax
80105814:	85 c0                	test   %eax,%eax
80105816:	74 11                	je     80105829 <trap+0x79>
80105818:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010581c:	83 e0 03             	and    $0x3,%eax
8010581f:	66 83 f8 03          	cmp    $0x3,%ax
80105823:	0f 84 c1 00 00 00    	je     801058ea <trap+0x13a>
    exit();
}
80105829:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010582c:	5b                   	pop    %ebx
8010582d:	5e                   	pop    %esi
8010582e:	5f                   	pop    %edi
8010582f:	5d                   	pop    %ebp
80105830:	c3                   	ret    
80105831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80105838:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
8010583f:	85 c9                	test   %ecx,%ecx
80105841:	0f 84 8d 01 00 00    	je     801059d4 <trap+0x224>
80105847:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010584b:	0f 84 83 01 00 00    	je     801059d4 <trap+0x224>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105851:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105854:	8b 73 38             	mov    0x38(%ebx),%esi
80105857:	e8 84 ce ff ff       	call   801026e0 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
8010585c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
80105865:	50                   	push   %eax
80105866:	ff 73 34             	pushl  0x34(%ebx)
80105869:	ff 73 30             	pushl  0x30(%ebx)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
8010586c:	8d 42 6c             	lea    0x6c(%edx),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010586f:	50                   	push   %eax
80105870:	ff 72 10             	pushl  0x10(%edx)
80105873:	68 fc 76 10 80       	push   $0x801076fc
80105878:	e8 e3 ad ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
8010587d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105883:	83 c4 20             	add    $0x20,%esp
80105886:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010588d:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105891:	83 e2 03             	and    $0x3,%edx
80105894:	66 83 fa 03          	cmp    $0x3,%dx
80105898:	0f 85 69 ff ff ff    	jne    80105807 <trap+0x57>
    exit();
8010589e:	e8 ad e3 ff ff       	call   80103c50 <exit>
801058a3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
801058a9:	85 c0                	test   %eax,%eax
801058ab:	0f 85 56 ff ff ff    	jne    80105807 <trap+0x57>
801058b1:	e9 73 ff ff ff       	jmp    80105829 <trap+0x79>
801058b6:	8d 76 00             	lea    0x0(%esi),%esi
801058b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
801058c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058c6:	8b 70 24             	mov    0x24(%eax),%esi
801058c9:	85 f6                	test   %esi,%esi
801058cb:	0f 85 bf 00 00 00    	jne    80105990 <trap+0x1e0>
      exit();
    proc->tf = tf;
801058d1:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801058d4:	e8 b7 ef ff ff       	call   80104890 <syscall>
    if(proc->killed)
801058d9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801058df:	8b 58 24             	mov    0x24(%eax),%ebx
801058e2:	85 db                	test   %ebx,%ebx
801058e4:	0f 84 3f ff ff ff    	je     80105829 <trap+0x79>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801058ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058ed:	5b                   	pop    %ebx
801058ee:	5e                   	pop    %esi
801058ef:	5f                   	pop    %edi
801058f0:	5d                   	pop    %ebp
    if(proc->killed)
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
801058f1:	e9 5a e3 ff ff       	jmp    80103c50 <exit>
801058f6:	8d 76 00             	lea    0x0(%esi),%esi
801058f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105900:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105904:	0f 85 07 ff ff ff    	jne    80105811 <trap+0x61>
    yield();
8010590a:	e8 91 e4 ff ff       	call   80103da0 <yield>
8010590f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105915:	85 c0                	test   %eax,%eax
80105917:	0f 85 f4 fe ff ff    	jne    80105811 <trap+0x61>
8010591d:	e9 07 ff ff ff       	jmp    80105829 <trap+0x79>
80105922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105928:	e8 93 cc ff ff       	call   801025c0 <kbdintr>
    lapiceoi();
8010592d:	e8 4e ce ff ff       	call   80102780 <lapiceoi>
    break;
80105932:	e9 bb fe ff ff       	jmp    801057f2 <trap+0x42>
80105937:	89 f6                	mov    %esi,%esi
80105939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105940:	e8 2b 02 00 00       	call   80105b70 <uartintr>
80105945:	e9 a3 fe ff ff       	jmp    801057ed <trap+0x3d>
8010594a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105950:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105954:	8b 7b 38             	mov    0x38(%ebx),%edi
80105957:	e8 84 cd ff ff       	call   801026e0 <cpunum>
8010595c:	57                   	push   %edi
8010595d:	56                   	push   %esi
8010595e:	50                   	push   %eax
8010595f:	68 a4 76 10 80       	push   $0x801076a4
80105964:	e8 f7 ac ff ff       	call   80100660 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80105969:	e8 12 ce ff ff       	call   80102780 <lapiceoi>
    break;
8010596e:	83 c4 10             	add    $0x10,%esp
80105971:	e9 7c fe ff ff       	jmp    801057f2 <trap+0x42>
80105976:	8d 76 00             	lea    0x0(%esi),%esi
80105979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105980:	e8 ab c6 ff ff       	call   80102030 <ideintr>
    lapiceoi();
80105985:	e8 f6 cd ff ff       	call   80102780 <lapiceoi>
    break;
8010598a:	e9 63 fe ff ff       	jmp    801057f2 <trap+0x42>
8010598f:	90                   	nop
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
80105990:	e8 bb e2 ff ff       	call   80103c50 <exit>
80105995:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010599b:	e9 31 ff ff ff       	jmp    801058d1 <trap+0x121>
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
801059a0:	83 ec 0c             	sub    $0xc,%esp
801059a3:	68 e0 4c 11 80       	push   $0x80114ce0
801059a8:	e8 b3 e8 ff ff       	call   80104260 <acquire>
      ticks++;
      wakeup(&ticks);
801059ad:	c7 04 24 20 55 11 80 	movl   $0x80115520,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
      ticks++;
801059b4:	83 05 20 55 11 80 01 	addl   $0x1,0x80115520
      wakeup(&ticks);
801059bb:	e8 c0 e5 ff ff       	call   80103f80 <wakeup>
      release(&tickslock);
801059c0:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
801059c7:	e8 74 ea ff ff       	call   80104440 <release>
801059cc:	83 c4 10             	add    $0x10,%esp
801059cf:	e9 19 fe ff ff       	jmp    801057ed <trap+0x3d>
801059d4:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801059d7:	8b 73 38             	mov    0x38(%ebx),%esi
801059da:	e8 01 cd ff ff       	call   801026e0 <cpunum>
801059df:	83 ec 0c             	sub    $0xc,%esp
801059e2:	57                   	push   %edi
801059e3:	56                   	push   %esi
801059e4:	50                   	push   %eax
801059e5:	ff 73 30             	pushl  0x30(%ebx)
801059e8:	68 c8 76 10 80       	push   $0x801076c8
801059ed:	e8 6e ac ff ff       	call   80100660 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
801059f2:	83 c4 14             	add    $0x14,%esp
801059f5:	68 9e 76 10 80       	push   $0x8010769e
801059fa:	e8 71 a9 ff ff       	call   80100370 <panic>
801059ff:	90                   	nop

80105a00 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105a00:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105a05:	55                   	push   %ebp
80105a06:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105a08:	85 c0                	test   %eax,%eax
80105a0a:	74 1c                	je     80105a28 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105a0c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105a11:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105a12:	a8 01                	test   $0x1,%al
80105a14:	74 12                	je     80105a28 <uartgetc+0x28>
80105a16:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a1b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105a1c:	0f b6 c0             	movzbl %al,%eax
}
80105a1f:	5d                   	pop    %ebp
80105a20:	c3                   	ret    
80105a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105a28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105a2d:	5d                   	pop    %ebp
80105a2e:	c3                   	ret    
80105a2f:	90                   	nop

80105a30 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	57                   	push   %edi
80105a34:	56                   	push   %esi
80105a35:	53                   	push   %ebx
80105a36:	89 c7                	mov    %eax,%edi
80105a38:	bb 80 00 00 00       	mov    $0x80,%ebx
80105a3d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105a42:	83 ec 0c             	sub    $0xc,%esp
80105a45:	eb 1b                	jmp    80105a62 <uartputc.part.0+0x32>
80105a47:	89 f6                	mov    %esi,%esi
80105a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105a50:	83 ec 0c             	sub    $0xc,%esp
80105a53:	6a 0a                	push   $0xa
80105a55:	e8 46 cd ff ff       	call   801027a0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105a5a:	83 c4 10             	add    $0x10,%esp
80105a5d:	83 eb 01             	sub    $0x1,%ebx
80105a60:	74 07                	je     80105a69 <uartputc.part.0+0x39>
80105a62:	89 f2                	mov    %esi,%edx
80105a64:	ec                   	in     (%dx),%al
80105a65:	a8 20                	test   $0x20,%al
80105a67:	74 e7                	je     80105a50 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a69:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a6e:	89 f8                	mov    %edi,%eax
80105a70:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105a71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a74:	5b                   	pop    %ebx
80105a75:	5e                   	pop    %esi
80105a76:	5f                   	pop    %edi
80105a77:	5d                   	pop    %ebp
80105a78:	c3                   	ret    
80105a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a80 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105a80:	55                   	push   %ebp
80105a81:	31 c9                	xor    %ecx,%ecx
80105a83:	89 c8                	mov    %ecx,%eax
80105a85:	89 e5                	mov    %esp,%ebp
80105a87:	57                   	push   %edi
80105a88:	56                   	push   %esi
80105a89:	53                   	push   %ebx
80105a8a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105a8f:	89 da                	mov    %ebx,%edx
80105a91:	83 ec 0c             	sub    $0xc,%esp
80105a94:	ee                   	out    %al,(%dx)
80105a95:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105a9a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105a9f:	89 fa                	mov    %edi,%edx
80105aa1:	ee                   	out    %al,(%dx)
80105aa2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105aa7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105aac:	ee                   	out    %al,(%dx)
80105aad:	be f9 03 00 00       	mov    $0x3f9,%esi
80105ab2:	89 c8                	mov    %ecx,%eax
80105ab4:	89 f2                	mov    %esi,%edx
80105ab6:	ee                   	out    %al,(%dx)
80105ab7:	b8 03 00 00 00       	mov    $0x3,%eax
80105abc:	89 fa                	mov    %edi,%edx
80105abe:	ee                   	out    %al,(%dx)
80105abf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105ac4:	89 c8                	mov    %ecx,%eax
80105ac6:	ee                   	out    %al,(%dx)
80105ac7:	b8 01 00 00 00       	mov    $0x1,%eax
80105acc:	89 f2                	mov    %esi,%edx
80105ace:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105acf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ad4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105ad5:	3c ff                	cmp    $0xff,%al
80105ad7:	74 5a                	je     80105b33 <uartinit+0xb3>
    return;
  uart = 1;
80105ad9:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105ae0:	00 00 00 
80105ae3:	89 da                	mov    %ebx,%edx
80105ae5:	ec                   	in     (%dx),%al
80105ae6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105aeb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105aec:	83 ec 0c             	sub    $0xc,%esp
80105aef:	6a 04                	push   $0x4
80105af1:	e8 9a d7 ff ff       	call   80103290 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105af6:	59                   	pop    %ecx
80105af7:	5b                   	pop    %ebx
80105af8:	6a 00                	push   $0x0
80105afa:	6a 04                	push   $0x4
80105afc:	bb c0 77 10 80       	mov    $0x801077c0,%ebx
80105b01:	e8 8a c7 ff ff       	call   80102290 <ioapicenable>
80105b06:	83 c4 10             	add    $0x10,%esp
80105b09:	b8 78 00 00 00       	mov    $0x78,%eax
80105b0e:	eb 0a                	jmp    80105b1a <uartinit+0x9a>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105b10:	83 c3 01             	add    $0x1,%ebx
80105b13:	0f be 03             	movsbl (%ebx),%eax
80105b16:	84 c0                	test   %al,%al
80105b18:	74 19                	je     80105b33 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105b1a:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
80105b20:	85 d2                	test   %edx,%edx
80105b22:	74 ec                	je     80105b10 <uartinit+0x90>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105b24:	83 c3 01             	add    $0x1,%ebx
80105b27:	e8 04 ff ff ff       	call   80105a30 <uartputc.part.0>
80105b2c:	0f be 03             	movsbl (%ebx),%eax
80105b2f:	84 c0                	test   %al,%al
80105b31:	75 e7                	jne    80105b1a <uartinit+0x9a>
    uartputc(*p);
}
80105b33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b36:	5b                   	pop    %ebx
80105b37:	5e                   	pop    %esi
80105b38:	5f                   	pop    %edi
80105b39:	5d                   	pop    %ebp
80105b3a:	c3                   	ret    
80105b3b:	90                   	nop
80105b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b40 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105b40:	8b 15 c0 a5 10 80    	mov    0x8010a5c0,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105b46:	55                   	push   %ebp
80105b47:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105b49:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105b4e:	74 10                	je     80105b60 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105b50:	5d                   	pop    %ebp
80105b51:	e9 da fe ff ff       	jmp    80105a30 <uartputc.part.0>
80105b56:	8d 76 00             	lea    0x0(%esi),%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105b60:	5d                   	pop    %ebp
80105b61:	c3                   	ret    
80105b62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b70 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105b76:	68 00 5a 10 80       	push   $0x80105a00
80105b7b:	e8 70 ac ff ff       	call   801007f0 <consoleintr>
}
80105b80:	83 c4 10             	add    $0x10,%esp
80105b83:	c9                   	leave  
80105b84:	c3                   	ret    

80105b85 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105b85:	6a 00                	push   $0x0
  pushl $0
80105b87:	6a 00                	push   $0x0
  jmp alltraps
80105b89:	e9 20 fb ff ff       	jmp    801056ae <alltraps>

80105b8e <vector1>:
.globl vector1
vector1:
  pushl $0
80105b8e:	6a 00                	push   $0x0
  pushl $1
80105b90:	6a 01                	push   $0x1
  jmp alltraps
80105b92:	e9 17 fb ff ff       	jmp    801056ae <alltraps>

80105b97 <vector2>:
.globl vector2
vector2:
  pushl $0
80105b97:	6a 00                	push   $0x0
  pushl $2
80105b99:	6a 02                	push   $0x2
  jmp alltraps
80105b9b:	e9 0e fb ff ff       	jmp    801056ae <alltraps>

80105ba0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105ba0:	6a 00                	push   $0x0
  pushl $3
80105ba2:	6a 03                	push   $0x3
  jmp alltraps
80105ba4:	e9 05 fb ff ff       	jmp    801056ae <alltraps>

80105ba9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105ba9:	6a 00                	push   $0x0
  pushl $4
80105bab:	6a 04                	push   $0x4
  jmp alltraps
80105bad:	e9 fc fa ff ff       	jmp    801056ae <alltraps>

80105bb2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105bb2:	6a 00                	push   $0x0
  pushl $5
80105bb4:	6a 05                	push   $0x5
  jmp alltraps
80105bb6:	e9 f3 fa ff ff       	jmp    801056ae <alltraps>

80105bbb <vector6>:
.globl vector6
vector6:
  pushl $0
80105bbb:	6a 00                	push   $0x0
  pushl $6
80105bbd:	6a 06                	push   $0x6
  jmp alltraps
80105bbf:	e9 ea fa ff ff       	jmp    801056ae <alltraps>

80105bc4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105bc4:	6a 00                	push   $0x0
  pushl $7
80105bc6:	6a 07                	push   $0x7
  jmp alltraps
80105bc8:	e9 e1 fa ff ff       	jmp    801056ae <alltraps>

80105bcd <vector8>:
.globl vector8
vector8:
  pushl $8
80105bcd:	6a 08                	push   $0x8
  jmp alltraps
80105bcf:	e9 da fa ff ff       	jmp    801056ae <alltraps>

80105bd4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105bd4:	6a 00                	push   $0x0
  pushl $9
80105bd6:	6a 09                	push   $0x9
  jmp alltraps
80105bd8:	e9 d1 fa ff ff       	jmp    801056ae <alltraps>

80105bdd <vector10>:
.globl vector10
vector10:
  pushl $10
80105bdd:	6a 0a                	push   $0xa
  jmp alltraps
80105bdf:	e9 ca fa ff ff       	jmp    801056ae <alltraps>

80105be4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105be4:	6a 0b                	push   $0xb
  jmp alltraps
80105be6:	e9 c3 fa ff ff       	jmp    801056ae <alltraps>

80105beb <vector12>:
.globl vector12
vector12:
  pushl $12
80105beb:	6a 0c                	push   $0xc
  jmp alltraps
80105bed:	e9 bc fa ff ff       	jmp    801056ae <alltraps>

80105bf2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105bf2:	6a 0d                	push   $0xd
  jmp alltraps
80105bf4:	e9 b5 fa ff ff       	jmp    801056ae <alltraps>

80105bf9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105bf9:	6a 0e                	push   $0xe
  jmp alltraps
80105bfb:	e9 ae fa ff ff       	jmp    801056ae <alltraps>

80105c00 <vector15>:
.globl vector15
vector15:
  pushl $0
80105c00:	6a 00                	push   $0x0
  pushl $15
80105c02:	6a 0f                	push   $0xf
  jmp alltraps
80105c04:	e9 a5 fa ff ff       	jmp    801056ae <alltraps>

80105c09 <vector16>:
.globl vector16
vector16:
  pushl $0
80105c09:	6a 00                	push   $0x0
  pushl $16
80105c0b:	6a 10                	push   $0x10
  jmp alltraps
80105c0d:	e9 9c fa ff ff       	jmp    801056ae <alltraps>

80105c12 <vector17>:
.globl vector17
vector17:
  pushl $17
80105c12:	6a 11                	push   $0x11
  jmp alltraps
80105c14:	e9 95 fa ff ff       	jmp    801056ae <alltraps>

80105c19 <vector18>:
.globl vector18
vector18:
  pushl $0
80105c19:	6a 00                	push   $0x0
  pushl $18
80105c1b:	6a 12                	push   $0x12
  jmp alltraps
80105c1d:	e9 8c fa ff ff       	jmp    801056ae <alltraps>

80105c22 <vector19>:
.globl vector19
vector19:
  pushl $0
80105c22:	6a 00                	push   $0x0
  pushl $19
80105c24:	6a 13                	push   $0x13
  jmp alltraps
80105c26:	e9 83 fa ff ff       	jmp    801056ae <alltraps>

80105c2b <vector20>:
.globl vector20
vector20:
  pushl $0
80105c2b:	6a 00                	push   $0x0
  pushl $20
80105c2d:	6a 14                	push   $0x14
  jmp alltraps
80105c2f:	e9 7a fa ff ff       	jmp    801056ae <alltraps>

80105c34 <vector21>:
.globl vector21
vector21:
  pushl $0
80105c34:	6a 00                	push   $0x0
  pushl $21
80105c36:	6a 15                	push   $0x15
  jmp alltraps
80105c38:	e9 71 fa ff ff       	jmp    801056ae <alltraps>

80105c3d <vector22>:
.globl vector22
vector22:
  pushl $0
80105c3d:	6a 00                	push   $0x0
  pushl $22
80105c3f:	6a 16                	push   $0x16
  jmp alltraps
80105c41:	e9 68 fa ff ff       	jmp    801056ae <alltraps>

80105c46 <vector23>:
.globl vector23
vector23:
  pushl $0
80105c46:	6a 00                	push   $0x0
  pushl $23
80105c48:	6a 17                	push   $0x17
  jmp alltraps
80105c4a:	e9 5f fa ff ff       	jmp    801056ae <alltraps>

80105c4f <vector24>:
.globl vector24
vector24:
  pushl $0
80105c4f:	6a 00                	push   $0x0
  pushl $24
80105c51:	6a 18                	push   $0x18
  jmp alltraps
80105c53:	e9 56 fa ff ff       	jmp    801056ae <alltraps>

80105c58 <vector25>:
.globl vector25
vector25:
  pushl $0
80105c58:	6a 00                	push   $0x0
  pushl $25
80105c5a:	6a 19                	push   $0x19
  jmp alltraps
80105c5c:	e9 4d fa ff ff       	jmp    801056ae <alltraps>

80105c61 <vector26>:
.globl vector26
vector26:
  pushl $0
80105c61:	6a 00                	push   $0x0
  pushl $26
80105c63:	6a 1a                	push   $0x1a
  jmp alltraps
80105c65:	e9 44 fa ff ff       	jmp    801056ae <alltraps>

80105c6a <vector27>:
.globl vector27
vector27:
  pushl $0
80105c6a:	6a 00                	push   $0x0
  pushl $27
80105c6c:	6a 1b                	push   $0x1b
  jmp alltraps
80105c6e:	e9 3b fa ff ff       	jmp    801056ae <alltraps>

80105c73 <vector28>:
.globl vector28
vector28:
  pushl $0
80105c73:	6a 00                	push   $0x0
  pushl $28
80105c75:	6a 1c                	push   $0x1c
  jmp alltraps
80105c77:	e9 32 fa ff ff       	jmp    801056ae <alltraps>

80105c7c <vector29>:
.globl vector29
vector29:
  pushl $0
80105c7c:	6a 00                	push   $0x0
  pushl $29
80105c7e:	6a 1d                	push   $0x1d
  jmp alltraps
80105c80:	e9 29 fa ff ff       	jmp    801056ae <alltraps>

80105c85 <vector30>:
.globl vector30
vector30:
  pushl $0
80105c85:	6a 00                	push   $0x0
  pushl $30
80105c87:	6a 1e                	push   $0x1e
  jmp alltraps
80105c89:	e9 20 fa ff ff       	jmp    801056ae <alltraps>

80105c8e <vector31>:
.globl vector31
vector31:
  pushl $0
80105c8e:	6a 00                	push   $0x0
  pushl $31
80105c90:	6a 1f                	push   $0x1f
  jmp alltraps
80105c92:	e9 17 fa ff ff       	jmp    801056ae <alltraps>

80105c97 <vector32>:
.globl vector32
vector32:
  pushl $0
80105c97:	6a 00                	push   $0x0
  pushl $32
80105c99:	6a 20                	push   $0x20
  jmp alltraps
80105c9b:	e9 0e fa ff ff       	jmp    801056ae <alltraps>

80105ca0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105ca0:	6a 00                	push   $0x0
  pushl $33
80105ca2:	6a 21                	push   $0x21
  jmp alltraps
80105ca4:	e9 05 fa ff ff       	jmp    801056ae <alltraps>

80105ca9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ca9:	6a 00                	push   $0x0
  pushl $34
80105cab:	6a 22                	push   $0x22
  jmp alltraps
80105cad:	e9 fc f9 ff ff       	jmp    801056ae <alltraps>

80105cb2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105cb2:	6a 00                	push   $0x0
  pushl $35
80105cb4:	6a 23                	push   $0x23
  jmp alltraps
80105cb6:	e9 f3 f9 ff ff       	jmp    801056ae <alltraps>

80105cbb <vector36>:
.globl vector36
vector36:
  pushl $0
80105cbb:	6a 00                	push   $0x0
  pushl $36
80105cbd:	6a 24                	push   $0x24
  jmp alltraps
80105cbf:	e9 ea f9 ff ff       	jmp    801056ae <alltraps>

80105cc4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105cc4:	6a 00                	push   $0x0
  pushl $37
80105cc6:	6a 25                	push   $0x25
  jmp alltraps
80105cc8:	e9 e1 f9 ff ff       	jmp    801056ae <alltraps>

80105ccd <vector38>:
.globl vector38
vector38:
  pushl $0
80105ccd:	6a 00                	push   $0x0
  pushl $38
80105ccf:	6a 26                	push   $0x26
  jmp alltraps
80105cd1:	e9 d8 f9 ff ff       	jmp    801056ae <alltraps>

80105cd6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105cd6:	6a 00                	push   $0x0
  pushl $39
80105cd8:	6a 27                	push   $0x27
  jmp alltraps
80105cda:	e9 cf f9 ff ff       	jmp    801056ae <alltraps>

80105cdf <vector40>:
.globl vector40
vector40:
  pushl $0
80105cdf:	6a 00                	push   $0x0
  pushl $40
80105ce1:	6a 28                	push   $0x28
  jmp alltraps
80105ce3:	e9 c6 f9 ff ff       	jmp    801056ae <alltraps>

80105ce8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105ce8:	6a 00                	push   $0x0
  pushl $41
80105cea:	6a 29                	push   $0x29
  jmp alltraps
80105cec:	e9 bd f9 ff ff       	jmp    801056ae <alltraps>

80105cf1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105cf1:	6a 00                	push   $0x0
  pushl $42
80105cf3:	6a 2a                	push   $0x2a
  jmp alltraps
80105cf5:	e9 b4 f9 ff ff       	jmp    801056ae <alltraps>

80105cfa <vector43>:
.globl vector43
vector43:
  pushl $0
80105cfa:	6a 00                	push   $0x0
  pushl $43
80105cfc:	6a 2b                	push   $0x2b
  jmp alltraps
80105cfe:	e9 ab f9 ff ff       	jmp    801056ae <alltraps>

80105d03 <vector44>:
.globl vector44
vector44:
  pushl $0
80105d03:	6a 00                	push   $0x0
  pushl $44
80105d05:	6a 2c                	push   $0x2c
  jmp alltraps
80105d07:	e9 a2 f9 ff ff       	jmp    801056ae <alltraps>

80105d0c <vector45>:
.globl vector45
vector45:
  pushl $0
80105d0c:	6a 00                	push   $0x0
  pushl $45
80105d0e:	6a 2d                	push   $0x2d
  jmp alltraps
80105d10:	e9 99 f9 ff ff       	jmp    801056ae <alltraps>

80105d15 <vector46>:
.globl vector46
vector46:
  pushl $0
80105d15:	6a 00                	push   $0x0
  pushl $46
80105d17:	6a 2e                	push   $0x2e
  jmp alltraps
80105d19:	e9 90 f9 ff ff       	jmp    801056ae <alltraps>

80105d1e <vector47>:
.globl vector47
vector47:
  pushl $0
80105d1e:	6a 00                	push   $0x0
  pushl $47
80105d20:	6a 2f                	push   $0x2f
  jmp alltraps
80105d22:	e9 87 f9 ff ff       	jmp    801056ae <alltraps>

80105d27 <vector48>:
.globl vector48
vector48:
  pushl $0
80105d27:	6a 00                	push   $0x0
  pushl $48
80105d29:	6a 30                	push   $0x30
  jmp alltraps
80105d2b:	e9 7e f9 ff ff       	jmp    801056ae <alltraps>

80105d30 <vector49>:
.globl vector49
vector49:
  pushl $0
80105d30:	6a 00                	push   $0x0
  pushl $49
80105d32:	6a 31                	push   $0x31
  jmp alltraps
80105d34:	e9 75 f9 ff ff       	jmp    801056ae <alltraps>

80105d39 <vector50>:
.globl vector50
vector50:
  pushl $0
80105d39:	6a 00                	push   $0x0
  pushl $50
80105d3b:	6a 32                	push   $0x32
  jmp alltraps
80105d3d:	e9 6c f9 ff ff       	jmp    801056ae <alltraps>

80105d42 <vector51>:
.globl vector51
vector51:
  pushl $0
80105d42:	6a 00                	push   $0x0
  pushl $51
80105d44:	6a 33                	push   $0x33
  jmp alltraps
80105d46:	e9 63 f9 ff ff       	jmp    801056ae <alltraps>

80105d4b <vector52>:
.globl vector52
vector52:
  pushl $0
80105d4b:	6a 00                	push   $0x0
  pushl $52
80105d4d:	6a 34                	push   $0x34
  jmp alltraps
80105d4f:	e9 5a f9 ff ff       	jmp    801056ae <alltraps>

80105d54 <vector53>:
.globl vector53
vector53:
  pushl $0
80105d54:	6a 00                	push   $0x0
  pushl $53
80105d56:	6a 35                	push   $0x35
  jmp alltraps
80105d58:	e9 51 f9 ff ff       	jmp    801056ae <alltraps>

80105d5d <vector54>:
.globl vector54
vector54:
  pushl $0
80105d5d:	6a 00                	push   $0x0
  pushl $54
80105d5f:	6a 36                	push   $0x36
  jmp alltraps
80105d61:	e9 48 f9 ff ff       	jmp    801056ae <alltraps>

80105d66 <vector55>:
.globl vector55
vector55:
  pushl $0
80105d66:	6a 00                	push   $0x0
  pushl $55
80105d68:	6a 37                	push   $0x37
  jmp alltraps
80105d6a:	e9 3f f9 ff ff       	jmp    801056ae <alltraps>

80105d6f <vector56>:
.globl vector56
vector56:
  pushl $0
80105d6f:	6a 00                	push   $0x0
  pushl $56
80105d71:	6a 38                	push   $0x38
  jmp alltraps
80105d73:	e9 36 f9 ff ff       	jmp    801056ae <alltraps>

80105d78 <vector57>:
.globl vector57
vector57:
  pushl $0
80105d78:	6a 00                	push   $0x0
  pushl $57
80105d7a:	6a 39                	push   $0x39
  jmp alltraps
80105d7c:	e9 2d f9 ff ff       	jmp    801056ae <alltraps>

80105d81 <vector58>:
.globl vector58
vector58:
  pushl $0
80105d81:	6a 00                	push   $0x0
  pushl $58
80105d83:	6a 3a                	push   $0x3a
  jmp alltraps
80105d85:	e9 24 f9 ff ff       	jmp    801056ae <alltraps>

80105d8a <vector59>:
.globl vector59
vector59:
  pushl $0
80105d8a:	6a 00                	push   $0x0
  pushl $59
80105d8c:	6a 3b                	push   $0x3b
  jmp alltraps
80105d8e:	e9 1b f9 ff ff       	jmp    801056ae <alltraps>

80105d93 <vector60>:
.globl vector60
vector60:
  pushl $0
80105d93:	6a 00                	push   $0x0
  pushl $60
80105d95:	6a 3c                	push   $0x3c
  jmp alltraps
80105d97:	e9 12 f9 ff ff       	jmp    801056ae <alltraps>

80105d9c <vector61>:
.globl vector61
vector61:
  pushl $0
80105d9c:	6a 00                	push   $0x0
  pushl $61
80105d9e:	6a 3d                	push   $0x3d
  jmp alltraps
80105da0:	e9 09 f9 ff ff       	jmp    801056ae <alltraps>

80105da5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105da5:	6a 00                	push   $0x0
  pushl $62
80105da7:	6a 3e                	push   $0x3e
  jmp alltraps
80105da9:	e9 00 f9 ff ff       	jmp    801056ae <alltraps>

80105dae <vector63>:
.globl vector63
vector63:
  pushl $0
80105dae:	6a 00                	push   $0x0
  pushl $63
80105db0:	6a 3f                	push   $0x3f
  jmp alltraps
80105db2:	e9 f7 f8 ff ff       	jmp    801056ae <alltraps>

80105db7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105db7:	6a 00                	push   $0x0
  pushl $64
80105db9:	6a 40                	push   $0x40
  jmp alltraps
80105dbb:	e9 ee f8 ff ff       	jmp    801056ae <alltraps>

80105dc0 <vector65>:
.globl vector65
vector65:
  pushl $0
80105dc0:	6a 00                	push   $0x0
  pushl $65
80105dc2:	6a 41                	push   $0x41
  jmp alltraps
80105dc4:	e9 e5 f8 ff ff       	jmp    801056ae <alltraps>

80105dc9 <vector66>:
.globl vector66
vector66:
  pushl $0
80105dc9:	6a 00                	push   $0x0
  pushl $66
80105dcb:	6a 42                	push   $0x42
  jmp alltraps
80105dcd:	e9 dc f8 ff ff       	jmp    801056ae <alltraps>

80105dd2 <vector67>:
.globl vector67
vector67:
  pushl $0
80105dd2:	6a 00                	push   $0x0
  pushl $67
80105dd4:	6a 43                	push   $0x43
  jmp alltraps
80105dd6:	e9 d3 f8 ff ff       	jmp    801056ae <alltraps>

80105ddb <vector68>:
.globl vector68
vector68:
  pushl $0
80105ddb:	6a 00                	push   $0x0
  pushl $68
80105ddd:	6a 44                	push   $0x44
  jmp alltraps
80105ddf:	e9 ca f8 ff ff       	jmp    801056ae <alltraps>

80105de4 <vector69>:
.globl vector69
vector69:
  pushl $0
80105de4:	6a 00                	push   $0x0
  pushl $69
80105de6:	6a 45                	push   $0x45
  jmp alltraps
80105de8:	e9 c1 f8 ff ff       	jmp    801056ae <alltraps>

80105ded <vector70>:
.globl vector70
vector70:
  pushl $0
80105ded:	6a 00                	push   $0x0
  pushl $70
80105def:	6a 46                	push   $0x46
  jmp alltraps
80105df1:	e9 b8 f8 ff ff       	jmp    801056ae <alltraps>

80105df6 <vector71>:
.globl vector71
vector71:
  pushl $0
80105df6:	6a 00                	push   $0x0
  pushl $71
80105df8:	6a 47                	push   $0x47
  jmp alltraps
80105dfa:	e9 af f8 ff ff       	jmp    801056ae <alltraps>

80105dff <vector72>:
.globl vector72
vector72:
  pushl $0
80105dff:	6a 00                	push   $0x0
  pushl $72
80105e01:	6a 48                	push   $0x48
  jmp alltraps
80105e03:	e9 a6 f8 ff ff       	jmp    801056ae <alltraps>

80105e08 <vector73>:
.globl vector73
vector73:
  pushl $0
80105e08:	6a 00                	push   $0x0
  pushl $73
80105e0a:	6a 49                	push   $0x49
  jmp alltraps
80105e0c:	e9 9d f8 ff ff       	jmp    801056ae <alltraps>

80105e11 <vector74>:
.globl vector74
vector74:
  pushl $0
80105e11:	6a 00                	push   $0x0
  pushl $74
80105e13:	6a 4a                	push   $0x4a
  jmp alltraps
80105e15:	e9 94 f8 ff ff       	jmp    801056ae <alltraps>

80105e1a <vector75>:
.globl vector75
vector75:
  pushl $0
80105e1a:	6a 00                	push   $0x0
  pushl $75
80105e1c:	6a 4b                	push   $0x4b
  jmp alltraps
80105e1e:	e9 8b f8 ff ff       	jmp    801056ae <alltraps>

80105e23 <vector76>:
.globl vector76
vector76:
  pushl $0
80105e23:	6a 00                	push   $0x0
  pushl $76
80105e25:	6a 4c                	push   $0x4c
  jmp alltraps
80105e27:	e9 82 f8 ff ff       	jmp    801056ae <alltraps>

80105e2c <vector77>:
.globl vector77
vector77:
  pushl $0
80105e2c:	6a 00                	push   $0x0
  pushl $77
80105e2e:	6a 4d                	push   $0x4d
  jmp alltraps
80105e30:	e9 79 f8 ff ff       	jmp    801056ae <alltraps>

80105e35 <vector78>:
.globl vector78
vector78:
  pushl $0
80105e35:	6a 00                	push   $0x0
  pushl $78
80105e37:	6a 4e                	push   $0x4e
  jmp alltraps
80105e39:	e9 70 f8 ff ff       	jmp    801056ae <alltraps>

80105e3e <vector79>:
.globl vector79
vector79:
  pushl $0
80105e3e:	6a 00                	push   $0x0
  pushl $79
80105e40:	6a 4f                	push   $0x4f
  jmp alltraps
80105e42:	e9 67 f8 ff ff       	jmp    801056ae <alltraps>

80105e47 <vector80>:
.globl vector80
vector80:
  pushl $0
80105e47:	6a 00                	push   $0x0
  pushl $80
80105e49:	6a 50                	push   $0x50
  jmp alltraps
80105e4b:	e9 5e f8 ff ff       	jmp    801056ae <alltraps>

80105e50 <vector81>:
.globl vector81
vector81:
  pushl $0
80105e50:	6a 00                	push   $0x0
  pushl $81
80105e52:	6a 51                	push   $0x51
  jmp alltraps
80105e54:	e9 55 f8 ff ff       	jmp    801056ae <alltraps>

80105e59 <vector82>:
.globl vector82
vector82:
  pushl $0
80105e59:	6a 00                	push   $0x0
  pushl $82
80105e5b:	6a 52                	push   $0x52
  jmp alltraps
80105e5d:	e9 4c f8 ff ff       	jmp    801056ae <alltraps>

80105e62 <vector83>:
.globl vector83
vector83:
  pushl $0
80105e62:	6a 00                	push   $0x0
  pushl $83
80105e64:	6a 53                	push   $0x53
  jmp alltraps
80105e66:	e9 43 f8 ff ff       	jmp    801056ae <alltraps>

80105e6b <vector84>:
.globl vector84
vector84:
  pushl $0
80105e6b:	6a 00                	push   $0x0
  pushl $84
80105e6d:	6a 54                	push   $0x54
  jmp alltraps
80105e6f:	e9 3a f8 ff ff       	jmp    801056ae <alltraps>

80105e74 <vector85>:
.globl vector85
vector85:
  pushl $0
80105e74:	6a 00                	push   $0x0
  pushl $85
80105e76:	6a 55                	push   $0x55
  jmp alltraps
80105e78:	e9 31 f8 ff ff       	jmp    801056ae <alltraps>

80105e7d <vector86>:
.globl vector86
vector86:
  pushl $0
80105e7d:	6a 00                	push   $0x0
  pushl $86
80105e7f:	6a 56                	push   $0x56
  jmp alltraps
80105e81:	e9 28 f8 ff ff       	jmp    801056ae <alltraps>

80105e86 <vector87>:
.globl vector87
vector87:
  pushl $0
80105e86:	6a 00                	push   $0x0
  pushl $87
80105e88:	6a 57                	push   $0x57
  jmp alltraps
80105e8a:	e9 1f f8 ff ff       	jmp    801056ae <alltraps>

80105e8f <vector88>:
.globl vector88
vector88:
  pushl $0
80105e8f:	6a 00                	push   $0x0
  pushl $88
80105e91:	6a 58                	push   $0x58
  jmp alltraps
80105e93:	e9 16 f8 ff ff       	jmp    801056ae <alltraps>

80105e98 <vector89>:
.globl vector89
vector89:
  pushl $0
80105e98:	6a 00                	push   $0x0
  pushl $89
80105e9a:	6a 59                	push   $0x59
  jmp alltraps
80105e9c:	e9 0d f8 ff ff       	jmp    801056ae <alltraps>

80105ea1 <vector90>:
.globl vector90
vector90:
  pushl $0
80105ea1:	6a 00                	push   $0x0
  pushl $90
80105ea3:	6a 5a                	push   $0x5a
  jmp alltraps
80105ea5:	e9 04 f8 ff ff       	jmp    801056ae <alltraps>

80105eaa <vector91>:
.globl vector91
vector91:
  pushl $0
80105eaa:	6a 00                	push   $0x0
  pushl $91
80105eac:	6a 5b                	push   $0x5b
  jmp alltraps
80105eae:	e9 fb f7 ff ff       	jmp    801056ae <alltraps>

80105eb3 <vector92>:
.globl vector92
vector92:
  pushl $0
80105eb3:	6a 00                	push   $0x0
  pushl $92
80105eb5:	6a 5c                	push   $0x5c
  jmp alltraps
80105eb7:	e9 f2 f7 ff ff       	jmp    801056ae <alltraps>

80105ebc <vector93>:
.globl vector93
vector93:
  pushl $0
80105ebc:	6a 00                	push   $0x0
  pushl $93
80105ebe:	6a 5d                	push   $0x5d
  jmp alltraps
80105ec0:	e9 e9 f7 ff ff       	jmp    801056ae <alltraps>

80105ec5 <vector94>:
.globl vector94
vector94:
  pushl $0
80105ec5:	6a 00                	push   $0x0
  pushl $94
80105ec7:	6a 5e                	push   $0x5e
  jmp alltraps
80105ec9:	e9 e0 f7 ff ff       	jmp    801056ae <alltraps>

80105ece <vector95>:
.globl vector95
vector95:
  pushl $0
80105ece:	6a 00                	push   $0x0
  pushl $95
80105ed0:	6a 5f                	push   $0x5f
  jmp alltraps
80105ed2:	e9 d7 f7 ff ff       	jmp    801056ae <alltraps>

80105ed7 <vector96>:
.globl vector96
vector96:
  pushl $0
80105ed7:	6a 00                	push   $0x0
  pushl $96
80105ed9:	6a 60                	push   $0x60
  jmp alltraps
80105edb:	e9 ce f7 ff ff       	jmp    801056ae <alltraps>

80105ee0 <vector97>:
.globl vector97
vector97:
  pushl $0
80105ee0:	6a 00                	push   $0x0
  pushl $97
80105ee2:	6a 61                	push   $0x61
  jmp alltraps
80105ee4:	e9 c5 f7 ff ff       	jmp    801056ae <alltraps>

80105ee9 <vector98>:
.globl vector98
vector98:
  pushl $0
80105ee9:	6a 00                	push   $0x0
  pushl $98
80105eeb:	6a 62                	push   $0x62
  jmp alltraps
80105eed:	e9 bc f7 ff ff       	jmp    801056ae <alltraps>

80105ef2 <vector99>:
.globl vector99
vector99:
  pushl $0
80105ef2:	6a 00                	push   $0x0
  pushl $99
80105ef4:	6a 63                	push   $0x63
  jmp alltraps
80105ef6:	e9 b3 f7 ff ff       	jmp    801056ae <alltraps>

80105efb <vector100>:
.globl vector100
vector100:
  pushl $0
80105efb:	6a 00                	push   $0x0
  pushl $100
80105efd:	6a 64                	push   $0x64
  jmp alltraps
80105eff:	e9 aa f7 ff ff       	jmp    801056ae <alltraps>

80105f04 <vector101>:
.globl vector101
vector101:
  pushl $0
80105f04:	6a 00                	push   $0x0
  pushl $101
80105f06:	6a 65                	push   $0x65
  jmp alltraps
80105f08:	e9 a1 f7 ff ff       	jmp    801056ae <alltraps>

80105f0d <vector102>:
.globl vector102
vector102:
  pushl $0
80105f0d:	6a 00                	push   $0x0
  pushl $102
80105f0f:	6a 66                	push   $0x66
  jmp alltraps
80105f11:	e9 98 f7 ff ff       	jmp    801056ae <alltraps>

80105f16 <vector103>:
.globl vector103
vector103:
  pushl $0
80105f16:	6a 00                	push   $0x0
  pushl $103
80105f18:	6a 67                	push   $0x67
  jmp alltraps
80105f1a:	e9 8f f7 ff ff       	jmp    801056ae <alltraps>

80105f1f <vector104>:
.globl vector104
vector104:
  pushl $0
80105f1f:	6a 00                	push   $0x0
  pushl $104
80105f21:	6a 68                	push   $0x68
  jmp alltraps
80105f23:	e9 86 f7 ff ff       	jmp    801056ae <alltraps>

80105f28 <vector105>:
.globl vector105
vector105:
  pushl $0
80105f28:	6a 00                	push   $0x0
  pushl $105
80105f2a:	6a 69                	push   $0x69
  jmp alltraps
80105f2c:	e9 7d f7 ff ff       	jmp    801056ae <alltraps>

80105f31 <vector106>:
.globl vector106
vector106:
  pushl $0
80105f31:	6a 00                	push   $0x0
  pushl $106
80105f33:	6a 6a                	push   $0x6a
  jmp alltraps
80105f35:	e9 74 f7 ff ff       	jmp    801056ae <alltraps>

80105f3a <vector107>:
.globl vector107
vector107:
  pushl $0
80105f3a:	6a 00                	push   $0x0
  pushl $107
80105f3c:	6a 6b                	push   $0x6b
  jmp alltraps
80105f3e:	e9 6b f7 ff ff       	jmp    801056ae <alltraps>

80105f43 <vector108>:
.globl vector108
vector108:
  pushl $0
80105f43:	6a 00                	push   $0x0
  pushl $108
80105f45:	6a 6c                	push   $0x6c
  jmp alltraps
80105f47:	e9 62 f7 ff ff       	jmp    801056ae <alltraps>

80105f4c <vector109>:
.globl vector109
vector109:
  pushl $0
80105f4c:	6a 00                	push   $0x0
  pushl $109
80105f4e:	6a 6d                	push   $0x6d
  jmp alltraps
80105f50:	e9 59 f7 ff ff       	jmp    801056ae <alltraps>

80105f55 <vector110>:
.globl vector110
vector110:
  pushl $0
80105f55:	6a 00                	push   $0x0
  pushl $110
80105f57:	6a 6e                	push   $0x6e
  jmp alltraps
80105f59:	e9 50 f7 ff ff       	jmp    801056ae <alltraps>

80105f5e <vector111>:
.globl vector111
vector111:
  pushl $0
80105f5e:	6a 00                	push   $0x0
  pushl $111
80105f60:	6a 6f                	push   $0x6f
  jmp alltraps
80105f62:	e9 47 f7 ff ff       	jmp    801056ae <alltraps>

80105f67 <vector112>:
.globl vector112
vector112:
  pushl $0
80105f67:	6a 00                	push   $0x0
  pushl $112
80105f69:	6a 70                	push   $0x70
  jmp alltraps
80105f6b:	e9 3e f7 ff ff       	jmp    801056ae <alltraps>

80105f70 <vector113>:
.globl vector113
vector113:
  pushl $0
80105f70:	6a 00                	push   $0x0
  pushl $113
80105f72:	6a 71                	push   $0x71
  jmp alltraps
80105f74:	e9 35 f7 ff ff       	jmp    801056ae <alltraps>

80105f79 <vector114>:
.globl vector114
vector114:
  pushl $0
80105f79:	6a 00                	push   $0x0
  pushl $114
80105f7b:	6a 72                	push   $0x72
  jmp alltraps
80105f7d:	e9 2c f7 ff ff       	jmp    801056ae <alltraps>

80105f82 <vector115>:
.globl vector115
vector115:
  pushl $0
80105f82:	6a 00                	push   $0x0
  pushl $115
80105f84:	6a 73                	push   $0x73
  jmp alltraps
80105f86:	e9 23 f7 ff ff       	jmp    801056ae <alltraps>

80105f8b <vector116>:
.globl vector116
vector116:
  pushl $0
80105f8b:	6a 00                	push   $0x0
  pushl $116
80105f8d:	6a 74                	push   $0x74
  jmp alltraps
80105f8f:	e9 1a f7 ff ff       	jmp    801056ae <alltraps>

80105f94 <vector117>:
.globl vector117
vector117:
  pushl $0
80105f94:	6a 00                	push   $0x0
  pushl $117
80105f96:	6a 75                	push   $0x75
  jmp alltraps
80105f98:	e9 11 f7 ff ff       	jmp    801056ae <alltraps>

80105f9d <vector118>:
.globl vector118
vector118:
  pushl $0
80105f9d:	6a 00                	push   $0x0
  pushl $118
80105f9f:	6a 76                	push   $0x76
  jmp alltraps
80105fa1:	e9 08 f7 ff ff       	jmp    801056ae <alltraps>

80105fa6 <vector119>:
.globl vector119
vector119:
  pushl $0
80105fa6:	6a 00                	push   $0x0
  pushl $119
80105fa8:	6a 77                	push   $0x77
  jmp alltraps
80105faa:	e9 ff f6 ff ff       	jmp    801056ae <alltraps>

80105faf <vector120>:
.globl vector120
vector120:
  pushl $0
80105faf:	6a 00                	push   $0x0
  pushl $120
80105fb1:	6a 78                	push   $0x78
  jmp alltraps
80105fb3:	e9 f6 f6 ff ff       	jmp    801056ae <alltraps>

80105fb8 <vector121>:
.globl vector121
vector121:
  pushl $0
80105fb8:	6a 00                	push   $0x0
  pushl $121
80105fba:	6a 79                	push   $0x79
  jmp alltraps
80105fbc:	e9 ed f6 ff ff       	jmp    801056ae <alltraps>

80105fc1 <vector122>:
.globl vector122
vector122:
  pushl $0
80105fc1:	6a 00                	push   $0x0
  pushl $122
80105fc3:	6a 7a                	push   $0x7a
  jmp alltraps
80105fc5:	e9 e4 f6 ff ff       	jmp    801056ae <alltraps>

80105fca <vector123>:
.globl vector123
vector123:
  pushl $0
80105fca:	6a 00                	push   $0x0
  pushl $123
80105fcc:	6a 7b                	push   $0x7b
  jmp alltraps
80105fce:	e9 db f6 ff ff       	jmp    801056ae <alltraps>

80105fd3 <vector124>:
.globl vector124
vector124:
  pushl $0
80105fd3:	6a 00                	push   $0x0
  pushl $124
80105fd5:	6a 7c                	push   $0x7c
  jmp alltraps
80105fd7:	e9 d2 f6 ff ff       	jmp    801056ae <alltraps>

80105fdc <vector125>:
.globl vector125
vector125:
  pushl $0
80105fdc:	6a 00                	push   $0x0
  pushl $125
80105fde:	6a 7d                	push   $0x7d
  jmp alltraps
80105fe0:	e9 c9 f6 ff ff       	jmp    801056ae <alltraps>

80105fe5 <vector126>:
.globl vector126
vector126:
  pushl $0
80105fe5:	6a 00                	push   $0x0
  pushl $126
80105fe7:	6a 7e                	push   $0x7e
  jmp alltraps
80105fe9:	e9 c0 f6 ff ff       	jmp    801056ae <alltraps>

80105fee <vector127>:
.globl vector127
vector127:
  pushl $0
80105fee:	6a 00                	push   $0x0
  pushl $127
80105ff0:	6a 7f                	push   $0x7f
  jmp alltraps
80105ff2:	e9 b7 f6 ff ff       	jmp    801056ae <alltraps>

80105ff7 <vector128>:
.globl vector128
vector128:
  pushl $0
80105ff7:	6a 00                	push   $0x0
  pushl $128
80105ff9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105ffe:	e9 ab f6 ff ff       	jmp    801056ae <alltraps>

80106003 <vector129>:
.globl vector129
vector129:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $129
80106005:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010600a:	e9 9f f6 ff ff       	jmp    801056ae <alltraps>

8010600f <vector130>:
.globl vector130
vector130:
  pushl $0
8010600f:	6a 00                	push   $0x0
  pushl $130
80106011:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106016:	e9 93 f6 ff ff       	jmp    801056ae <alltraps>

8010601b <vector131>:
.globl vector131
vector131:
  pushl $0
8010601b:	6a 00                	push   $0x0
  pushl $131
8010601d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106022:	e9 87 f6 ff ff       	jmp    801056ae <alltraps>

80106027 <vector132>:
.globl vector132
vector132:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $132
80106029:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010602e:	e9 7b f6 ff ff       	jmp    801056ae <alltraps>

80106033 <vector133>:
.globl vector133
vector133:
  pushl $0
80106033:	6a 00                	push   $0x0
  pushl $133
80106035:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010603a:	e9 6f f6 ff ff       	jmp    801056ae <alltraps>

8010603f <vector134>:
.globl vector134
vector134:
  pushl $0
8010603f:	6a 00                	push   $0x0
  pushl $134
80106041:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106046:	e9 63 f6 ff ff       	jmp    801056ae <alltraps>

8010604b <vector135>:
.globl vector135
vector135:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $135
8010604d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106052:	e9 57 f6 ff ff       	jmp    801056ae <alltraps>

80106057 <vector136>:
.globl vector136
vector136:
  pushl $0
80106057:	6a 00                	push   $0x0
  pushl $136
80106059:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010605e:	e9 4b f6 ff ff       	jmp    801056ae <alltraps>

80106063 <vector137>:
.globl vector137
vector137:
  pushl $0
80106063:	6a 00                	push   $0x0
  pushl $137
80106065:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010606a:	e9 3f f6 ff ff       	jmp    801056ae <alltraps>

8010606f <vector138>:
.globl vector138
vector138:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $138
80106071:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106076:	e9 33 f6 ff ff       	jmp    801056ae <alltraps>

8010607b <vector139>:
.globl vector139
vector139:
  pushl $0
8010607b:	6a 00                	push   $0x0
  pushl $139
8010607d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106082:	e9 27 f6 ff ff       	jmp    801056ae <alltraps>

80106087 <vector140>:
.globl vector140
vector140:
  pushl $0
80106087:	6a 00                	push   $0x0
  pushl $140
80106089:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010608e:	e9 1b f6 ff ff       	jmp    801056ae <alltraps>

80106093 <vector141>:
.globl vector141
vector141:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $141
80106095:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010609a:	e9 0f f6 ff ff       	jmp    801056ae <alltraps>

8010609f <vector142>:
.globl vector142
vector142:
  pushl $0
8010609f:	6a 00                	push   $0x0
  pushl $142
801060a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801060a6:	e9 03 f6 ff ff       	jmp    801056ae <alltraps>

801060ab <vector143>:
.globl vector143
vector143:
  pushl $0
801060ab:	6a 00                	push   $0x0
  pushl $143
801060ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801060b2:	e9 f7 f5 ff ff       	jmp    801056ae <alltraps>

801060b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $144
801060b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801060be:	e9 eb f5 ff ff       	jmp    801056ae <alltraps>

801060c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801060c3:	6a 00                	push   $0x0
  pushl $145
801060c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801060ca:	e9 df f5 ff ff       	jmp    801056ae <alltraps>

801060cf <vector146>:
.globl vector146
vector146:
  pushl $0
801060cf:	6a 00                	push   $0x0
  pushl $146
801060d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801060d6:	e9 d3 f5 ff ff       	jmp    801056ae <alltraps>

801060db <vector147>:
.globl vector147
vector147:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $147
801060dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801060e2:	e9 c7 f5 ff ff       	jmp    801056ae <alltraps>

801060e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801060e7:	6a 00                	push   $0x0
  pushl $148
801060e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801060ee:	e9 bb f5 ff ff       	jmp    801056ae <alltraps>

801060f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801060f3:	6a 00                	push   $0x0
  pushl $149
801060f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801060fa:	e9 af f5 ff ff       	jmp    801056ae <alltraps>

801060ff <vector150>:
.globl vector150
vector150:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $150
80106101:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106106:	e9 a3 f5 ff ff       	jmp    801056ae <alltraps>

8010610b <vector151>:
.globl vector151
vector151:
  pushl $0
8010610b:	6a 00                	push   $0x0
  pushl $151
8010610d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106112:	e9 97 f5 ff ff       	jmp    801056ae <alltraps>

80106117 <vector152>:
.globl vector152
vector152:
  pushl $0
80106117:	6a 00                	push   $0x0
  pushl $152
80106119:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010611e:	e9 8b f5 ff ff       	jmp    801056ae <alltraps>

80106123 <vector153>:
.globl vector153
vector153:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $153
80106125:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010612a:	e9 7f f5 ff ff       	jmp    801056ae <alltraps>

8010612f <vector154>:
.globl vector154
vector154:
  pushl $0
8010612f:	6a 00                	push   $0x0
  pushl $154
80106131:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106136:	e9 73 f5 ff ff       	jmp    801056ae <alltraps>

8010613b <vector155>:
.globl vector155
vector155:
  pushl $0
8010613b:	6a 00                	push   $0x0
  pushl $155
8010613d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106142:	e9 67 f5 ff ff       	jmp    801056ae <alltraps>

80106147 <vector156>:
.globl vector156
vector156:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $156
80106149:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010614e:	e9 5b f5 ff ff       	jmp    801056ae <alltraps>

80106153 <vector157>:
.globl vector157
vector157:
  pushl $0
80106153:	6a 00                	push   $0x0
  pushl $157
80106155:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010615a:	e9 4f f5 ff ff       	jmp    801056ae <alltraps>

8010615f <vector158>:
.globl vector158
vector158:
  pushl $0
8010615f:	6a 00                	push   $0x0
  pushl $158
80106161:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106166:	e9 43 f5 ff ff       	jmp    801056ae <alltraps>

8010616b <vector159>:
.globl vector159
vector159:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $159
8010616d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106172:	e9 37 f5 ff ff       	jmp    801056ae <alltraps>

80106177 <vector160>:
.globl vector160
vector160:
  pushl $0
80106177:	6a 00                	push   $0x0
  pushl $160
80106179:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010617e:	e9 2b f5 ff ff       	jmp    801056ae <alltraps>

80106183 <vector161>:
.globl vector161
vector161:
  pushl $0
80106183:	6a 00                	push   $0x0
  pushl $161
80106185:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010618a:	e9 1f f5 ff ff       	jmp    801056ae <alltraps>

8010618f <vector162>:
.globl vector162
vector162:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $162
80106191:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106196:	e9 13 f5 ff ff       	jmp    801056ae <alltraps>

8010619b <vector163>:
.globl vector163
vector163:
  pushl $0
8010619b:	6a 00                	push   $0x0
  pushl $163
8010619d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801061a2:	e9 07 f5 ff ff       	jmp    801056ae <alltraps>

801061a7 <vector164>:
.globl vector164
vector164:
  pushl $0
801061a7:	6a 00                	push   $0x0
  pushl $164
801061a9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801061ae:	e9 fb f4 ff ff       	jmp    801056ae <alltraps>

801061b3 <vector165>:
.globl vector165
vector165:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $165
801061b5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801061ba:	e9 ef f4 ff ff       	jmp    801056ae <alltraps>

801061bf <vector166>:
.globl vector166
vector166:
  pushl $0
801061bf:	6a 00                	push   $0x0
  pushl $166
801061c1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801061c6:	e9 e3 f4 ff ff       	jmp    801056ae <alltraps>

801061cb <vector167>:
.globl vector167
vector167:
  pushl $0
801061cb:	6a 00                	push   $0x0
  pushl $167
801061cd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801061d2:	e9 d7 f4 ff ff       	jmp    801056ae <alltraps>

801061d7 <vector168>:
.globl vector168
vector168:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $168
801061d9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801061de:	e9 cb f4 ff ff       	jmp    801056ae <alltraps>

801061e3 <vector169>:
.globl vector169
vector169:
  pushl $0
801061e3:	6a 00                	push   $0x0
  pushl $169
801061e5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801061ea:	e9 bf f4 ff ff       	jmp    801056ae <alltraps>

801061ef <vector170>:
.globl vector170
vector170:
  pushl $0
801061ef:	6a 00                	push   $0x0
  pushl $170
801061f1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801061f6:	e9 b3 f4 ff ff       	jmp    801056ae <alltraps>

801061fb <vector171>:
.globl vector171
vector171:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $171
801061fd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106202:	e9 a7 f4 ff ff       	jmp    801056ae <alltraps>

80106207 <vector172>:
.globl vector172
vector172:
  pushl $0
80106207:	6a 00                	push   $0x0
  pushl $172
80106209:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010620e:	e9 9b f4 ff ff       	jmp    801056ae <alltraps>

80106213 <vector173>:
.globl vector173
vector173:
  pushl $0
80106213:	6a 00                	push   $0x0
  pushl $173
80106215:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010621a:	e9 8f f4 ff ff       	jmp    801056ae <alltraps>

8010621f <vector174>:
.globl vector174
vector174:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $174
80106221:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106226:	e9 83 f4 ff ff       	jmp    801056ae <alltraps>

8010622b <vector175>:
.globl vector175
vector175:
  pushl $0
8010622b:	6a 00                	push   $0x0
  pushl $175
8010622d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106232:	e9 77 f4 ff ff       	jmp    801056ae <alltraps>

80106237 <vector176>:
.globl vector176
vector176:
  pushl $0
80106237:	6a 00                	push   $0x0
  pushl $176
80106239:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010623e:	e9 6b f4 ff ff       	jmp    801056ae <alltraps>

80106243 <vector177>:
.globl vector177
vector177:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $177
80106245:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010624a:	e9 5f f4 ff ff       	jmp    801056ae <alltraps>

8010624f <vector178>:
.globl vector178
vector178:
  pushl $0
8010624f:	6a 00                	push   $0x0
  pushl $178
80106251:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106256:	e9 53 f4 ff ff       	jmp    801056ae <alltraps>

8010625b <vector179>:
.globl vector179
vector179:
  pushl $0
8010625b:	6a 00                	push   $0x0
  pushl $179
8010625d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106262:	e9 47 f4 ff ff       	jmp    801056ae <alltraps>

80106267 <vector180>:
.globl vector180
vector180:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $180
80106269:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010626e:	e9 3b f4 ff ff       	jmp    801056ae <alltraps>

80106273 <vector181>:
.globl vector181
vector181:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $181
80106275:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010627a:	e9 2f f4 ff ff       	jmp    801056ae <alltraps>

8010627f <vector182>:
.globl vector182
vector182:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $182
80106281:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106286:	e9 23 f4 ff ff       	jmp    801056ae <alltraps>

8010628b <vector183>:
.globl vector183
vector183:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $183
8010628d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106292:	e9 17 f4 ff ff       	jmp    801056ae <alltraps>

80106297 <vector184>:
.globl vector184
vector184:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $184
80106299:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010629e:	e9 0b f4 ff ff       	jmp    801056ae <alltraps>

801062a3 <vector185>:
.globl vector185
vector185:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $185
801062a5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801062aa:	e9 ff f3 ff ff       	jmp    801056ae <alltraps>

801062af <vector186>:
.globl vector186
vector186:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $186
801062b1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801062b6:	e9 f3 f3 ff ff       	jmp    801056ae <alltraps>

801062bb <vector187>:
.globl vector187
vector187:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $187
801062bd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801062c2:	e9 e7 f3 ff ff       	jmp    801056ae <alltraps>

801062c7 <vector188>:
.globl vector188
vector188:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $188
801062c9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801062ce:	e9 db f3 ff ff       	jmp    801056ae <alltraps>

801062d3 <vector189>:
.globl vector189
vector189:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $189
801062d5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801062da:	e9 cf f3 ff ff       	jmp    801056ae <alltraps>

801062df <vector190>:
.globl vector190
vector190:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $190
801062e1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801062e6:	e9 c3 f3 ff ff       	jmp    801056ae <alltraps>

801062eb <vector191>:
.globl vector191
vector191:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $191
801062ed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801062f2:	e9 b7 f3 ff ff       	jmp    801056ae <alltraps>

801062f7 <vector192>:
.globl vector192
vector192:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $192
801062f9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801062fe:	e9 ab f3 ff ff       	jmp    801056ae <alltraps>

80106303 <vector193>:
.globl vector193
vector193:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $193
80106305:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010630a:	e9 9f f3 ff ff       	jmp    801056ae <alltraps>

8010630f <vector194>:
.globl vector194
vector194:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $194
80106311:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106316:	e9 93 f3 ff ff       	jmp    801056ae <alltraps>

8010631b <vector195>:
.globl vector195
vector195:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $195
8010631d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106322:	e9 87 f3 ff ff       	jmp    801056ae <alltraps>

80106327 <vector196>:
.globl vector196
vector196:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $196
80106329:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010632e:	e9 7b f3 ff ff       	jmp    801056ae <alltraps>

80106333 <vector197>:
.globl vector197
vector197:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $197
80106335:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010633a:	e9 6f f3 ff ff       	jmp    801056ae <alltraps>

8010633f <vector198>:
.globl vector198
vector198:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $198
80106341:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106346:	e9 63 f3 ff ff       	jmp    801056ae <alltraps>

8010634b <vector199>:
.globl vector199
vector199:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $199
8010634d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106352:	e9 57 f3 ff ff       	jmp    801056ae <alltraps>

80106357 <vector200>:
.globl vector200
vector200:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $200
80106359:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010635e:	e9 4b f3 ff ff       	jmp    801056ae <alltraps>

80106363 <vector201>:
.globl vector201
vector201:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $201
80106365:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010636a:	e9 3f f3 ff ff       	jmp    801056ae <alltraps>

8010636f <vector202>:
.globl vector202
vector202:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $202
80106371:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106376:	e9 33 f3 ff ff       	jmp    801056ae <alltraps>

8010637b <vector203>:
.globl vector203
vector203:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $203
8010637d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106382:	e9 27 f3 ff ff       	jmp    801056ae <alltraps>

80106387 <vector204>:
.globl vector204
vector204:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $204
80106389:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010638e:	e9 1b f3 ff ff       	jmp    801056ae <alltraps>

80106393 <vector205>:
.globl vector205
vector205:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $205
80106395:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010639a:	e9 0f f3 ff ff       	jmp    801056ae <alltraps>

8010639f <vector206>:
.globl vector206
vector206:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $206
801063a1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801063a6:	e9 03 f3 ff ff       	jmp    801056ae <alltraps>

801063ab <vector207>:
.globl vector207
vector207:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $207
801063ad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801063b2:	e9 f7 f2 ff ff       	jmp    801056ae <alltraps>

801063b7 <vector208>:
.globl vector208
vector208:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $208
801063b9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801063be:	e9 eb f2 ff ff       	jmp    801056ae <alltraps>

801063c3 <vector209>:
.globl vector209
vector209:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $209
801063c5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801063ca:	e9 df f2 ff ff       	jmp    801056ae <alltraps>

801063cf <vector210>:
.globl vector210
vector210:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $210
801063d1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801063d6:	e9 d3 f2 ff ff       	jmp    801056ae <alltraps>

801063db <vector211>:
.globl vector211
vector211:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $211
801063dd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801063e2:	e9 c7 f2 ff ff       	jmp    801056ae <alltraps>

801063e7 <vector212>:
.globl vector212
vector212:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $212
801063e9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801063ee:	e9 bb f2 ff ff       	jmp    801056ae <alltraps>

801063f3 <vector213>:
.globl vector213
vector213:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $213
801063f5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801063fa:	e9 af f2 ff ff       	jmp    801056ae <alltraps>

801063ff <vector214>:
.globl vector214
vector214:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $214
80106401:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106406:	e9 a3 f2 ff ff       	jmp    801056ae <alltraps>

8010640b <vector215>:
.globl vector215
vector215:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $215
8010640d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106412:	e9 97 f2 ff ff       	jmp    801056ae <alltraps>

80106417 <vector216>:
.globl vector216
vector216:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $216
80106419:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010641e:	e9 8b f2 ff ff       	jmp    801056ae <alltraps>

80106423 <vector217>:
.globl vector217
vector217:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $217
80106425:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010642a:	e9 7f f2 ff ff       	jmp    801056ae <alltraps>

8010642f <vector218>:
.globl vector218
vector218:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $218
80106431:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106436:	e9 73 f2 ff ff       	jmp    801056ae <alltraps>

8010643b <vector219>:
.globl vector219
vector219:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $219
8010643d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106442:	e9 67 f2 ff ff       	jmp    801056ae <alltraps>

80106447 <vector220>:
.globl vector220
vector220:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $220
80106449:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010644e:	e9 5b f2 ff ff       	jmp    801056ae <alltraps>

80106453 <vector221>:
.globl vector221
vector221:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $221
80106455:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010645a:	e9 4f f2 ff ff       	jmp    801056ae <alltraps>

8010645f <vector222>:
.globl vector222
vector222:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $222
80106461:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106466:	e9 43 f2 ff ff       	jmp    801056ae <alltraps>

8010646b <vector223>:
.globl vector223
vector223:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $223
8010646d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106472:	e9 37 f2 ff ff       	jmp    801056ae <alltraps>

80106477 <vector224>:
.globl vector224
vector224:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $224
80106479:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010647e:	e9 2b f2 ff ff       	jmp    801056ae <alltraps>

80106483 <vector225>:
.globl vector225
vector225:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $225
80106485:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010648a:	e9 1f f2 ff ff       	jmp    801056ae <alltraps>

8010648f <vector226>:
.globl vector226
vector226:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $226
80106491:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106496:	e9 13 f2 ff ff       	jmp    801056ae <alltraps>

8010649b <vector227>:
.globl vector227
vector227:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $227
8010649d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801064a2:	e9 07 f2 ff ff       	jmp    801056ae <alltraps>

801064a7 <vector228>:
.globl vector228
vector228:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $228
801064a9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801064ae:	e9 fb f1 ff ff       	jmp    801056ae <alltraps>

801064b3 <vector229>:
.globl vector229
vector229:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $229
801064b5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801064ba:	e9 ef f1 ff ff       	jmp    801056ae <alltraps>

801064bf <vector230>:
.globl vector230
vector230:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $230
801064c1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801064c6:	e9 e3 f1 ff ff       	jmp    801056ae <alltraps>

801064cb <vector231>:
.globl vector231
vector231:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $231
801064cd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801064d2:	e9 d7 f1 ff ff       	jmp    801056ae <alltraps>

801064d7 <vector232>:
.globl vector232
vector232:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $232
801064d9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801064de:	e9 cb f1 ff ff       	jmp    801056ae <alltraps>

801064e3 <vector233>:
.globl vector233
vector233:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $233
801064e5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801064ea:	e9 bf f1 ff ff       	jmp    801056ae <alltraps>

801064ef <vector234>:
.globl vector234
vector234:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $234
801064f1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801064f6:	e9 b3 f1 ff ff       	jmp    801056ae <alltraps>

801064fb <vector235>:
.globl vector235
vector235:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $235
801064fd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106502:	e9 a7 f1 ff ff       	jmp    801056ae <alltraps>

80106507 <vector236>:
.globl vector236
vector236:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $236
80106509:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010650e:	e9 9b f1 ff ff       	jmp    801056ae <alltraps>

80106513 <vector237>:
.globl vector237
vector237:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $237
80106515:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010651a:	e9 8f f1 ff ff       	jmp    801056ae <alltraps>

8010651f <vector238>:
.globl vector238
vector238:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $238
80106521:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106526:	e9 83 f1 ff ff       	jmp    801056ae <alltraps>

8010652b <vector239>:
.globl vector239
vector239:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $239
8010652d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106532:	e9 77 f1 ff ff       	jmp    801056ae <alltraps>

80106537 <vector240>:
.globl vector240
vector240:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $240
80106539:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010653e:	e9 6b f1 ff ff       	jmp    801056ae <alltraps>

80106543 <vector241>:
.globl vector241
vector241:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $241
80106545:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010654a:	e9 5f f1 ff ff       	jmp    801056ae <alltraps>

8010654f <vector242>:
.globl vector242
vector242:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $242
80106551:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106556:	e9 53 f1 ff ff       	jmp    801056ae <alltraps>

8010655b <vector243>:
.globl vector243
vector243:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $243
8010655d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106562:	e9 47 f1 ff ff       	jmp    801056ae <alltraps>

80106567 <vector244>:
.globl vector244
vector244:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $244
80106569:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010656e:	e9 3b f1 ff ff       	jmp    801056ae <alltraps>

80106573 <vector245>:
.globl vector245
vector245:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $245
80106575:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010657a:	e9 2f f1 ff ff       	jmp    801056ae <alltraps>

8010657f <vector246>:
.globl vector246
vector246:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $246
80106581:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106586:	e9 23 f1 ff ff       	jmp    801056ae <alltraps>

8010658b <vector247>:
.globl vector247
vector247:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $247
8010658d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106592:	e9 17 f1 ff ff       	jmp    801056ae <alltraps>

80106597 <vector248>:
.globl vector248
vector248:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $248
80106599:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010659e:	e9 0b f1 ff ff       	jmp    801056ae <alltraps>

801065a3 <vector249>:
.globl vector249
vector249:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $249
801065a5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801065aa:	e9 ff f0 ff ff       	jmp    801056ae <alltraps>

801065af <vector250>:
.globl vector250
vector250:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $250
801065b1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801065b6:	e9 f3 f0 ff ff       	jmp    801056ae <alltraps>

801065bb <vector251>:
.globl vector251
vector251:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $251
801065bd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801065c2:	e9 e7 f0 ff ff       	jmp    801056ae <alltraps>

801065c7 <vector252>:
.globl vector252
vector252:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $252
801065c9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801065ce:	e9 db f0 ff ff       	jmp    801056ae <alltraps>

801065d3 <vector253>:
.globl vector253
vector253:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $253
801065d5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801065da:	e9 cf f0 ff ff       	jmp    801056ae <alltraps>

801065df <vector254>:
.globl vector254
vector254:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $254
801065e1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801065e6:	e9 c3 f0 ff ff       	jmp    801056ae <alltraps>

801065eb <vector255>:
.globl vector255
vector255:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $255
801065ed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801065f2:	e9 b7 f0 ff ff       	jmp    801056ae <alltraps>
801065f7:	66 90                	xchg   %ax,%ax
801065f9:	66 90                	xchg   %ax,%ax
801065fb:	66 90                	xchg   %ax,%ax
801065fd:	66 90                	xchg   %ax,%ax
801065ff:	90                   	nop

80106600 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	57                   	push   %edi
80106604:	56                   	push   %esi
80106605:	53                   	push   %ebx
80106606:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106608:	c1 ea 16             	shr    $0x16,%edx
8010660b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010660e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106611:	8b 07                	mov    (%edi),%eax
80106613:	a8 01                	test   $0x1,%al
80106615:	74 29                	je     80106640 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106617:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010661c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106622:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106625:	c1 eb 0a             	shr    $0xa,%ebx
80106628:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010662e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106631:	5b                   	pop    %ebx
80106632:	5e                   	pop    %esi
80106633:	5f                   	pop    %edi
80106634:	5d                   	pop    %ebp
80106635:	c3                   	ret    
80106636:	8d 76 00             	lea    0x0(%esi),%esi
80106639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106640:	85 c9                	test   %ecx,%ecx
80106642:	74 2c                	je     80106670 <walkpgdir+0x70>
80106644:	e8 37 be ff ff       	call   80102480 <kalloc>
80106649:	85 c0                	test   %eax,%eax
8010664b:	89 c6                	mov    %eax,%esi
8010664d:	74 21                	je     80106670 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010664f:	83 ec 04             	sub    $0x4,%esp
80106652:	68 00 10 00 00       	push   $0x1000
80106657:	6a 00                	push   $0x0
80106659:	50                   	push   %eax
8010665a:	e8 31 de ff ff       	call   80104490 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010665f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106665:	83 c4 10             	add    $0x10,%esp
80106668:	83 c8 07             	or     $0x7,%eax
8010666b:	89 07                	mov    %eax,(%edi)
8010666d:	eb b3                	jmp    80106622 <walkpgdir+0x22>
8010666f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106670:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106673:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106675:	5b                   	pop    %ebx
80106676:	5e                   	pop    %esi
80106677:	5f                   	pop    %edi
80106678:	5d                   	pop    %ebp
80106679:	c3                   	ret    
8010667a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106680 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106680:	55                   	push   %ebp
80106681:	89 e5                	mov    %esp,%ebp
80106683:	57                   	push   %edi
80106684:	56                   	push   %esi
80106685:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106686:	89 d3                	mov    %edx,%ebx
80106688:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010668e:	83 ec 1c             	sub    $0x1c,%esp
80106691:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106694:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106698:	8b 7d 08             	mov    0x8(%ebp),%edi
8010669b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801066a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801066a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801066a6:	29 df                	sub    %ebx,%edi
801066a8:	83 c8 01             	or     $0x1,%eax
801066ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
801066ae:	eb 15                	jmp    801066c5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801066b0:	f6 00 01             	testb  $0x1,(%eax)
801066b3:	75 45                	jne    801066fa <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801066b5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801066b8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801066bb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801066bd:	74 31                	je     801066f0 <mappages+0x70>
      break;
    a += PGSIZE;
801066bf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801066c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801066c8:	b9 01 00 00 00       	mov    $0x1,%ecx
801066cd:	89 da                	mov    %ebx,%edx
801066cf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801066d2:	e8 29 ff ff ff       	call   80106600 <walkpgdir>
801066d7:	85 c0                	test   %eax,%eax
801066d9:	75 d5                	jne    801066b0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801066db:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801066de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801066e3:	5b                   	pop    %ebx
801066e4:	5e                   	pop    %esi
801066e5:	5f                   	pop    %edi
801066e6:	5d                   	pop    %ebp
801066e7:	c3                   	ret    
801066e8:	90                   	nop
801066e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801066f3:	31 c0                	xor    %eax,%eax
}
801066f5:	5b                   	pop    %ebx
801066f6:	5e                   	pop    %esi
801066f7:	5f                   	pop    %edi
801066f8:	5d                   	pop    %ebp
801066f9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801066fa:	83 ec 0c             	sub    $0xc,%esp
801066fd:	68 c8 77 10 80       	push   $0x801077c8
80106702:	e8 69 9c ff ff       	call   80100370 <panic>
80106707:	89 f6                	mov    %esi,%esi
80106709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106710 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106710:	55                   	push   %ebp
80106711:	89 e5                	mov    %esp,%ebp
80106713:	57                   	push   %edi
80106714:	56                   	push   %esi
80106715:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106716:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010671c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010671e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106724:	83 ec 1c             	sub    $0x1c,%esp
80106727:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010672a:	39 d3                	cmp    %edx,%ebx
8010672c:	73 60                	jae    8010678e <deallocuvm.part.0+0x7e>
8010672e:	89 d6                	mov    %edx,%esi
80106730:	eb 3d                	jmp    8010676f <deallocuvm.part.0+0x5f>
80106732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
80106738:	8b 10                	mov    (%eax),%edx
8010673a:	f6 c2 01             	test   $0x1,%dl
8010673d:	74 26                	je     80106765 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010673f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106745:	74 52                	je     80106799 <deallocuvm.part.0+0x89>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106747:	83 ec 0c             	sub    $0xc,%esp
8010674a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106750:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106753:	52                   	push   %edx
80106754:	e8 77 bb ff ff       	call   801022d0 <kfree>
      *pte = 0;
80106759:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010675c:	83 c4 10             	add    $0x10,%esp
8010675f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106765:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010676b:	39 f3                	cmp    %esi,%ebx
8010676d:	73 1f                	jae    8010678e <deallocuvm.part.0+0x7e>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010676f:	31 c9                	xor    %ecx,%ecx
80106771:	89 da                	mov    %ebx,%edx
80106773:	89 f8                	mov    %edi,%eax
80106775:	e8 86 fe ff ff       	call   80106600 <walkpgdir>
    if(!pte)
8010677a:	85 c0                	test   %eax,%eax
8010677c:	75 ba                	jne    80106738 <deallocuvm.part.0+0x28>
      a += (NPTENTRIES - 1) * PGSIZE;
8010677e:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106784:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010678a:	39 f3                	cmp    %esi,%ebx
8010678c:	72 e1                	jb     8010676f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
8010678e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106791:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106794:	5b                   	pop    %ebx
80106795:	5e                   	pop    %esi
80106796:	5f                   	pop    %edi
80106797:	5d                   	pop    %ebp
80106798:	c3                   	ret    
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106799:	83 ec 0c             	sub    $0xc,%esp
8010679c:	68 92 71 10 80       	push   $0x80107192
801067a1:	e8 ca 9b ff ff       	call   80100370 <panic>
801067a6:	8d 76 00             	lea    0x0(%esi),%esi
801067a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067b0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801067b0:	55                   	push   %ebp
801067b1:	89 e5                	mov    %esp,%ebp
801067b3:	53                   	push   %ebx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067b4:	31 db                	xor    %ebx,%ebx

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801067b6:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801067b9:	e8 22 bf ff ff       	call   801026e0 <cpunum>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067be:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801067c4:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
801067c9:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
801067cf:	c6 80 1d 28 11 80 9a 	movb   $0x9a,-0x7feed7e3(%eax)
801067d6:	c6 80 1e 28 11 80 cf 	movb   $0xcf,-0x7feed7e2(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067dd:	c6 80 25 28 11 80 92 	movb   $0x92,-0x7feed7db(%eax)
801067e4:	c6 80 26 28 11 80 cf 	movb   $0xcf,-0x7feed7da(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067eb:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067ef:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801067f4:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801067f8:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
801067ff:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106801:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106806:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010680d:	66 89 8a 90 00 00 00 	mov    %cx,0x90(%edx)
80106814:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106816:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010681b:	66 89 9a 92 00 00 00 	mov    %bx,0x92(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106822:	31 db                	xor    %ebx,%ebx
80106824:	66 89 8a 98 00 00 00 	mov    %cx,0x98(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
8010682b:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106831:	66 89 9a 9a 00 00 00 	mov    %bx,0x9a(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106838:	31 db                	xor    %ebx,%ebx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010683a:	c6 80 35 28 11 80 fa 	movb   $0xfa,-0x7feed7cb(%eax)
80106841:	c6 80 36 28 11 80 cf 	movb   $0xcf,-0x7feed7ca(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106848:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
8010684f:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106856:	89 cb                	mov    %ecx,%ebx
80106858:	c1 e9 18             	shr    $0x18,%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010685b:	c6 80 3d 28 11 80 f2 	movb   $0xf2,-0x7feed7c3(%eax)
80106862:	c6 80 3e 28 11 80 cf 	movb   $0xcf,-0x7feed7c2(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106869:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
8010686f:	c6 80 2d 28 11 80 92 	movb   $0x92,-0x7feed7d3(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106876:	b9 37 00 00 00       	mov    $0x37,%ecx
8010687b:	c6 80 2e 28 11 80 c0 	movb   $0xc0,-0x7feed7d2(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80106882:	05 10 28 11 80       	add    $0x80112810,%eax
80106887:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
8010688b:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
8010688e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106892:	c1 e8 10             	shr    $0x10,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106895:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80106899:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010689d:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
801068a4:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801068ab:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
801068b2:	c6 82 97 00 00 00 00 	movb   $0x0,0x97(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801068b9:	c6 82 9c 00 00 00 00 	movb   $0x0,0x9c(%edx)
801068c0:	c6 82 9f 00 00 00 00 	movb   $0x0,0x9f(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801068c7:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
801068cd:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801068d1:	8d 45 f2             	lea    -0xe(%ebp),%eax
801068d4:	0f 01 10             	lgdtl  (%eax)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
801068d7:	b8 18 00 00 00       	mov    $0x18,%eax
801068dc:	8e e8                	mov    %eax,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
801068de:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801068e5:	00 00 00 00 

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801068e9:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
}
801068f0:	83 c4 14             	add    $0x14,%esp
801068f3:	5b                   	pop    %ebx
801068f4:	5d                   	pop    %ebp
801068f5:	c3                   	ret    
801068f6:	8d 76 00             	lea    0x0(%esi),%esi
801068f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106900 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106900:	55                   	push   %ebp
80106901:	89 e5                	mov    %esp,%ebp
80106903:	56                   	push   %esi
80106904:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106905:	e8 76 bb ff ff       	call   80102480 <kalloc>
8010690a:	85 c0                	test   %eax,%eax
8010690c:	74 52                	je     80106960 <setupkvm+0x60>
    return 0;
  memset(pgdir, 0, PGSIZE);
8010690e:	83 ec 04             	sub    $0x4,%esp
80106911:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106913:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106918:	68 00 10 00 00       	push   $0x1000
8010691d:	6a 00                	push   $0x0
8010691f:	50                   	push   %eax
80106920:	e8 6b db ff ff       	call   80104490 <memset>
80106925:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106928:	8b 43 04             	mov    0x4(%ebx),%eax
8010692b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010692e:	83 ec 08             	sub    $0x8,%esp
80106931:	8b 13                	mov    (%ebx),%edx
80106933:	ff 73 0c             	pushl  0xc(%ebx)
80106936:	50                   	push   %eax
80106937:	29 c1                	sub    %eax,%ecx
80106939:	89 f0                	mov    %esi,%eax
8010693b:	e8 40 fd ff ff       	call   80106680 <mappages>
80106940:	83 c4 10             	add    $0x10,%esp
80106943:	85 c0                	test   %eax,%eax
80106945:	78 19                	js     80106960 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106947:	83 c3 10             	add    $0x10,%ebx
8010694a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106950:	75 d6                	jne    80106928 <setupkvm+0x28>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106952:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106955:	89 f0                	mov    %esi,%eax
80106957:	5b                   	pop    %ebx
80106958:	5e                   	pop    %esi
80106959:	5d                   	pop    %ebp
8010695a:	c3                   	ret    
8010695b:	90                   	nop
8010695c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106960:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106963:	31 c0                	xor    %eax,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106965:	5b                   	pop    %ebx
80106966:	5e                   	pop    %esi
80106967:	5d                   	pop    %ebp
80106968:	c3                   	ret    
80106969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106970 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106976:	e8 85 ff ff ff       	call   80106900 <setupkvm>
8010697b:	a3 24 55 11 80       	mov    %eax,0x80115524
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106980:	05 00 00 00 80       	add    $0x80000000,%eax
80106985:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106988:	c9                   	leave  
80106989:	c3                   	ret    
8010698a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106990 <switchkvm>:
80106990:	a1 24 55 11 80       	mov    0x80115524,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106995:	55                   	push   %ebp
80106996:	89 e5                	mov    %esp,%ebp
80106998:	05 00 00 00 80       	add    $0x80000000,%eax
8010699d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
801069a0:	5d                   	pop    %ebp
801069a1:	c3                   	ret    
801069a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069b0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	53                   	push   %ebx
801069b4:	83 ec 04             	sub    $0x4,%esp
801069b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801069ba:	e8 01 da ff ff       	call   801043c0 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801069bf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801069c5:	b9 67 00 00 00       	mov    $0x67,%ecx
801069ca:	8d 50 08             	lea    0x8(%eax),%edx
801069cd:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
801069d4:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801069db:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801069e2:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
801069e9:	89 d1                	mov    %edx,%ecx
801069eb:	c1 ea 18             	shr    $0x18,%edx
801069ee:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
801069f4:	ba 10 00 00 00       	mov    $0x10,%edx
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801069f9:	c1 e9 10             	shr    $0x10,%ecx
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
801069fc:	66 89 50 10          	mov    %dx,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106a00:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106a07:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80106a0d:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106a12:	8b 52 08             	mov    0x8(%edx),%edx
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80106a15:	66 89 48 6e          	mov    %cx,0x6e(%eax)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106a19:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106a1f:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106a22:	b8 30 00 00 00       	mov    $0x30,%eax
80106a27:	0f 00 d8             	ltr    %ax
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
80106a2a:	8b 43 04             	mov    0x4(%ebx),%eax
80106a2d:	85 c0                	test   %eax,%eax
80106a2f:	74 11                	je     80106a42 <switchuvm+0x92>
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a31:	05 00 00 00 80       	add    $0x80000000,%eax
80106a36:	0f 22 d8             	mov    %eax,%cr3
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106a39:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106a3c:	c9                   	leave  
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106a3d:	e9 ae d9 ff ff       	jmp    801043f0 <popcli>
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106a42:	83 ec 0c             	sub    $0xc,%esp
80106a45:	68 ce 77 10 80       	push   $0x801077ce
80106a4a:	e8 21 99 ff ff       	call   80100370 <panic>
80106a4f:	90                   	nop

80106a50 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
80106a53:	57                   	push   %edi
80106a54:	56                   	push   %esi
80106a55:	53                   	push   %ebx
80106a56:	83 ec 1c             	sub    $0x1c,%esp
80106a59:	8b 75 10             	mov    0x10(%ebp),%esi
80106a5c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a5f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106a62:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106a68:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106a6b:	77 49                	ja     80106ab6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106a6d:	e8 0e ba ff ff       	call   80102480 <kalloc>
  memset(mem, 0, PGSIZE);
80106a72:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106a75:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106a77:	68 00 10 00 00       	push   $0x1000
80106a7c:	6a 00                	push   $0x0
80106a7e:	50                   	push   %eax
80106a7f:	e8 0c da ff ff       	call   80104490 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106a84:	58                   	pop    %eax
80106a85:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106a8b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106a90:	5a                   	pop    %edx
80106a91:	6a 06                	push   $0x6
80106a93:	50                   	push   %eax
80106a94:	31 d2                	xor    %edx,%edx
80106a96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a99:	e8 e2 fb ff ff       	call   80106680 <mappages>
  memmove(mem, init, sz);
80106a9e:	89 75 10             	mov    %esi,0x10(%ebp)
80106aa1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106aa4:	83 c4 10             	add    $0x10,%esp
80106aa7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106aaa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106aad:	5b                   	pop    %ebx
80106aae:	5e                   	pop    %esi
80106aaf:	5f                   	pop    %edi
80106ab0:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106ab1:	e9 8a da ff ff       	jmp    80104540 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106ab6:	83 ec 0c             	sub    $0xc,%esp
80106ab9:	68 e2 77 10 80       	push   $0x801077e2
80106abe:	e8 ad 98 ff ff       	call   80100370 <panic>
80106ac3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ad0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	57                   	push   %edi
80106ad4:	56                   	push   %esi
80106ad5:	53                   	push   %ebx
80106ad6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106ad9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106ae0:	0f 85 91 00 00 00    	jne    80106b77 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106ae6:	8b 75 18             	mov    0x18(%ebp),%esi
80106ae9:	31 db                	xor    %ebx,%ebx
80106aeb:	85 f6                	test   %esi,%esi
80106aed:	75 1a                	jne    80106b09 <loaduvm+0x39>
80106aef:	eb 6f                	jmp    80106b60 <loaduvm+0x90>
80106af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106af8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106afe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b04:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b07:	76 57                	jbe    80106b60 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106b09:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b0c:	8b 45 08             	mov    0x8(%ebp),%eax
80106b0f:	31 c9                	xor    %ecx,%ecx
80106b11:	01 da                	add    %ebx,%edx
80106b13:	e8 e8 fa ff ff       	call   80106600 <walkpgdir>
80106b18:	85 c0                	test   %eax,%eax
80106b1a:	74 4e                	je     80106b6a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106b1c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b1e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106b21:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106b26:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106b2b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106b31:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106b34:	01 d9                	add    %ebx,%ecx
80106b36:	05 00 00 00 80       	add    $0x80000000,%eax
80106b3b:	57                   	push   %edi
80106b3c:	51                   	push   %ecx
80106b3d:	50                   	push   %eax
80106b3e:	ff 75 10             	pushl  0x10(%ebp)
80106b41:	e8 da ad ff ff       	call   80101920 <readi>
80106b46:	83 c4 10             	add    $0x10,%esp
80106b49:	39 c7                	cmp    %eax,%edi
80106b4b:	74 ab                	je     80106af8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106b4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106b55:	5b                   	pop    %ebx
80106b56:	5e                   	pop    %esi
80106b57:	5f                   	pop    %edi
80106b58:	5d                   	pop    %ebp
80106b59:	c3                   	ret    
80106b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b60:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106b63:	31 c0                	xor    %eax,%eax
}
80106b65:	5b                   	pop    %ebx
80106b66:	5e                   	pop    %esi
80106b67:	5f                   	pop    %edi
80106b68:	5d                   	pop    %ebp
80106b69:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106b6a:	83 ec 0c             	sub    $0xc,%esp
80106b6d:	68 fc 77 10 80       	push   $0x801077fc
80106b72:	e8 f9 97 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106b77:	83 ec 0c             	sub    $0xc,%esp
80106b7a:	68 a0 78 10 80       	push   $0x801078a0
80106b7f:	e8 ec 97 ff ff       	call   80100370 <panic>
80106b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106b90 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106b90:	55                   	push   %ebp
80106b91:	89 e5                	mov    %esp,%ebp
80106b93:	57                   	push   %edi
80106b94:	56                   	push   %esi
80106b95:	53                   	push   %ebx
80106b96:	83 ec 0c             	sub    $0xc,%esp
80106b99:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106b9c:	85 ff                	test   %edi,%edi
80106b9e:	0f 88 ca 00 00 00    	js     80106c6e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80106ba4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106ba7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106baa:	0f 82 82 00 00 00    	jb     80106c32 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106bb0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106bb6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106bbc:	39 df                	cmp    %ebx,%edi
80106bbe:	77 43                	ja     80106c03 <allocuvm+0x73>
80106bc0:	e9 bb 00 00 00       	jmp    80106c80 <allocuvm+0xf0>
80106bc5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106bc8:	83 ec 04             	sub    $0x4,%esp
80106bcb:	68 00 10 00 00       	push   $0x1000
80106bd0:	6a 00                	push   $0x0
80106bd2:	50                   	push   %eax
80106bd3:	e8 b8 d8 ff ff       	call   80104490 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106bd8:	58                   	pop    %eax
80106bd9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106bdf:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106be4:	5a                   	pop    %edx
80106be5:	6a 06                	push   $0x6
80106be7:	50                   	push   %eax
80106be8:	89 da                	mov    %ebx,%edx
80106bea:	8b 45 08             	mov    0x8(%ebp),%eax
80106bed:	e8 8e fa ff ff       	call   80106680 <mappages>
80106bf2:	83 c4 10             	add    $0x10,%esp
80106bf5:	85 c0                	test   %eax,%eax
80106bf7:	78 47                	js     80106c40 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106bf9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bff:	39 df                	cmp    %ebx,%edi
80106c01:	76 7d                	jbe    80106c80 <allocuvm+0xf0>
    mem = kalloc();
80106c03:	e8 78 b8 ff ff       	call   80102480 <kalloc>
    if(mem == 0){
80106c08:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106c0a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106c0c:	75 ba                	jne    80106bc8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106c0e:	83 ec 0c             	sub    $0xc,%esp
80106c11:	68 1a 78 10 80       	push   $0x8010781a
80106c16:	e8 45 9a ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106c1b:	83 c4 10             	add    $0x10,%esp
80106c1e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c21:	76 4b                	jbe    80106c6e <allocuvm+0xde>
80106c23:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c26:	8b 45 08             	mov    0x8(%ebp),%eax
80106c29:	89 fa                	mov    %edi,%edx
80106c2b:	e8 e0 fa ff ff       	call   80106710 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106c30:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106c32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c35:	5b                   	pop    %ebx
80106c36:	5e                   	pop    %esi
80106c37:	5f                   	pop    %edi
80106c38:	5d                   	pop    %ebp
80106c39:	c3                   	ret    
80106c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106c40:	83 ec 0c             	sub    $0xc,%esp
80106c43:	68 32 78 10 80       	push   $0x80107832
80106c48:	e8 13 9a ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106c4d:	83 c4 10             	add    $0x10,%esp
80106c50:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c53:	76 0d                	jbe    80106c62 <allocuvm+0xd2>
80106c55:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c58:	8b 45 08             	mov    0x8(%ebp),%eax
80106c5b:	89 fa                	mov    %edi,%edx
80106c5d:	e8 ae fa ff ff       	call   80106710 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80106c62:	83 ec 0c             	sub    $0xc,%esp
80106c65:	56                   	push   %esi
80106c66:	e8 65 b6 ff ff       	call   801022d0 <kfree>
      return 0;
80106c6b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80106c6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80106c71:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80106c73:	5b                   	pop    %ebx
80106c74:	5e                   	pop    %esi
80106c75:	5f                   	pop    %edi
80106c76:	5d                   	pop    %ebp
80106c77:	c3                   	ret    
80106c78:	90                   	nop
80106c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c80:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106c83:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106c85:	5b                   	pop    %ebx
80106c86:	5e                   	pop    %esi
80106c87:	5f                   	pop    %edi
80106c88:	5d                   	pop    %ebp
80106c89:	c3                   	ret    
80106c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c90 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106c90:	55                   	push   %ebp
80106c91:	89 e5                	mov    %esp,%ebp
80106c93:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c96:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106c99:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106c9c:	39 d1                	cmp    %edx,%ecx
80106c9e:	73 10                	jae    80106cb0 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106ca0:	5d                   	pop    %ebp
80106ca1:	e9 6a fa ff ff       	jmp    80106710 <deallocuvm.part.0>
80106ca6:	8d 76 00             	lea    0x0(%esi),%esi
80106ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106cb0:	89 d0                	mov    %edx,%eax
80106cb2:	5d                   	pop    %ebp
80106cb3:	c3                   	ret    
80106cb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106cba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106cc0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	57                   	push   %edi
80106cc4:	56                   	push   %esi
80106cc5:	53                   	push   %ebx
80106cc6:	83 ec 0c             	sub    $0xc,%esp
80106cc9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106ccc:	85 f6                	test   %esi,%esi
80106cce:	74 59                	je     80106d29 <freevm+0x69>
80106cd0:	31 c9                	xor    %ecx,%ecx
80106cd2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106cd7:	89 f0                	mov    %esi,%eax
80106cd9:	e8 32 fa ff ff       	call   80106710 <deallocuvm.part.0>
80106cde:	89 f3                	mov    %esi,%ebx
80106ce0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106ce6:	eb 0f                	jmp    80106cf7 <freevm+0x37>
80106ce8:	90                   	nop
80106ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cf0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106cf3:	39 fb                	cmp    %edi,%ebx
80106cf5:	74 23                	je     80106d1a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106cf7:	8b 03                	mov    (%ebx),%eax
80106cf9:	a8 01                	test   $0x1,%al
80106cfb:	74 f3                	je     80106cf0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80106cfd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d02:	83 ec 0c             	sub    $0xc,%esp
80106d05:	83 c3 04             	add    $0x4,%ebx
80106d08:	05 00 00 00 80       	add    $0x80000000,%eax
80106d0d:	50                   	push   %eax
80106d0e:	e8 bd b5 ff ff       	call   801022d0 <kfree>
80106d13:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106d16:	39 fb                	cmp    %edi,%ebx
80106d18:	75 dd                	jne    80106cf7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106d1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106d1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d20:	5b                   	pop    %ebx
80106d21:	5e                   	pop    %esi
80106d22:	5f                   	pop    %edi
80106d23:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106d24:	e9 a7 b5 ff ff       	jmp    801022d0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106d29:	83 ec 0c             	sub    $0xc,%esp
80106d2c:	68 4e 78 10 80       	push   $0x8010784e
80106d31:	e8 3a 96 ff ff       	call   80100370 <panic>
80106d36:	8d 76 00             	lea    0x0(%esi),%esi
80106d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d40 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d40:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d41:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d43:	89 e5                	mov    %esp,%ebp
80106d45:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d48:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d4b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d4e:	e8 ad f8 ff ff       	call   80106600 <walkpgdir>
  if(pte == 0)
80106d53:	85 c0                	test   %eax,%eax
80106d55:	74 05                	je     80106d5c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106d57:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106d5a:	c9                   	leave  
80106d5b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106d5c:	83 ec 0c             	sub    $0xc,%esp
80106d5f:	68 5f 78 10 80       	push   $0x8010785f
80106d64:	e8 07 96 ff ff       	call   80100370 <panic>
80106d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106d70 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	57                   	push   %edi
80106d74:	56                   	push   %esi
80106d75:	53                   	push   %ebx
80106d76:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106d79:	e8 82 fb ff ff       	call   80106900 <setupkvm>
80106d7e:	85 c0                	test   %eax,%eax
80106d80:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106d83:	0f 84 b2 00 00 00    	je     80106e3b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d89:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106d8c:	85 c9                	test   %ecx,%ecx
80106d8e:	0f 84 9c 00 00 00    	je     80106e30 <copyuvm+0xc0>
80106d94:	31 f6                	xor    %esi,%esi
80106d96:	eb 4a                	jmp    80106de2 <copyuvm+0x72>
80106d98:	90                   	nop
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106da0:	83 ec 04             	sub    $0x4,%esp
80106da3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106da9:	68 00 10 00 00       	push   $0x1000
80106dae:	57                   	push   %edi
80106daf:	50                   	push   %eax
80106db0:	e8 8b d7 ff ff       	call   80104540 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106db5:	58                   	pop    %eax
80106db6:	5a                   	pop    %edx
80106db7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80106dbd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106dc0:	ff 75 e4             	pushl  -0x1c(%ebp)
80106dc3:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dc8:	52                   	push   %edx
80106dc9:	89 f2                	mov    %esi,%edx
80106dcb:	e8 b0 f8 ff ff       	call   80106680 <mappages>
80106dd0:	83 c4 10             	add    $0x10,%esp
80106dd3:	85 c0                	test   %eax,%eax
80106dd5:	78 3e                	js     80106e15 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106dd7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106ddd:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106de0:	76 4e                	jbe    80106e30 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106de2:	8b 45 08             	mov    0x8(%ebp),%eax
80106de5:	31 c9                	xor    %ecx,%ecx
80106de7:	89 f2                	mov    %esi,%edx
80106de9:	e8 12 f8 ff ff       	call   80106600 <walkpgdir>
80106dee:	85 c0                	test   %eax,%eax
80106df0:	74 5a                	je     80106e4c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106df2:	8b 18                	mov    (%eax),%ebx
80106df4:	f6 c3 01             	test   $0x1,%bl
80106df7:	74 46                	je     80106e3f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106df9:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80106dfb:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80106e01:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106e04:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106e0a:	e8 71 b6 ff ff       	call   80102480 <kalloc>
80106e0f:	85 c0                	test   %eax,%eax
80106e11:	89 c3                	mov    %eax,%ebx
80106e13:	75 8b                	jne    80106da0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106e15:	83 ec 0c             	sub    $0xc,%esp
80106e18:	ff 75 e0             	pushl  -0x20(%ebp)
80106e1b:	e8 a0 fe ff ff       	call   80106cc0 <freevm>
  return 0;
80106e20:	83 c4 10             	add    $0x10,%esp
80106e23:	31 c0                	xor    %eax,%eax
}
80106e25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e28:	5b                   	pop    %ebx
80106e29:	5e                   	pop    %esi
80106e2a:	5f                   	pop    %edi
80106e2b:	5d                   	pop    %ebp
80106e2c:	c3                   	ret    
80106e2d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106e30:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80106e33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e36:	5b                   	pop    %ebx
80106e37:	5e                   	pop    %esi
80106e38:	5f                   	pop    %edi
80106e39:	5d                   	pop    %ebp
80106e3a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80106e3b:	31 c0                	xor    %eax,%eax
80106e3d:	eb e6                	jmp    80106e25 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106e3f:	83 ec 0c             	sub    $0xc,%esp
80106e42:	68 83 78 10 80       	push   $0x80107883
80106e47:	e8 24 95 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106e4c:	83 ec 0c             	sub    $0xc,%esp
80106e4f:	68 69 78 10 80       	push   $0x80107869
80106e54:	e8 17 95 ff ff       	call   80100370 <panic>
80106e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e60 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106e60:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e61:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106e63:	89 e5                	mov    %esp,%ebp
80106e65:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e68:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e6b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e6e:	e8 8d f7 ff ff       	call   80106600 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106e73:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80106e75:	89 c2                	mov    %eax,%edx
80106e77:	83 e2 05             	and    $0x5,%edx
80106e7a:	83 fa 05             	cmp    $0x5,%edx
80106e7d:	75 11                	jne    80106e90 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106e7f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80106e84:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106e85:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106e8a:	c3                   	ret    
80106e8b:	90                   	nop
80106e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80106e90:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80106e92:	c9                   	leave  
80106e93:	c3                   	ret    
80106e94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106ea0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106ea0:	55                   	push   %ebp
80106ea1:	89 e5                	mov    %esp,%ebp
80106ea3:	57                   	push   %edi
80106ea4:	56                   	push   %esi
80106ea5:	53                   	push   %ebx
80106ea6:	83 ec 1c             	sub    $0x1c,%esp
80106ea9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106eac:	8b 55 0c             	mov    0xc(%ebp),%edx
80106eaf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106eb2:	85 db                	test   %ebx,%ebx
80106eb4:	75 40                	jne    80106ef6 <copyout+0x56>
80106eb6:	eb 70                	jmp    80106f28 <copyout+0x88>
80106eb8:	90                   	nop
80106eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106ec0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ec3:	89 f1                	mov    %esi,%ecx
80106ec5:	29 d1                	sub    %edx,%ecx
80106ec7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106ecd:	39 d9                	cmp    %ebx,%ecx
80106ecf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106ed2:	29 f2                	sub    %esi,%edx
80106ed4:	83 ec 04             	sub    $0x4,%esp
80106ed7:	01 d0                	add    %edx,%eax
80106ed9:	51                   	push   %ecx
80106eda:	57                   	push   %edi
80106edb:	50                   	push   %eax
80106edc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106edf:	e8 5c d6 ff ff       	call   80104540 <memmove>
    len -= n;
    buf += n;
80106ee4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ee7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80106eea:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106ef0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ef2:	29 cb                	sub    %ecx,%ebx
80106ef4:	74 32                	je     80106f28 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80106ef6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106ef8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106efb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106efe:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f04:	56                   	push   %esi
80106f05:	ff 75 08             	pushl  0x8(%ebp)
80106f08:	e8 53 ff ff ff       	call   80106e60 <uva2ka>
    if(pa0 == 0)
80106f0d:	83 c4 10             	add    $0x10,%esp
80106f10:	85 c0                	test   %eax,%eax
80106f12:	75 ac                	jne    80106ec0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106f14:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80106f17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106f1c:	5b                   	pop    %ebx
80106f1d:	5e                   	pop    %esi
80106f1e:	5f                   	pop    %edi
80106f1f:	5d                   	pop    %ebp
80106f20:	c3                   	ret    
80106f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f28:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106f2b:	31 c0                	xor    %eax,%eax
}
80106f2d:	5b                   	pop    %ebx
80106f2e:	5e                   	pop    %esi
80106f2f:	5f                   	pop    %edi
80106f30:	5d                   	pop    %ebp
80106f31:	c3                   	ret    

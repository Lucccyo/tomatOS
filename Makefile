all:
	nasm -f bin ./src/boot.asm -o ./bin/boot.bin

clean:
	rm -rf ./bin/boot.bin

qemu: all
	qemu-system-x86_64 -hda ./bin/boot.bin
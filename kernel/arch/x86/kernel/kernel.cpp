extern "C" void kernelMain(void *multiboot_structure, unsigned int magicnumber)
{
    // Clear the screen
    for (int i = 0; i < 80 * 25; i++)
        ((short *)0xb8000)[i] = (0x07 << 8) | ' ';

    // Print "Hello World!"
    char *hello = "Hello World!";
    for (int i = 0; hello[i] != '\0'; i++)
        ((short *)0xb8000)[i] = (0x07 << 8) | hello[i];

    while (1)
        ;
}
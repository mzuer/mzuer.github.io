---
layout: post
title: "Bash - cut words and other terminal shortcuts"
date: 2020-07-02
category: batch
tags: [bash]
---


cut previous word using Ctrl+w
(maybe ctrl+d to cut next word)



In Linux try Ctrl+k to delete from where the cursor is to the end of the word.

There are few other shortcuts listed below(working in Linux):

    Ctrl+e -> Takes cursor at the end of the word.
    Ctrl+t -> Inter-change the position of the alphabets.
    Ctrl+y -> adds postfix "hh" to current word.
    Ctrl+u -> Deletes the whole line.
    Ctrl+o -> Works same as Enter key.
    Ctrl+p -> Works same as up arrow button.
    Ctrl+a -> Brings cursor to the starting position of the command.
    Ctrl+d -> Closes terminal.
    Ctrl+f -> Moves cursor forward by one Character.
    Ctrl+h -> Works same as Backspace key.
    Ctrl+j -> Works same as Enter key.
    Ctrl+m -> Works same as Enter key.
    Ctrl+b -> Works same as Right-arrow key. 




https://linuxhandbook.com/linux-shortcuts/

1. Tab

This is the Linux shortcut you cannot live without. It will save you so much time in the Linux command line.

Just start typing a command, filename, directory name or even command options and hit the tab key. It will either automatically complete what you were typing or it will show all the possible results for you.

If you could only remember one shortcut, this would be the chosen one.
2. Ctrl + C

These are the keys you should press in order to break out of a command or process on a terminal. This will stop a running program immediately.

If you want to stop using a program running in the foreground, just press this key combination.
3. Ctrl + Z

This shortcut will send a running program in the background. Normally, you can achieve this before running the program using the & option but if you forgot to do that, use this key combination.
4. Ctrl + D

This keyboard shortcut will log you out of the current terminal. If you are using an SSH connection, it will be closed. If you are using a terminal directly, the application will be closed immediately.

Consider it equivalent to the ‘exit’ command.
5. Ctrl + L

How do you clear your terminal screen? I guess using the clear command.

Instead of writing C-L-E-A-R, you can simply use Ctrl+L to clear the terminal. Handy, isn’t it?
6. Ctrl + A

This shortcut will move the cursor to the beginning of the line.

Suppose you typed a long command or path in the terminal and you want to go to the beginning of it, using the arrow key to move the cursor will take plenty of time. Do note that you cannot use the mouse to move the cursor to the beginning of the line.

This is where Ctrl+A saves the day.
7. Ctrl + E

This shortcut is sort of opposite to Ctrl+A. Ctrl+A sends the cursor to the beginning of the line whereas Ctrl+E moves the cursor to the end of the line.

Note: If you have the Home and End keys on your keyboard, you can also use them. Home is equivalent to Ctrl +A and End is equivalent to Ctrl + E.
8. Ctrl + U

Typed a wrong command? Instead of using the backspace to discard the current command, use Ctrl+U shortcut in the Linux terminal. This shortcut erases everything from the current cursor position to the beginning of the line.

9. Ctrl + K

This one is similar to the Ctrl+U shortcut. The only difference is that instead of the beginning of the line, it erases everything from the current cursor position to the end of the line.
10. Ctrl + W

You just learned about erasing text till the beginning and the end of the line. But what if you just need to delete a single word? Use the Ctrl+W shortcut.

Using Ctrl+W shortcut, you can erase the word preceding to the cursor position. If the cursor is on a word itself, it will erase all letters from the cursor position to the beginning of the word.

The best way to use it to move the cursor to the next space after the targetted word and then use the Ctrl+W keyboard shortcut.
11. Ctrl + Y

This will paste the erased text that you saw with Ctrl + W, Ctrl + U and Ctrl + K shortcuts. Comes handy in case you erased wrong text or if you need to use the erased text someplace else.
12. Ctrl + P

You can use this shortcut to view the previous command. You can press it repeatedly to keep on going back in the command history. In a lot of terminals, the same can be achieved with PgUp key.
13. Ctrl + N

You can use this shortcut in conjugation with Ctrl+P. Ctrl+N displays the next command. If you are viewing previous commands with Ctrl+P, you can use Ctrl+N to navigate back and forth. Many terminals have this shortcut mapped to the PgDn key.
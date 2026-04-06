#!/usr/bin/python3
"""
Locates and replaces the first occurrence of a string in the heap
of a running process.
"""
import sys


def main():
    """Main function to find and replace string in heap."""
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search_str = sys.argv[2]
    replace_str = sys.argv[3]
    start = None
    end = None

    try:
        with open("/proc/{}/maps".format(pid), "r") as maps:
            for line in maps:
                if "[heap]" in line:
                    start_str, end_str = line.split()[0].split("-")
                    start = int(start_str, 16)
                    end = int(end_str, 16)
                    break
    except Exception:
        sys.exit(1)

    if start is None:
        sys.exit(1)

    try:
        with open("/proc/{}/mem".format(pid), "r+b") as mem:
            mem.seek(start)
            heap = mem.read(end - start)
            index = heap.find(search_str.encode('ascii'))
            if index != -1:
                mem.seek(start + index)
                mem.write(replace_str.encode('ascii') + b'\x00')
    except Exception:
        sys.exit(1)


if __name__ == "__main__":
    main()

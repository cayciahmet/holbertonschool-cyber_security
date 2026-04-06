#!/usr/bin/env python3
"""
Finds a string in the heap of a running process and replaces it.
"""
import sys


def print_usage_and_exit():
    """Prints usage message to stdout and exits with status 1."""
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


def main():
    """Main entry point for the script."""
    if len(sys.argv) != 4:
        print_usage_and_exit()

    pid = sys.argv[1]
    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    maps_path = "/proc/{}/maps".format(pid)
    mem_path = "/proc/{}/mem".format(pid)

    start_addr = None
    end_addr = None

    # Find heap boundaries
    try:
        with open(maps_path, "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    addr_range = line.split()[0]
                    start_str, end_str = addr_range.split("-")
                    start_addr = int(start_str, 16)
                    end_addr = int(end_str, 16)
                    break
    except Exception:
        sys.exit(1)

    if start_addr is None:
        sys.exit(1)

    # Read, find and replace in memory
    try:
        with open(mem_path, "r+b") as mem_file:
            mem_file.seek(start_addr)
            heap_data = mem_file.read(end_addr - start_addr)

            search_bytes = search_string.encode("ascii")
            # C strings are null-terminated
            replace_bytes = replace_string.encode("ascii") + b'\x00'

            offset = heap_data.find(search_bytes)
            if offset == -1:
                sys.exit(1)

            mem_file.seek(start_addr + offset)
            mem_file.write(replace_bytes)
    except Exception:
        sys.exit(1)


if __name__ == "__main__":
    main()

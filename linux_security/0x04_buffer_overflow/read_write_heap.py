#!/usr/bin/env python3
"""
Çalışan bir sürecin heap belleğinde belirli bir metni (string) bulur ve
başka bir metinle değiştirir.
Kullanım: ./read_write_heap.py pid aranacak_metin yeni_metin
"""

import sys

def print_usage_and_exit():
    """Hatalı kullanım durumunda mesaj yazdırır ve 1 koduyla çıkar."""
    print("Usage: {} pid search_string replace_string".format(sys.argv[0]))
    sys.exit(1)

def main():
    # Argüman kontrolü
    if len(sys.argv) != 4:
        print_usage_and_exit()

    pid = sys.argv[1]
    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    maps_file = "/proc/{}/maps".format(pid)
    mem_file = "/proc/{}/mem".format(pid)

    print("[*] maps: {}".format(maps_file))
    print("[*] mem: {}".format(mem_file))

    # 1. maps dosyası üzerinden '[heap]' alanını bulma
    heap_start = None
    heap_end = None
    try:
        with open(maps_file, "r") as m:
            for line in m:
                if "[heap]" in line:
                    # Adres aralığını al (örneğin: 555e646e0000-555e64701000)
                    addr_range = line.split()[0]
                    start, end = addr_range.split("-")
                    heap_start = int(start, 16)
                    heap_end = int(end, 16)
                    break
    except Exception as e:
        print("Error: maps dosyası açılamadı. {}".format(e))
        sys.exit(1)

    if heap_start is None:
        print("Error: maps dosyasında [heap] alanı bulunamadı.")
        sys.exit(1)

    print("[*] Found [heap]:")
    print("\tstart = {:x}\n\tend = {:x}".format(heap_start, heap_end))

    # 2. mem dosyası üzerinden heap alanını okuma
    try:
        with open(mem_file, "rb") as mem:
            mem.seek(heap_start)
            heap_data = mem.read(heap_end - heap_start)
    except Exception as e:
        print("Error: Bellek (mem dosyası) okunamadı. {}".format(e))
        sys.exit(1)

    # 3. Aranacak string'i byte formatında bulma (ASCII varsayımı)
    search_bytes = search_string.encode("ascii")
    offset = heap_data.find(search_bytes)

    if offset == -1:
        print("Error: '{}' metni heap belleğinde bulunamadı.".format(search_string))
        sys.exit(1)

    target_addr = heap_start + offset
    print("[*] Found '{}' at {:x}".format(search_string, target_addr))

    # 4. Değiştirilecek string'i hazırlama
    # Orijinal stringin boyutunu aşmamak ve belleği bozmamak için:
    # Eğer yeni metin daha kısaysa, geri kalan kısmı null byte (\0) ile dolduruyoruz.
    if len(replace_string) < len(search_string):
        replace_string += "\0" * (len(search_string) - len(replace_string))
    # Eğer daha uzunsa, taşıp programı çökertmemek için kesiyoruz.
    elif len(replace_string) > len(search_string):
        replace_string = replace_string[:len(search_string)]

    replace_bytes = replace_string.encode("ascii")

    # 5. Yeni değeri doğrudan belleğe yazma
    print("[*] Writing '{}' at {:x}".format(sys.argv[3], target_addr))
    try:
        with open(mem_file, "r+b") as mem:
            mem.seek(target_addr)
            mem.write(replace_bytes)
    except Exception as e:
        print("Error: Belleğe yazılamadı. Sudo yetkilerini kontrol edin. {}".format(e))
        sys.exit(1)

    print("[*] DONE !")

if __name__ == "__main__":
    main()

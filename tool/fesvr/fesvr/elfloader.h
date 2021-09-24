// See LICENSE for license details.

#ifndef _ELFLOADER_H
#define _ELFLOADER_H

#include "elf.h"
#include <map>
#include <string>

class memif_t;
std::map<std::string, uint64_t> load_elf(const char* fn, memif_t* memif, reg_t* entry);
std::map<std::string, uint64_t> load_elf_symbols_only(const char* fn, memif_t* memif, reg_t* entry);

std::map<std::string, int64_t> load_elf_s(const char* fn, memif_t* memif, reg_t* entry);
std::map<std::string, int64_t> load_elf_symbols_only_s(const char* fn, memif_t* memif, reg_t* entry);
#endif

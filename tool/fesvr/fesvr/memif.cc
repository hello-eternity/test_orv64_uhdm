// See LICENSE for license details.

#include <stdlib.h>
#include <string.h>
#include <stdexcept>
#include "memif.h"
#include "htif.h"

void memif_t::read(addr_t addr, size_t len, void* bytes, enum rw_target target/*Default Value*/)
{
  // Tian: Do not align when address is non-cachable
  if (addr >= 0x80000000) {
    size_t align = htif->chunk_align();
    if (len && (addr & (align-1)))
    {
      size_t this_len = std::min(len, align - size_t(addr & (align-1)));
      uint8_t chunk[align];
  
      htif->read_chunk(addr & ~(align-1), align, chunk, target);
      memcpy(bytes, chunk + (addr & (align-1)), this_len);
  
      bytes = (char*)bytes + this_len;
      addr += this_len;
      len -= this_len;
    }
  
    if (len & (align-1))
    {
      size_t this_len = len & (align-1);
      size_t start = len - this_len;
      uint8_t chunk[align];
  
      htif->read_chunk(addr + start, align, chunk, target);
      memcpy((char*)bytes + start, chunk, this_len);
  
      len -= this_len;
    }
  }

  // now we're aligned
  for (size_t pos = 0; pos < len; pos += htif->chunk_max_size())
    htif->read_chunk(addr + pos, std::min(htif->chunk_max_size(), len - pos), (char*)bytes + pos, target);

  // fprintf(stderr, "reading to addr = %llx, len = %d\n", addr, len);
  // for (int i = 0; i < len; i++)
  //   fprintf(stderr, "bytes[%0d] = 0x%x\n", i, *((char*)bytes + i) & 0xff);
  // fprintf(stderr, "\n");
}

void memif_t::write(addr_t addr, size_t len, const void* bytes, enum rw_target target/*Default Value*/)
{
  //fprintf(stderr, "writing to addr = %lx, len = %ld\n", addr, len);
  //for (size_t i = 0; i < len; i++)
  //  fprintf(stderr, "bytes[%0ld] = 0x%x\n", i, *((char*)bytes + i) & 0xff);
  //fprintf(stderr, "\n");

  // Tian: Do not align when address is non-cachable
  if (addr >= 0x80000000) {
    size_t align = htif->chunk_align();
    if (len && (addr & (align-1)))
    {
      size_t this_len = std::min(len, align - size_t(addr & (align-1)));
      uint8_t chunk[align];
  
      htif->read_chunk(addr & ~(align-1), align, chunk, target);
      memcpy(chunk + (addr & (align-1)), bytes, this_len);
      htif->write_chunk(addr & ~(align-1), align, chunk, target);
  
      bytes = (char*)bytes + this_len;
      addr += this_len;
      len -= this_len;
    }
  
    if (len & (align-1))
    {
      size_t this_len = len & (align-1);
      size_t start = len - this_len;
      uint8_t chunk[align];
  
      htif->read_chunk(addr + start, align, chunk, target);
      memcpy(chunk, (char*)bytes + start, this_len);
      htif->write_chunk(addr + start, align, chunk, target);
  
      len -= this_len;
    }
  }

  // now we're aligned
  bool all_zero = len != 0;
  for (size_t i = 0; i < len; i++)
    all_zero &= ((const char*)bytes)[i] == 0;

  // Tian
  all_zero = 0;

  if (all_zero) {
    htif->clear_chunk(addr, len);
  } else {
    size_t max_chunk = htif->chunk_max_size();
    for (size_t pos = 0; pos < len; pos += max_chunk)
      htif->write_chunk(addr + pos, std::min(max_chunk, len - pos), (char*)bytes + pos, target);
  }
}


//void memif_t::read_debug(addr_t addr, size_t len, void* bytes, enum rw_target target/*Default Value*/)
//{
//  // Tian: Do not align when address is non-cachable
//  if (addr >= 0x80000000) {
//    size_t align = htif->chunk_align();
//    if (len && (addr & (align-1)))
//    {
//      size_t this_len = std::min(len, align - size_t(addr & (align-1)));
//      uint8_t chunk[align];
//  
//      htif->read_debug_chunk(addr & ~(align-1), align, chunk, target);
//      memcpy(bytes, chunk + (addr & (align-1)), this_len);
//  
//      bytes = (char*)bytes + this_len;
//      addr += this_len;
//      len -= this_len;
//    }
//  
//    if (len & (align-1))
//    {
//      size_t this_len = len & (align-1);
//      size_t start = len - this_len;
//      uint8_t chunk[align];
//  
//      htif->read_debug_chunk(addr + start, align, chunk, target);
//      memcpy((char*)bytes + start, chunk, this_len);
//  
//      len -= this_len;
//    }
//  }
//
//  // now we're aligned
//  for (size_t pos = 0; pos < len; pos += htif->chunk_max_size())
//    htif->read_chunk(addr + pos, std::min(htif->chunk_max_size(), len - pos), (char*)bytes + pos, target);
//
//  // fprintf(stderr, "reading to addr = %llx, len = %d\n", addr, len);
//  // for (int i = 0; i < len; i++)
//  //   fprintf(stderr, "bytes[%0d] = 0x%x\n", i, *((char*)bytes + i) & 0xff);
//  // fprintf(stderr, "\n");
//}

//void memif_t::write_debug(addr_t addr, size_t len, const void* bytes, enum rw_target target/*Default Value*/)
//{
//  //fprintf(stderr, "writing to addr = %lx, len = %ld\n", addr, len);
//  //for (size_t i = 0; i < len; i++)
//  //  fprintf(stderr, "bytes[%0ld] = 0x%x\n", i, *((char*)bytes + i) & 0xff);
//  //fprintf(stderr, "\n");
//
//  // Tian: Do not align when address is non-cachable
//  if (addr >= 0x80000000) {
//    size_t align = htif->chunk_align();
//    if (len && (addr & (align-1)))
//    {
//      size_t this_len = std::min(len, align - size_t(addr & (align-1)));
//      uint8_t chunk[align];
//  
//      htif->read_debug_chunk(addr & ~(align-1), align, chunk, target);
//      memcpy(chunk + (addr & (align-1)), bytes, this_len);
//      htif->write_debug_chunk(addr & ~(align-1), align, chunk, target);
//  
//      bytes = (char*)bytes + this_len;
//      addr += this_len;
//      len -= this_len;
//    }
//  
//    if (len & (align-1))
//    {
//      size_t this_len = len & (align-1);
//      size_t start = len - this_len;
//      uint8_t chunk[align];
//  
//      htif->read_debug_chunk(addr + start, align, chunk, target);
//      memcpy(chunk, (char*)bytes + start, this_len);
//      htif->write_debug_chunk(addr + start, align, chunk, target);
//  
//      len -= this_len;
//    }
//  }
//
//  // now we're aligned
//  bool all_zero = len != 0;
//  for (size_t i = 0; i < len; i++)
//    all_zero &= ((const char*)bytes)[i] == 0;
//
//  // Tian
//  all_zero = 0;
//
//  if (all_zero) {
//    htif->clear_chunk(addr, len);
//  } else {
//    size_t max_chunk = htif->chunk_max_size();
//    for (size_t pos = 0; pos < len; pos += max_chunk)
//      htif->write_debug_chunk(addr + pos, std::min(max_chunk, len - pos), (char*)bytes + pos, target);
//  }
//}


#define MEMIF_READ_FUNC \
  if(addr & (sizeof(val)-1)) { \
    throw std::runtime_error("misaligned address"); \
  } \
  this->read(addr, sizeof(val), &val); \
  return val

#define MEMIF_WRITE_FUNC \
  if(addr & (sizeof(val)-1)) { \
    throw std::runtime_error("misaligned address"); \
  } \
  this->write(addr, sizeof(val), &val)

uint8_t memif_t::read_uint8(addr_t addr)
{
  uint8_t val;
  MEMIF_READ_FUNC;
}

int8_t memif_t::read_int8(addr_t addr)
{
  int8_t val;
  MEMIF_READ_FUNC;
}

void memif_t::write_uint8(addr_t addr, uint8_t val)
{
  MEMIF_WRITE_FUNC;
}

void memif_t::write_int8(addr_t addr, int8_t val)
{
  MEMIF_WRITE_FUNC;
}

uint16_t memif_t::read_uint16(addr_t addr)
{
  uint16_t val;
  MEMIF_READ_FUNC;
}

int16_t memif_t::read_int16(addr_t addr)
{
  int16_t val;
  MEMIF_READ_FUNC;
}

void memif_t::write_uint16(addr_t addr, uint16_t val)
{
  MEMIF_WRITE_FUNC;
}

void memif_t::write_int16(addr_t addr, int16_t val)
{
  MEMIF_WRITE_FUNC;
}

uint32_t memif_t::read_uint32(addr_t addr)
{
  uint32_t val;
  MEMIF_READ_FUNC;
}

int32_t memif_t::read_int32(addr_t addr)
{
  int32_t val;
  MEMIF_READ_FUNC;
}

void memif_t::write_uint32(addr_t addr, uint32_t val)
{
  MEMIF_WRITE_FUNC;
}

void memif_t::write_int32(addr_t addr, int32_t val)
{
  MEMIF_WRITE_FUNC;
}

uint64_t memif_t::read_uint64(addr_t addr)
{
  uint64_t val;
  MEMIF_READ_FUNC;
}

int64_t memif_t::read_int64(addr_t addr)
{
  int64_t val;
  MEMIF_READ_FUNC;
}

void memif_t::write_uint64(addr_t addr, uint64_t val)
{
  //MEMIF_WRITE_FUNC;
  htif->write_chunk(addr, 8, &val);
}

void memif_t::write_int64(addr_t addr, int64_t val)
{
  MEMIF_WRITE_FUNC;
}

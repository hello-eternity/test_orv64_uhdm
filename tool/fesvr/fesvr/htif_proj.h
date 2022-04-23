#ifndef __HTIF_PROJ_H
#define __HTIF_PROJ_H

#include <unistd.h>
#include <fcntl.h>
#include <fstream>
#include <assert.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include "htif.h"
#include "elfloader.h"

class htif_t;

class htif_proj {
  private:
    std::string proj_id;
  public:
    std::string get_proj_id() {return proj_id;};
    virtual void setup() = 0;
    virtual void bg() = 0;
    int weighted_random(std::map<int, int> wmap) {
      int wsum = 0;
      for (std::map<int, int>::iterator it = wmap.begin(); it != wmap.end(); ++it) {
        wsum += it->second;
      }
      int rand = random() % wsum;
      wsum = 0;
      for (std::map<int, int>::iterator it = wmap.begin(); it != wmap.end(); ++it) {
        wsum += it->second;
        if (wsum >= rand) {
          return it->first;
        }
      }
      return 0;
    };
  protected:
    htif_t* ht;
    htif_proj(std::string id, htif_t* htif): proj_id(id), ht(htif) {}
  
};

#endif

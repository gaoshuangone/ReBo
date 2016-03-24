#ifndef MSPKTQUEUE_H
#define MSPKTQUEUE_H

#include "libavcodec/avcodec.h"
#include "libavformat/avformat.h"
#include "libavutil/avstring.h"

#include "msticker.h"

typedef struct PacketQueue {
    AVPacketList *first_pkt, *last_pkt;
    int nb_packets;
    int size;
    int abort_request;
    pthread_mutex_t mutex;
    pthread_cond_t cond;
} PacketQueue;

AVPacket flush_pkt;


int packet_queue_put(PacketQueue *q, AVPacket *pkt);
void packet_queue_init(PacketQueue *q);
void packet_queue_flush(PacketQueue *q);
void packet_queue_end(PacketQueue *q);
void packet_queue_abort(PacketQueue *q);
int packet_queue_get(PacketQueue *q, AVPacket *pkt, int block);


#endif


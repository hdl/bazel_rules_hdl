typedef enum
    {
    AP_START,
    AP_READY,
    AP_DONE,
    FINAL_AP_DONE,
    FINISH,
    EVENT_NUM
} hs_event;

typedef enum
    {
    SVR_MASTER,
    SVR_SLAVE
} svr_inst_type;

typedef enum
    {
    AXIS,
    AP_FIFO,
    AP_HS,
    AP_VLD,
    AP_ACK,
    AP_NONE
} svr_protocol_type;

typedef enum bit
    {
    SVR_ACTIVE,
    SVR_PASSIVE
} svr_active_passive_enum;

typedef enum bit
    {
    RESET_LEVEL_LOW,
    RESET_LEVEL_HIGH
} svr_reset_level_enum;

typedef enum 
    {
    NO_DELAY,
    LEFT_ROUND_DELAY, 
    LEFT_RND_DELAY 
} svr_delay_enum;

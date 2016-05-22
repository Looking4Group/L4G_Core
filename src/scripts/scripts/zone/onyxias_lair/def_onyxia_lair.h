
struct cPosition
{
    float x;
    float y;
    float z;
    float o;
};

enum SpawnDefinitions
{
    LEFT                 = 0,
    RIGHT                = 1,
    MAX                  = 2,
};

static cPosition spawnEntrancePoints[MAX] =
{
    {-35.8699, -161.351, -91.1765},
    {-35.813, -268.307, -91.1498}
};

enum OnyxiaData
{
    DATA_ONYXIA     = 1,
    DATA_HATCH_EGGS = 2,
    DATA_ERUPT      = 3
};

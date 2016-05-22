#include "precompiled.h"
#include "barber.h"

bool GossipHello_barber(Player *player, Creature *_Creature)
{
    int32 text = 0;
    uint8 standState = player->getStandState();
    bool sitting = true;

    if (player->IsStandState() || standState == sitting )
        sitting = false;

    // Select a gossip text
    if(!sitting)
        //text = player->GetTeam() == ALLIANCE ? 50011 : 50000;
        {
                _Creature->Whisper("Bitte setze dich auf einen Stuhl!", player->GetGUID());
                return true;
        }
    else switch (player->getRace())
    {
        case RACE_HUMAN:
            text = player->getGender() == GENDER_FEMALE ? 50013 : 50012;
            break;
        case RACE_ORC:
            text = player->getGender() == GENDER_FEMALE ? 50002 : 50001;
            break;
        case RACE_DWARF:
            text = player->getGender() == GENDER_FEMALE ? 50015 : 50014;
            break;
        case RACE_NIGHTELF:
            text = player->getGender() == GENDER_FEMALE ? 50019 : 50018;
            break;
        case RACE_UNDEAD_PLAYER:
            text = player->getGender() == GENDER_FEMALE ? 50008 : 50007;
            break;
        case RACE_TAUREN:
            text = player->getGender() == GENDER_FEMALE ? 50006 : 50005;
            break;
        case RACE_GNOME:
            text = player->getGender() == GENDER_FEMALE ? 50017 : 50016;
            break;        
        case RACE_DRAENEI:
            text = player->getGender() == GENDER_FEMALE ? 50021 : 50020;
            break;
        case RACE_TROLL:
            text = player->getGender() == GENDER_FEMALE ? 50004 : 50003;
            break;
        case RACE_BLOODELF:
            text = player->getGender() == GENDER_FEMALE ? 50010 : 50009;
            break;

            break;
    }
    // store values to restore if player choose to cancel
    hairstyle = player->GetByteValue(PLAYER_BYTES, 2); 
    haircolor = player->GetByteValue(PLAYER_BYTES, 3); 
    facialfeature = player->GetByteValue(PLAYER_BYTES_2, 0); 
    if ( sitting )
    {
        if ( !player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM))
            player->ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM);

        if ( player->GetMoney() >= 500000 )
             player->ADD_GOSSIP_ITEM(0, "Schneide mein Haar. ( 50 Gold )", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        else 
             player->ADD_GOSSIP_ITEM(0, "Du brauchst 50 Gold um den Haarschnitt zu bezahlen.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
    }
    player->SEND_GOSSIP_MENU(text,_Creature->GetGUID());
    return true;
}

void ChangeEffect(Player *player )
{
    // First Send update to player, so most recent datas are up
    player->SendCreateUpdateToPlayer(player); 

    // Force client to reload this player, so changes are visible
    WorldPacket data(SMSG_FORCE_DISPLAY_UPDATE, 8);
    data << player->GetGUID();
    player->BroadcastPacket(&data,true);

    // Do some visual effect ( Vanish visual spell )
    player->CastSpell(player,24222,true);
}

void SelectHairStyle(Player *player, int change )
{
    uint8 max=maxHairStyles[player->getRace()].maxMale;
    if ( player->getGender() == GENDER_FEMALE )
        max=maxHairStyles[player->getRace()].maxFemale;

    int current = player->GetByteValue(PLAYER_BYTES, 2);

    current += change;

    if ( current > max )
        current = 0;
    else if ( current < 0 )
        current = max;

    player->SetByteValue(PLAYER_BYTES, 2, current);
    ChangeEffect(player);
}

void SelectHairColor(Player *player, int change )
{
    uint8 max=maxHairColor[player->getRace()];
    int current = player->GetByteValue(PLAYER_BYTES, 3);

    current += change;

    if ( current > max )
        current = 0;
    else if ( current < 0 )
        current = max;

    player->SetByteValue(PLAYER_BYTES, 3, current);
    ChangeEffect(player);
}

void SelectFacialFeature(Player *player, int change )
{
    uint8 max=maxFacialFeatures[player->getRace()].maxMale;
    if ( player->getGender() == GENDER_FEMALE )
        max=maxFacialFeatures[player->getRace()].maxFemale;

    int current = player->GetByteValue(PLAYER_BYTES_2, 0); 

    current += change;

    if ( current > max )
        current = 0;
    else if ( current < 0 )
        current = max;

    player->SetByteValue(PLAYER_BYTES_2, 0, current);
    ChangeEffect(player);
}

bool GossipSelect_barber(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    char const* FeatureGossipMenu1 = "Ich brauche einen anderen Haarschnitt.";
    if (player->getRace() == RACE_TAUREN)
        FeatureGossipMenu1 = "Ich brauche eine andere Horn Art.";

    char const* FeatureGossipMenu2 = "Ich kann eine andere Haarfarbe gebrauchen.";
    if (player->getRace() == RACE_TAUREN)
        FeatureGossipMenu1 = "Ich kann eine andere Hornfarbe gebrauchen.";
    
    char const* FeatureGossipMenu = "Ich will eine andere Gesichtsbehaarung.";
    switch (player->getRace())
    {
        case RACE_HUMAN:
            if ( player->getGender() == GENDER_FEMALE )
                FeatureGossipMenu = "Ich will andere Piercings.";
            break;
        case RACE_ORC:
            if ( player->getGender() == GENDER_FEMALE )
                FeatureGossipMenu = "Ich will andere Piercings.";
            break;
        case RACE_DWARF:
            if ( player->getGender() == GENDER_FEMALE )
                FeatureGossipMenu = "Ich will andere Ohrringe.";
            break;
        case RACE_NIGHTELF:
            if ( player->getGender() == GENDER_FEMALE )
                FeatureGossipMenu = "Ich will andere Tattos.";
            break;
        case RACE_UNDEAD_PLAYER:
            FeatureGossipMenu = "Ich will andere Gesichtszuege.";
            break;
        case RACE_TAUREN:
            if ( player->getGender() == GENDER_FEMALE )
                FeatureGossipMenu = "I will anderes Haar.";
            break;
        case RACE_GNOME:
            if ( player->getGender() == GENDER_FEMALE )
                FeatureGossipMenu = "Ich will andere Ohrringe.";
            break;
        case RACE_TROLL:
            FeatureGossipMenu = "Ich will andere Hauer.";
            break;
        case RACE_BLOODELF:
            if ( player->getGender() == GENDER_FEMALE )
                FeatureGossipMenu = "Ich will andere Ohrringe.";
            break;
        case RACE_DRAENEI:
            player->getGender() == GENDER_FEMALE ? FeatureGossipMenu = "Ich will andere Hauer." : FeatureGossipMenu = "Ich will eine andere Gesichtsbehaarung.";
            break;
        }
    // MAP
    // 1 - main menu
    // 2 - next hair style
    // 3 - prev hair style
    // 4 - next hair color
    // 5 - prev hair color
    // 6 - next facial feature
    // 7 - prev facial feature
    // 8 - not enought gold, or other close

    switch (action)
    {
        // After player requested the action
        case GOSSIP_ACTION_INFO_DEF+1:   
            if ( sender == GOSSIP_SENDER_MAIN )
            {
                if(player->GetMoney() >= 500000)
                    player->ModifyMoney(-500000);
                else
                    player->SendBuyError( BUY_ERR_NOT_ENOUGHT_MONEY, _Creature, 0, 0);
            }
            player->ADD_GOSSIP_ITEM( 0, FeatureGossipMenu1, GOSSIP_SENDER_OPTION , GOSSIP_ACTION_INFO_DEF + 2);
            player->ADD_GOSSIP_ITEM( 0, FeatureGossipMenu2, GOSSIP_SENDER_OPTION , GOSSIP_ACTION_INFO_DEF + 4);
            player->ADD_GOSSIP_ITEM( 0, FeatureGossipMenu, GOSSIP_SENDER_OPTION , GOSSIP_ACTION_INFO_DEF + 6);
            player->SEND_GOSSIP_MENU(50023, _Creature->GetGUID());
            break;
        // hair style
        // next - increase hair style
        case GOSSIP_ACTION_INFO_DEF+2:
            if ( sender == GOSSIP_SENDER_SUBOPTION )
                SelectHairStyle(player,1);      
        // previous - decrease it
        case GOSSIP_ACTION_INFO_DEF+3:
            if ( action == GOSSIP_ACTION_INFO_DEF+3 && sender == GOSSIP_SENDER_SUBOPTION )
                SelectHairStyle(player,-1);                             
            // choose options again
            player->ADD_GOSSIP_ITEM( 0, "Eine andere Auswahl, bitte!", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 2);
            player->ADD_GOSSIP_ITEM( 0, "Zeig mir noch mal das vorherige!", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 3);
            player->ADD_GOSSIP_ITEM( 0, "Ich will das so behalten.", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(50024, _Creature->GetGUID());
            break;

        // hair color
        // next - increase hair color
        case GOSSIP_ACTION_INFO_DEF+4:
            if ( sender == GOSSIP_SENDER_SUBOPTION )
                SelectHairColor(player,1);      
        // previous - decrease hair color
        case GOSSIP_ACTION_INFO_DEF+5:
            if ( action == GOSSIP_ACTION_INFO_DEF+5 && sender == GOSSIP_SENDER_SUBOPTION )
                SelectHairColor(player,-1);                                     
            // choose options again
            player->ADD_GOSSIP_ITEM( 0, "Eine andere Auswahl, bitte!", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 4);
            player->ADD_GOSSIP_ITEM( 0, "Zeig mir noch mal das vorherige!",GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 5);
            player->ADD_GOSSIP_ITEM( 0, "Ich will das so behalten.", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(50024, _Creature->GetGUID());
            break;

        // facial feature
        // next - increase hair style
        case GOSSIP_ACTION_INFO_DEF+6:
            if ( sender == GOSSIP_SENDER_SUBOPTION )
                SelectFacialFeature(player,1);  
        // previous - decrease it
        case GOSSIP_ACTION_INFO_DEF+7:
            if ( action == GOSSIP_ACTION_INFO_DEF+7 && sender == GOSSIP_SENDER_SUBOPTION )
                SelectFacialFeature(player,-1);                         
            // choose options again
            player->ADD_GOSSIP_ITEM( 0, "Eine andere Auswahl, bitte!", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 6);
            player->ADD_GOSSIP_ITEM( 0, "Zeig mir noch mal das vorherige!", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 7);
            player->ADD_GOSSIP_ITEM( 0, "Ich will das so behalten.", GOSSIP_SENDER_SUBOPTION , GOSSIP_ACTION_INFO_DEF + 1);
            player->SEND_GOSSIP_MENU(50024, _Creature->GetGUID());
            break;

        // cannot affort
        case GOSSIP_ACTION_INFO_DEF+8:
            player->PlayerTalkClass->CloseGossip();
            break;

    }
    return true;
}


void AddSC_barber()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="barber";
    newscript->pGossipHello =           &GossipHello_barber;
    newscript->pGossipSelect =          &GossipSelect_barber;
    newscript->RegisterSelf();
}
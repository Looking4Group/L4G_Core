/*
 * Copyright (C) 2012 Looking4Group <http://www.looking4group.pl/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include "WorldEventProcessor.h"
#include "ObjectAccessor.h"

#include "Player.h"

void WorldEventProcessor::DestroyEvents(uint64 playerGUID/*= 0*/)
{
    ACE_GUARD(ACE_Thread_Mutex, Guard, Lock);
    for (EventList::iterator i = _events.begin(); i != _events.end();)
    {
        EventList::iterator curr = i;
        ++i;

        if (!playerGUID || playerGUID == curr->first)
        {
            delete curr->second;
            _events.erase(curr);
        }
    }
}

void WorldEventProcessor::ScheduleEvent(Player* player, WorldEvent* event)
{
    ACE_GUARD(ACE_Thread_Mutex, Guard, Lock);
    _events.insert(std::make_pair/*<uint64, WorldEvent*>*/(player->GetGUID(), event));
}

void WorldEventProcessor::ExecuteEvents()
{
    for (EventList::iterator i = _events.begin(); i != _events.end();)
    {
        EventList::iterator curr = i;
        ++i;

        // get and remove event from queue
        WorldEvent* event = curr->second;
        _events.erase(curr);

        Player* player = ObjectAccessor::GetPlayer(curr->first);
        if (player)
            event->Execute();

        delete event;
    }
}

/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#ifndef _UTIL_H
#define _UTIL_H

#include "Common.h"

#include <string>
#include <vector>

typedef std::vector<std::string> Tokens;

Tokens StrSplit(const std::string &src, const std::string &sep);

void stripLineInvisibleChars(std::string &src);

std::string secsToTimeString(uint32 timeInSecs, bool shortText = false, bool hoursOnly = false);
uint32 TimeStringToSecs(const std::string& timestring);
std::string TimeToTimestampStr(time_t t);

inline uint32 secsToTimeBitFields(time_t secs)
{
    tm* lt = localtime(&secs);
    return (lt->tm_year - 100) << 24 | lt->tm_mon  << 20 | (lt->tm_mday - 1) << 14 | lt->tm_wday << 11 | lt->tm_hour << 6 | lt->tm_min;
}

/* Return a random number in the range min..max; (max-min) must be smaller than 32768. */
int32 irand(int32 min, int32 max);

/* Return a random number in the range min..max (inclusive). For reliable results, the difference
* between max and min should be less than RAND32_MAX. */
uint32 urand(uint32 min, uint32 max);

/* Return a random number in the range min..max (inclusive). */
float frand(float min, float max);

/* Return a random number in the range 0 .. RAND32_MAX. */
int32 rand32();

/* Return a random double from 0.0 to 1.0 (exclusive). Floats support only 7 valid decimal digits.
 * A double supports up to 15 valid decimal digits and is used internally (RAND32_MAX has 10 digits).
 * With an FPU, there is usually no difference in performance between float and double. */
double rand_norm(void);

/* Return a random double from 0.0 to 99.9999999999999. Floats support only 7 valid decimal digits.
 * A double supports up to 15 valid decimal digits and is used internaly (RAND32_MAX has 10 digits).
 * With an FPU, there is usually no difference in performance between float and double. */
double rand_chance(void);

/* Return true if a random roll fits in the specified chance (range 0-100). */
inline bool roll_chance_f(float chance)
{
    return chance > rand_chance();
}

/* Return true if a random roll fits in the specified chance (range 0-100). */
inline bool roll_chance_i(int chance)
{
    return chance > irand(0, 99);
}

inline void ApplyModUInt32Var(uint32& var, int32 val, bool apply)
{
    int32 cur = var;
    cur += (apply ? val : -val);
    if(cur < 0)
        cur = 0;
    var = cur;
}

inline void ApplyModFloatVar(float& var, float  val, bool apply)
{
    var += (apply ? val : -val);
    if(var < 0)
        var = 0;
}

inline void ApplyPercentModFloatVar(float& var, float val, bool apply)
{
    if (!apply && val == -100.0f)
        val = -99.99f;

    var *= apply ? (100.0f+val)/100.0f : 100.0f / (100.0f+val);
}

bool Utf8toWStr(const std::string& utf8str, std::wstring& wstr);
// in wsize==max size of buffer, out wsize==real string size
bool Utf8toWStr(char const* utf8str, size_t csize, wchar_t* wstr, size_t& wsize);
inline bool Utf8toWStr(const std::string& utf8str, wchar_t* wstr, size_t& wsize)
{
    return Utf8toWStr(utf8str.c_str(), utf8str.size(), wstr, wsize);
}

bool WStrToUtf8(std::wstring wstr, std::string& utf8str);
// size==real string size
bool WStrToUtf8(wchar_t* wstr, size_t size, std::string& utf8str);

size_t utf8length(std::string& utf8str);                    // set string to "" if invalid utf8 sequence
void utf8truncate(std::string& utf8str,size_t len);

inline bool isBasicLatinCharacter(wchar_t wchar)
{
    if(wchar >= L'a' && wchar <= L'z')                      // LATIN SMALL LETTER A - LATIN SMALL LETTER Z
        return true;
    if(wchar >= L'A' && wchar <= L'Z')                      // LATIN CAPITAL LETTER A - LATIN CAPITAL LETTER Z
        return true;

    return false;
}

inline bool isExtendedLatinCharacter(wchar_t wchar)
{
    if(isBasicLatinCharacter(wchar))
        return true;
    if(wchar >= 0x00C0 && wchar <= 0x00D6)                  // LATIN CAPITAL LETTER A WITH GRAVE - LATIN CAPITAL LETTER O WITH DIAERESIS
        return true;
    if(wchar >= 0x00D8 && wchar <= 0x00DF)                  // LATIN CAPITAL LETTER O WITH STROKE - LATIN CAPITAL LETTER THORN
        return true;
    if(wchar == 0x00DF)                                     // LATIN SMALL LETTER SHARP S
        return true;
    if(wchar >= 0x00E0 && wchar <= 0x00F6)                  // LATIN SMALL LETTER A WITH GRAVE - LATIN SMALL LETTER O WITH DIAERESIS
        return true;
    if(wchar >= 0x00F8 && wchar <= 0x00FE)                  // LATIN SMALL LETTER O WITH STROKE - LATIN SMALL LETTER THORN
        return true;
    if(wchar >= 0x0100 && wchar <= 0x012F)                  // LATIN CAPITAL LETTER A WITH MACRON - LATIN SMALL LETTER I WITH OGONEK
        return true;
    if(wchar == 0x1E9E)                                     // LATIN CAPITAL LETTER SHARP S
        return true;
    return false;
}

inline bool isCyrillicCharacter(wchar_t wchar)
{
    if(wchar >= 0x0410 && wchar <= 0x044F)                  // CYRILLIC CAPITAL LETTER A - CYRILLIC SMALL LETTER YA
        return true;
    if(wchar == 0x0401 || wchar == 0x0451)                  // CYRILLIC CAPITAL LETTER IO, CYRILLIC SMALL LETTER IO
        return true;
    return false;
}

inline bool isEastAsianCharacter(wchar_t wchar)
{
    if(wchar >= 0x1100 && wchar <= 0x11F9)                  // Hangul Jamo
        return true;
    if(wchar >= 0x3041 && wchar <= 0x30FF)                  // Hiragana + Katakana
        return true;
    if(wchar >= 0x3131 && wchar <= 0x318E)                  // Hangul Compatibility Jamo
        return true;
    if(wchar >= 0x31F0 && wchar <= 0x31FF)                  // Katakana Phonetic Ext.
        return true;
    if(wchar >= 0x3400 && wchar <= 0x4DB5)                  // CJK Ideographs Ext. A
        return true;
    if(wchar >= 0x4E00 && wchar <= 0x9FC3)                  // Unified CJK Ideographs
        return true;
    if(wchar >= 0xAC00 && wchar <= 0xD7A3)                  // Hangul Syllables
        return true;
    if(wchar >= 0xFF01 && wchar <= 0xFFEE)                  // Halfwidth forms
        return true;
    return false;
}

inline bool isNumeric(wchar_t wchar)
{
    return (wchar >= L'0' && wchar <=L'9');
}

inline bool isNumeric(char c)
{
    return (c >= '0' && c <='9');
}

inline bool isNumericOrSpace(wchar_t wchar)
{
    return isNumeric(wchar) || wchar == L' ';
}

inline bool isBasicLatinString(std::wstring wstr, bool numericOrSpace)
{
    for(size_t i = 0; i < wstr.size(); ++i)
        if(!isBasicLatinCharacter(wstr[i]) && (!numericOrSpace || !isNumericOrSpace(wstr[i])))
            return false;
    return true;
}

inline bool isExtendedLatinString(std::wstring wstr, bool numericOrSpace)
{
    for(size_t i = 0; i < wstr.size(); ++i)
        if(!isExtendedLatinCharacter(wstr[i]) && (!numericOrSpace || !isNumericOrSpace(wstr[i])))
            return false;
    return true;
}

inline bool isCyrillicString(std::wstring wstr, bool numericOrSpace)
{
    for(size_t i = 0; i < wstr.size(); ++i)
        if(!isCyrillicCharacter(wstr[i]) && (!numericOrSpace || !isNumericOrSpace(wstr[i])))
            return false;
    return true;
}

inline bool isEastAsianString(std::wstring wstr, bool numericOrSpace)
{
    for(size_t i = 0; i < wstr.size(); ++i)
        if(!isEastAsianCharacter(wstr[i]) && (!numericOrSpace || !isNumericOrSpace(wstr[i])))
            return false;
    return true;
}

inline wchar_t wcharToUpper(wchar_t wchar)
{
    if(wchar >= L'a' && wchar <= L'z')                      // LATIN SMALL LETTER A - LATIN SMALL LETTER Z
        return wchar_t(uint16(wchar)-0x0020);
    if(wchar == 0x00DF)                                     // LATIN SMALL LETTER SHARP S
        return wchar_t(0x1E9E);
    if(wchar >= 0x00E0 && wchar <= 0x00F6)                  // LATIN SMALL LETTER A WITH GRAVE - LATIN SMALL LETTER O WITH DIAERESIS
        return wchar_t(uint16(wchar)-0x0020);
    if(wchar >= 0x00F8 && wchar <= 0x00FE)                  // LATIN SMALL LETTER O WITH STROKE - LATIN SMALL LETTER THORN
        return wchar_t(uint16(wchar)-0x0020);
    if(wchar >= 0x0101 && wchar <= 0x012F)                  // LATIN SMALL LETTER A WITH MACRON - LATIN SMALL LETTER I WITH OGONEK (only %2=1)
    {
        if(wchar % 2 == 1)
            return wchar_t(uint16(wchar)-0x0001);
    }
    if(wchar >= 0x0430 && wchar <= 0x044F)                  // CYRILLIC SMALL LETTER A - CYRILLIC SMALL LETTER YA
        return wchar_t(uint16(wchar)-0x0020);
    if(wchar == 0x0451)                                     // CYRILLIC SMALL LETTER IO
        return wchar_t(0x0401);

    return wchar;
}

inline wchar_t wcharToUpperOnlyLatin(wchar_t wchar)
{
    return isBasicLatinCharacter(wchar) ? wcharToUpper(wchar) : wchar;
}

inline wchar_t wcharToLower(wchar_t wchar)
{
    if(wchar >= L'A' && wchar <= L'Z')                      // LATIN CAPITAL LETTER A - LATIN CAPITAL LETTER Z
        return wchar_t(uint16(wchar)+0x0020);
    if(wchar >= 0x00C0 && wchar <= 0x00D6)                  // LATIN CAPITAL LETTER A WITH GRAVE - LATIN CAPITAL LETTER O WITH DIAERESIS
        return wchar_t(uint16(wchar)+0x0020);
    if(wchar >= 0x00D8 && wchar <= 0x00DE)                  // LATIN CAPITAL LETTER O WITH STROKE - LATIN CAPITAL LETTER THORN
        return wchar_t(uint16(wchar)+0x0020);
    if(wchar >= 0x0100 && wchar <= 0x012E)                  // LATIN CAPITAL LETTER A WITH MACRON - LATIN CAPITAL LETTER I WITH OGONEK (only %2=0)
    {
        if(wchar % 2 == 0)
            return wchar_t(uint16(wchar)+0x0001);
    }
    if(wchar == 0x1E9E)                                     // LATIN CAPITAL LETTER SHARP S
        return wchar_t(0x00DF);
    if(wchar == 0x0401)                                     // CYRILLIC CAPITAL LETTER IO
        return wchar_t(0x0451);
    if(wchar >= 0x0410 && wchar <= 0x042F)                  // CYRILLIC CAPITAL LETTER A - CYRILLIC CAPITAL LETTER YA
        return wchar_t(uint16(wchar)+0x0020);

    return wchar;
}

inline void wstrToUpper(std::wstring& str)
{
    std::transform( str.begin(), str.end(), str.begin(), wcharToUpper );
}

inline void wstrToLower(std::wstring& str)
{
    std::transform( str.begin(), str.end(), str.begin(), wcharToLower );
}

std::wstring GetMainPartOfName(std::wstring wname, uint32 declension);

bool utf8ToConsole(const std::string& utf8str, std::string& conStr);
bool consoleToUtf8(const std::string& conStr,std::string& utf8str);
bool Utf8FitTo(const std::string& str, std::wstring search);

#if PLATFORM == PLATFORM_WINDOWS
#define UTF8PRINTF(OUT,FRM,RESERR)                      \
{                                                       \
    char temp_buf[6000];                                \
    va_list ap;                                         \
    va_start(ap, FRM);                                  \
    size_t temp_len = vsnprintf(temp_buf,6000,FRM,ap);  \
    va_end(ap);                                         \
                                                        \
    wchar_t wtemp_buf[6000];                            \
    size_t wtemp_len = 6000-1;                          \
    if(!Utf8toWStr(temp_buf,temp_len,wtemp_buf,wtemp_len)) \
        return RESERR;                                  \
    CharToOemBuffW(&wtemp_buf[0],&temp_buf[0],wtemp_len+1);\
    fprintf(OUT,temp_buf);                              \
}
#else
#define UTF8PRINTF(OUT,FRM,RESERR)                      \
{                                                       \
    va_list ap;                                         \
    va_start(ap, FRM);                                  \
    vfprintf(OUT, FRM, ap );                            \
    va_end(ap);                                         \
}
#endif

bool IsIPAddress(char const* ipaddress);
uint32 CreatePIDFile(const std::string& filename);

#endif


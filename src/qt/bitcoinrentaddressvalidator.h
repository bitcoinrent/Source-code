// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOINRENT_QT_BITCOINRENTADDRESSVALIDATOR_H
#define BITCOINRENT_QT_BITCOINRENTADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinRentAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinRentAddressEntryValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

/** BitcoinRent address widget validator, checks for a valid bitcoinrent address.
 */
class BitcoinRentAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinRentAddressCheckValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

#endif // BITCOINRENT_QT_BITCOINRENTADDRESSVALIDATOR_H

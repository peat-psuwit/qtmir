/*
 * Copyright (C) 2013-2015 Canonical, Ltd.
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License version 3, as published by
 * the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranties of MERCHANTABILITY,
 * SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "nativeinterface.h"

NativeInterface::NativeInterface(const QWeakPointer<MirServer> &server)
    : m_mirServer(server)
{
}

void *NativeInterface::nativeResourceForIntegration(const QByteArray &resource)
{
    void *result = nullptr;

    auto const server = m_mirServer.lock();

    if (server) {
        if (resource == "SessionAuthorizer")
            result = server->sessionAuthorizer();
        else if (resource == "Shell")
            result = server->shell();
        else if (resource == "SessionListener")
            result = server->sessionListener();
        else if (resource == "PromptSessionListener")
            result = server->promptSessionListener();
    }
    return result;
}

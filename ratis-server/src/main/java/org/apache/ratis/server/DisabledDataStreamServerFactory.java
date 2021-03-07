/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.ratis.server;

import org.apache.ratis.conf.Parameters;
import org.apache.ratis.datastream.SupportedDataStreamType;
import org.apache.ratis.protocol.RaftPeer;

import java.net.InetSocketAddress;
import java.util.Collection;

/** A stream factory that does nothing when data stream is disabled. */
public class DisabledDataStreamServerFactory implements DataStreamServerFactory {
  public DisabledDataStreamServerFactory(Parameters parameters) {}

  @Override
  public DataStreamServerRpc newDataStreamServerRpc(RaftServer server) {
    return new DataStreamServerRpc() {
      @Override
      public void start() {}

      @Override
      public InetSocketAddress getInetSocketAddress() {
        return null;
      }

      @Override
      public void close() {}

      @Override
      public void addRaftPeers(Collection<RaftPeer> peers) {}
    };
  }

  @Override
  public SupportedDataStreamType getDataStreamType() {
    return SupportedDataStreamType.DISABLED;
  }
}
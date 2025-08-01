// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// @generated by protoc-gen-es v2.6.2 with parameter "target=ts,import_extension=none"
// @generated from file google/type/latlng.proto (package google.type, syntax proto3)
/* eslint-disable */

import type { GenFile, GenMessage } from "@bufbuild/protobuf/codegenv2";
import { fileDesc, messageDesc } from "@bufbuild/protobuf/codegenv2";
import type { Message } from "@bufbuild/protobuf";

/**
 * Describes the file google/type/latlng.proto.
 */
export const file_google_type_latlng: GenFile = /*@__PURE__*/
  fileDesc("Chhnb29nbGUvdHlwZS9sYXRsbmcucHJvdG8SC2dvb2dsZS50eXBlIi0KBkxhdExuZxIQCghsYXRpdHVkZRgBIAEoARIRCglsb25naXR1ZGUYAiABKAFCqAEKD2NvbS5nb29nbGUudHlwZUILTGF0bG5nUHJvdG9QAVo4Z29vZ2xlLmdvbGFuZy5vcmcvZ2VucHJvdG8vZ29vZ2xlYXBpcy90eXBlL2xhdGxuZztsYXRsbmf4AQGiAgNHVFiqAgtHb29nbGUuVHlwZcoCC0dvb2dsZVxUeXBl4gIXR29vZ2xlXFR5cGVcR1BCTWV0YWRhdGHqAgxHb29nbGU6OlR5cGViBnByb3RvMw");

/**
 * An object that represents a latitude/longitude pair. This is expressed as a
 * pair of doubles to represent degrees latitude and degrees longitude. Unless
 * specified otherwise, this must conform to the
 * <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
 * standard</a>. Values must be within normalized ranges.
 *
 * @generated from message google.type.LatLng
 */
export type LatLng = Message<"google.type.LatLng"> & {
  /**
   * The latitude in degrees. It must be in the range [-90.0, +90.0].
   *
   * @generated from field: double latitude = 1;
   */
  latitude: number;

  /**
   * The longitude in degrees. It must be in the range [-180.0, +180.0].
   *
   * @generated from field: double longitude = 2;
   */
  longitude: number;
};

/**
 * Describes the message google.type.LatLng.
 * Use `create(LatLngSchema)` to create a new message.
 */
export const LatLngSchema: GenMessage<LatLng> = /*@__PURE__*/
  messageDesc(file_google_type_latlng, 0);


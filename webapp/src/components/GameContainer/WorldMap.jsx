import React from 'react';
import styles from './WorldMap.module.css';
import {
  ComposableMap,
  Geographies,
  Geography,
  Marker
} from "react-simple-maps";

export default () => {
  const geoUrl =
    "https://raw.githubusercontent.com/zcreativelabs/react-simple-maps/master/topojson-maps/world-50m.json";

  const markers = [
    {
      markerOffset: -30,
      name: "South America",
      coordinates: [-58, -13]
    },
  ];

  return (
    <ComposableMap
      projectionConfig={{
        rotate: [0, 0, 0],
      }}
      className={styles.MapDisplay}
    >
      <Geographies geography={geoUrl}>
        {({ geographies, projection }) =>
          geographies.map((geo, i) => {
            if (geo.properties.NAME !== 'Antarctica') {
              let fillColor = '#999999';
              switch (geo.properties.CONTINENT) {
                case 'North America':
                  fillColor = '#00AD76';
                  break;
                case 'South America':
                  fillColor = '#FF8C08';
                  break;
                case 'Africa':
                  fillColor = '#4287F5';
                  break;
                case 'Europe':
                  fillColor = '#FF4026';
                  break;
                case 'Asia':
                  fillColor = '#FFE100';
                  break;
                case 'Oceania':
                  fillColor = '#50DB00';
                  break;
                default:
                  fillColor = '#999999';
              }
              return (
                <Geography
                  className={styles.country}
                  onClick={() => console.log(geo.properties.NAME)}
                  key={i}
                  geography={geo}
                  projection={projection}
                  fill={fillColor}
                />
              );
            } else {
              return undefined;
            }
          })
        }
      </Geographies>
      {markers.map(({ name, coordinates, markerOffset }) => (
        <Marker key={name} coordinates={coordinates} className={styles.marker}>
          <g
            fill="none"
            stroke="#FF5533"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            transform="translate(-12, -24)"
          >
            <circle cx="12" cy="10" r="3" />
            <path d="M12 21.7C17.3 17 20 13 20 10a8 8 0 1 0-16 0c0 3 2.7 6.9 8 11.7z" />
          </g>
          <text
            textAnchor="middle"
            y={markerOffset}
            style={{ fontFamily: "system-ui", fill: "#000000" }}
          >
            {name}
          </text>
        </Marker>
      ))}
    </ComposableMap>
  );
}
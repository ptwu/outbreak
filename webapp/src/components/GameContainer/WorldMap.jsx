import React, { memo } from 'react';
import styles from './WorldMap.module.css';
import {
  ComposableMap,
  Geographies,
  Geography,
  Marker
} from 'react-simple-maps';

const WorldMap = ({ setContent }) => {
  const geoUrl =
    'https://raw.githubusercontent.com/zcreativelabs/react-simple-maps/master/topojson-maps/world-50m.json';


  const markers = [
    {
      markerOffset: -30,
      name: 'South America',
      coordinates: [-58, -13]
    },
    {
      markerOffset: -30,
      name: 'North America',
      coordinates: [-93.5, 39]
    },
    {
      markerOffset: -30,
      name: 'Europe',
      coordinates: [22.844, 44.924]
    },
    {
      markerOffset: -30,
      name: 'Africa',
      coordinates: [20.737, 3.137]
    },
    {
      markerOffset: -30,
      name: 'Asia',
      coordinates: [90.44, 35]
    },
    {
      markerOffset: -30,
      name: 'Oceania',
      coordinates: [134.7, -27]
    },
  ];
  const getContinentData = (id) => {
    console.log(id);
    return {
      'name': 'South America',
      'healthy': 1000000,
      'infected': 1000,
      'dead': 10
    }
  }

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
                  fillColor = '#999999';
                  break;
                case 'South America':
                  fillColor = '#d1a7a7';
                  break;
                case 'Africa':
                  fillColor = '#999999';
                  break;
                case 'Europe':
                  fillColor = '#999999';
                  break;
                case 'Asia':
                  fillColor = '#999999';
                  break;
                case 'Oceania':
                  fillColor = '#999999';
                  break;
                default:
                  fillColor = '#999999';
              }
              return (
                <Geography
                  className={styles.country}
                  key={i}
                  geography={geo}
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
        <Marker
          key={name}
          coordinates={coordinates}
          className={styles.marker}
          onClick={() => console.log(name)}
          data-tip=""
        >
          <g
            fill="none"
            stroke="#000000"
            strokeWidth="3.5"
            strokeLinecap="round"
            strokeLinejoin="round"
            transform="translate(-12, -24)"
            className={styles.marker}
            onMouseEnter={() => {
              setContent(`Healthy: ${getContinentData(name).healthy}  |  
              Infected: ${getContinentData(name).infected}  |  
              Dead: ${getContinentData(name).dead}`);
            }}
            onMouseLeave={() => {
              setContent('');
            }}
          >
            <circle cx="12" cy="10" r="3" />
            <path d="M12 21.7C17.3 17 20 13 20 10a8 8 0 1 0-16 0c0 3 2.7 6.9 8 11.7z" />
          </g>
          <text
            textAnchor="middle"
            y={markerOffset}
            style={{ fontFamily: 'system-ui', fill: '#000000', fontWeight: 'bold' }}
            className={styles.marker}
            onMouseEnter={() => {
              setContent(`Healthy: ${getContinentData(name).healthy}  |  
              Infected: ${getContinentData(name).infected}  |  
              Dead: ${getContinentData(name).dead}`);
            }}
            onMouseLeave={() => {
              setContent('');
            }}
          >
            {name}
          </text>
        </Marker>
      ))}
    </ComposableMap>
  );
}

export default memo(WorldMap);
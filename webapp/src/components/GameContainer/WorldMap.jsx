import React, { memo, useState } from 'react';
import styles from './WorldMap.module.css';
import geoUrl from './world-50m.json';
import {
  ComposableMap,
  Geographies,
  Geography,
  Marker
} from 'react-simple-maps';

const WorldMap = ({ setContent, pickCountryHandler, data }) => {
  const [isInPickMode, setMode] = useState(true);

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
    if (data !== undefined) {
      const continent = data.find((a => a.info.name === id));
      if (continent !== undefined) {
        return {
          'name': continent.info.name,
          'healthy': continent.population.healthy,
          'infected': continent.population.infected,
          'dead': continent.population.dead
        }
      } else {
        return {
          'name': id,
          'healthy': 'Loading...',
          'infected': 'Loading...',
          'dead': 'Loading...'
        }
      }
    } else {
      return {
        'name': id,
        'healthy': 'Loading...',
        'infected': 'Loading...',
        'dead': 'Loading...'
      }
    }
  }

  const getContinentColor = (id) => {
    if (data !== undefined) {
      const continent = data.find((a => a.info.name === id));
      if (continent !== undefined) {
        const { population } = continent;
        const { healthy, infected, dead } = population;
        const percentage = healthy / (healthy + infected + dead);
        const red = Math.floor(255 - (255 * percentage));
        const green = Math.floor(255 * percentage);
        const blue = 0
        return rgbToHex(red, green, blue);
      } else {
        return '#999999';
      }
    } else {
      return '#999999';
    }
  }

  function componentToHex(c) {
    var hex = c.toString(16);
    return hex.length == 1 ? "0" + hex : hex;
  }

  function rgbToHex(r, g, b) {
    return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
  }

  if (isInPickMode) {
    return (
      <ComposableMap
        projectionConfig={{
          rotate: [0, 0, 0],
        }}
        className={styles.MapDisplay}
      >
        <Geographies geography={geoUrl}>
          {({ geographies }) =>
            geographies.map((geo, i) => {
              if (geo.properties.NAME !== 'Antarctica') {
                const fillColor = '#999999';
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
            onClick={() => { setMode(false); pickCountryHandler(name); }}
            data-tip=""
            onMouseEnter={() => {
              setContent(`Start Outbreak in ${name}`);
            }}
            onMouseLeave={() => {
              setContent('');
            }}
          >
            <g
              fill="none"
              stroke="#000000"
              strokeWidth="3.5"
              strokeLinecap="round"
              strokeLinejoin="round"
              transform="translate(-12, -24)"
              className={styles.marker}
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
                setContent(`Start Outbreak in ${name}`);
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
  } else {
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
                let fillColor = getContinentColor(geo.properties.CONTINENT);

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
}

export default memo(WorldMap);
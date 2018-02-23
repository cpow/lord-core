const getProperty = (object, propertyName) => {
  const parts = propertyName.split('.');
  const { length } = parts;
  let property = object;

  for (let i = 0; i < length; i += 1) {
    property = property[parts[i]];
  }

  return property;
};

export default getProperty;

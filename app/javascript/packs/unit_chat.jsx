import React from 'react';
import ReactDOM from 'react-dom';
import Chat from 'components/units/Chat';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('unitId');
  const unitId = JSON.parse(node.getAttribute('data-unit-id'));

  const messageableNode = document.getElementById('messageable');

  const messageableId = JSON.parse(messageableNode.getAttribute('data-id'));
  const messageableType = messageableNode.getAttribute('data-type');

  ReactDOM.render(
    <Chat
      unitId={unitId}
      messageableType={messageableType}
      messageableId={messageableId}
    />,

    document.body.appendChild(document.createElement('div')),
  );
});


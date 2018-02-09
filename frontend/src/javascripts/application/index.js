import Rails from 'rails-ujs';
import Hello from './Hello';

const initializeHello = () => {
  const hello = new Hello();
  hello.soundEuphonium();
};

const setup = () => {
  initializeHello();
  Rails.start();
};

setup();

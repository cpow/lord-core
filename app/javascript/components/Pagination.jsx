import React from 'react';
import PropTypes from 'prop-types';

const Pagination = ({
  page, nextPage, prevPage, totalPages,
}) => (
  <nav aria-label="Pagination">
    <ul className="pagination justify-content-center">
      <li className="page-item float-left">
        <button
          className="page-link"
          onClick={prevPage}
        >
          Previous
        </button>
      </li>
      <li className="page-item disabled">
        <button
          className="page-link"
        >
          {page} of {totalPages}
        </button>
      </li>
      <li className="page-item float-right">
        <button
          className="page-link"
          onClick={nextPage}
        >
          Next
        </button>
      </li>
    </ul>
  </nav>
);

Pagination.propTypes = {
  page: PropTypes.number.isRequired,
  nextPage: PropTypes.func.isRequired,
  prevPage: PropTypes.func.isRequired,
};

export default Pagination;

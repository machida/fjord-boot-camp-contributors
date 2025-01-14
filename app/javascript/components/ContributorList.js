import React from "react"
import PropTypes from "prop-types"

class ContributorList extends React.Component {
  constructor(props){
    super(props)
    this.state = {initialContributors: this.props.ranks, ranks:[]}
  }

  componentDidMount() { 
    this.setState({ranks: this.state.initialContributors})
  }

  render() {
    return (
      <Contributors ranks={this.state.ranks} />
    )
  }
}

const Contributors = (props) => {
  return (
    <div className="showing_contributors">
      <p className="contributors_count">Showing {props.ranks.length} people</p>

      <table className="contributors_table">
        <thead>
          <tr>
            <th className='table_header'>  </th>
            <th className='table_header'><p className='table_header-name'>Name</p></th>
            <th className='table_header'><p className='table_header-commits_count'>Commits</p></th></tr>
        </thead>
        <tbody>
          {props.ranks.map((contributor) =>
            <ContributorInfo contributor={contributor} key={contributor.id} topCommits={props.ranks[0].commits} /> )}
        </tbody>
      </table>
    </div>
  )
}

Contributors.propTypes = {
  ranks: PropTypes.array.isRequired
}

const ContributorInfo = (props) => {
  const {rank, avatar_url, path, name, first_committed_on, commits} = props.contributor
  const width = (rank === 1) ? { width: '100%'} : { width: ((commits/props.topCommits)*100)+'%'}

  return (
    <tr className="contributors_table-row">
      <td className='table_data_rank'>#{rank}</td>
      <td className='table_data_contributors-info' >
        <div className='contributors_info'>
          <img className='contributors_avatar' src={avatar_url} />
          <div className='contributor_name_since'>
            <a className='contributors_name' href={path}>  {name}  </a>
            <p className='contributors_since'>since {first_committed_on}</p>
          </div>
        </div>
      </td>
      <td className='table_data_graph'>
        <span className="contributors_horizontal_bar" style={width}>
          <p className='contributors_commits'>{commits}</p>
        </span>
      </td>
    </tr>
  )
}

ContributorInfo.propTypes = {
  contributor: PropTypes.object.isRequired
}

export default ContributorList

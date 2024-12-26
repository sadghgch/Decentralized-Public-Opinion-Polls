// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedPolls {
    struct Poll {
        string question;
        string[] options;
        uint256 startTime;
        uint256 endTime;
        address creator;
        bool exists;
        mapping(uint256 => uint256) voteCounts; // optionId => count
        mapping(address => bool) hasVoted;
    }

    struct PollInfo {
        string question;
        string[] options;
        uint256 startTime;
        uint256 endTime;
        address creator;
        uint256[] voteCounts;
    }

    mapping(uint256 => Poll) public polls;
    uint256 public pollCount;

    event PollCreated(uint256 indexed pollId, string question, address creator);
    event VoteCast(uint256 indexed pollId, address indexed voter, uint256 optionId);

    modifier pollExists(uint256 _pollId) {
        require(polls[_pollId].exists, "Poll does not exist");
        _;
    }

    modifier pollActive(uint256 _pollId) {
        require(
            block.timestamp >= polls[_pollId].startTime &&
            block.timestamp <= polls[_pollId].endTime,
            "Poll is not active"
        );
        _;
    }

    modifier hasNotVoted(uint256 _pollId) {
        require(!polls[_pollId].hasVoted[msg.sender], "Already voted in this poll");
        _;
    }

    function createPoll(
        string memory _question,
        string[] memory _options,
        uint256 _durationInDays
    ) external returns (uint256) {
        require(_options.length >= 2, "Minimum 2 options required");
        require(_durationInDays > 0, "Duration must be positive");

        uint256 pollId = pollCount++;
        Poll storage newPoll = polls[pollId];

        newPoll.question = _question;
        newPoll.options = _options;
        newPoll.startTime = block.timestamp;
        newPoll.endTime = block.timestamp + (_durationInDays * 1 days);
        newPoll.creator = msg.sender;
        newPoll.exists = true;

        emit PollCreated(pollId, _question, msg.sender);
        return pollId;
    }

    function vote(uint256 _pollId, uint256 _optionId) external 
        pollExists(_pollId)
        pollActive(_pollId)
        hasNotVoted(_pollId)
    {
        require(_optionId < polls[_pollId].options.length, "Invalid option");

        polls[_pollId].voteCounts[_optionId]++;
        polls[_pollId].hasVoted[msg.sender] = true;

        emit VoteCast(_pollId, msg.sender, _optionId);
    }

    function getPollInfo(uint256 _pollId) external view 
        pollExists(_pollId) 
        returns (PollInfo memory) 
    {
        Poll storage poll = polls[_pollId];
        uint256[] memory voteCounts = new uint256[](poll.options.length);
        
        for (uint256 i = 0; i < poll.options.length; i++) {
            voteCounts[i] = poll.voteCounts[i];
        }

        return PollInfo({
            question: poll.question,
            options: poll.options,
            startTime: poll.startTime,
            endTime: poll.endTime,
            creator: poll.creator,
            voteCounts: voteCounts
        });
    }

    function isPollActive(uint256 _pollId) external view 
        pollExists(_pollId) 
        returns (bool) 
    {
        return (
            block.timestamp >= polls[_pollId].startTime &&
            block.timestamp <= polls[_pollId].endTime
        );
    }

    function hasUserVoted(uint256 _pollId, address _user) external view 
        pollExists(_pollId) 
        returns (bool) 
    {
        return polls[_pollId].hasVoted[_user];
    }
}
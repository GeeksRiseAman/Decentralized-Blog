// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedBlog {
    // Struct to represent a blog post
    struct Post {
        address author;
        string title;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    // Array to store all blog posts
    Post[] public posts;

    // Mapping to track which users have liked a post
    mapping(uint256 => mapping(address => bool)) public postLikes;

    // Event to log when a new post is created
    event PostCreated(
        uint256 indexed postId, 
        address indexed author, 
        string title, 
        uint256 timestamp
    );

    // Event to log when a post is liked
    event PostLiked(
        uint256 indexed postId, 
        address indexed liker
    );

    // Function to create a new blog post
    function createPost(string memory _title, string memory _content) public {
        // Ensure title and content are not empty
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_content).length > 0, "Content cannot be empty");

        // Create a new post
        Post memory newPost = Post({
            author: msg.sender,
            title: _title,
            content: _content,
            timestamp: block.timestamp,
            likes: 0
        });

        // Add post to the posts array and get its ID
        uint256 postId = posts.length;
        posts.push(newPost);

        // Emit event for post creation
        emit PostCreated(postId, msg.sender, _title, block.timestamp);
    }

    // Function to like a blog post
    function likePost(uint256 _postId) public {
        // Ensure post ID is valid
        require(_postId < posts.length, "Invalid post ID");

        // Prevent multiple likes from the same address
        require(!postLikes[_postId][msg.sender], "You have already liked this post");

        // Mark post as liked by this address
        postLikes[_postId][msg.sender] = true;

        // Increment likes for the post
        posts[_postId].likes++;

        // Emit event for post like
        emit PostLiked(_postId, msg.sender);
    }

    // Function to retrieve all posts (view function)
    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }
}
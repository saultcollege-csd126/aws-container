reflections

--if my app was accessible, the presigned urls would allow users to access the photos without having to update the policy on the bucket or changing its privacy settings -> the url 'retains' the authorization of the account that created it to access a specific object, not the entire bucket. 

--the two GSIs created are relevant to the app we created and can be used for filtering the feed by privacy status. Hash keys are used for fields with many unique values which is why user ids and media ids are a good choice for them, and the range key (uploaded at) provide a way to sort entries. You can retain the sorting of range ket while actively filtering for privacy settings, which preserves the order of the feed.


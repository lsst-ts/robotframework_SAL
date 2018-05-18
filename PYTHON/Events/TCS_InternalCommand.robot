*** Settings ***
Documentation    TCS_InternalCommand sender/logger tests.
Force Tags    python    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 241 216 84 255 123 181 29 68 69 26 145 40 164 160 49 106 57 94 54 37 202 255 249 71 193 172 204 79 211 189 47 144 228 105 145 57 130 213 39 93 200 17 138 172 200 88 72 42 86 158 197 137 34 165 179 247 31 12 156 45 171 142 37 234 137 122 108 65 113 186 190 66 167 6 213 224 212 254 73 183 231 213 196 219 172 125 54 196 95 70 153 115 86 3 51 3 188 101 178 25 43 209 235 106 134 41 253 71 213 29 43 64 241 187 233 40 103 72 129 1 99 223 48 57 153 143 222 189 173 152 8 153 194 194 154 124 219 142 113 255 213 117 48 39 34 151 153 100 218 204 148 100 161 80 97 181 222 197 71 105 70 238 145 98 61 227 221 155 46 140 240 49 136 255 126 55 94 74 213 144 147 209 1 85 200 141 4 52 239 243 134 28 249 174 213 145 109 139 89 140 245 135 33 72 88 229 75 179 111 32 48 56 137 10 54 247 41 81 7 83 6 159 94 137 202 75 177 16 241 91 68 155 126 153 135 35 141 30 152 95 27 201 79 68 7 103 102 42 63 17 145 229 220 121 140 250 234 72 125 7 0 85 153 46 106 74 190 9 213 121 138 3 187 241 135 251 37 208 186 114 203 198 77 240 108 154 176 4 217 114 241 179 163 89 149 15 94 138 59 89 103 47 245 158 184 122 69 188 64 222 237 49 20 83 76 99 96 165 106 7 25 212 101 20 227 221 206 106 236 47 10 37 190 128 174 115 149 203 227 167 29 185 126 0 206 212 59 242 164 82 218 99 245 55 51 193 208 51 248 147 193 101 246 26 238 168 2 175 231 74 161 249 16 2 212 121 171 142 72 52 52 121 73 62 166 160 53 188 121 127 179 113 6 251 174 76 109 198 89 105 243 81 171 96 229 56 51 0 162 90 47 107 35 204 224 110 61 142 59 70 57 187 61 17 38 96 132 231 39 123 0 218 17 138 229 118 227 10 122 53 216 252 121 207 38 51 130 150 176 214 202 178 158 224 124 30 184 212 12 2 172 251 200 195 215 172 87 160 136 89 134 150 71 39 216 253 28 158 34 240 179 217 156 30 39 178 18 209 34 136 190 139 218 193 108 130 9 113 196 102 106 67 173 181 193 180 122 77 97 153 237 32 73 30 70 166 193 42 106 232 209 58 38 117 236 88 106 32 47 4 241 75 215 5 72 153 53 90 161 66 176 23 195 188 236 121 186 63 19 53 36 63 83 199 3 243 88 224 123 3 101 138 222 17 103 181 214 122 26 162 93 149 185 189 239 157 75 206 14 157 117 192 245 35 253 82 225 156 242 80 74 167 191 91 193 253 137 103 176 225 83 249 179 102 44 136 103 167 60 59 89 31 165 146 71 67 218 238 55 246 67 59 29 243 186 38 242 132 179 5 161 23 219 238 22 72 130 93 247 134 171 125 39 87 46 143 215 110 131 42 22 221 92 57 225 1 45 89 189 38 185 24 121 161 23 185 163 132 80 124 177 42 119 9 104 239 183 193 170 222 19 118 49 92 38 19 204 70 130 70 64 233 25 37 92 169 89 231 121 120 31 28 97 183 201 193 63 108 141 17 84 87 72 10 116 17 169 71 175 45 204 16 200 14 142 223 251 80 239 200 35 51 194 143 230 0 171 212 89 107 117 12 34 112 136 20 156 48 81 234 86 62 174 164 101 51 128 128 56 168 198 243 127 149 245 247 186 198 99 205 99 240 218 234 197 54 138 61 179 74 211 23 236 83 141 136 226 103 238 213 5 128 98 33 125 37 228 22 228 57 142 80 124 120 20 210 25 162 249 81 166 5 251 250 172 78 71 164 152 198 182 125 82 208 4 55 12 128 114 173 26 155 7 254 208 96 254 227 147 8 104 162 13 147 76 44 110 254 34 25 170 176 135 216 227 183 8 197 75 246 0 154 197 232 106 208 81 70 239 93 152 162 27 0 199 98 141 236 157 33 62 210 255 197 208 79 206 151 130 220 97 98 235 207 63 234 40 47 222 28 232 45 77 253 7 177 56 79 145 133 231 193 150 53 186 192 129 145 168 200 255 56 162 226 114 196 237 172 197 127 215 247 244 54 99 241 129 132 255 172 28 119 31 185 99 131 175 100 101 189 167 81 238 227 191 17 249 33 15 149 179 142 186 193 199 136 100 251 229 203 198 9 185 39 44 3 238 212 192 32 139 235 183 229 44 28 199 80 214 152 191 250 181 145 1 169 32 88 216 140 -1541021070
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
